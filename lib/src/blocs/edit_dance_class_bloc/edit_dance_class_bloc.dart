import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moove_dance_studio/moove_dance_studio.dart';

part 'edit_dance_class_event.dart';
part 'edit_dance_class_state.dart';

class EditDanceClassBloc extends Bloc<EditDanceClassEvent, EditDanceClassState> {
  final DatabaseReference databaseReference;

  EditDanceClassBloc({required FirebaseDatabase database})
      : databaseReference = database.reference().child("Dance Class"),
        super(EditDanceClassInitial());

  @override
  Stream<EditDanceClassState> mapEventToState(EditDanceClassEvent event) async* {
    if (event is EditDanceClassStarted) {
      yield EditDanceClassStartSuccess();
    } else if (event is EditDanceClassUpdated) {
      yield EditDanceClassUpdateInProgress();
      yield EditDanceClassUpdateSuccess();
    } else if (event is EditDanceClassDeleted) {
      yield EditDanceClassDeleteInProgress();
      try {
        final danceClassTime = event.danceClass.time.toString().replaceFirst(' ', 'T');
        await databaseReference.orderByChild('time').equalTo(danceClassTime).once().then((snapshot) {
          Map<dynamic, dynamic> danceClasses = snapshot.value;
          danceClasses.forEach((key, value) {
            databaseReference.child(key).remove();
          });
        });
        yield EditDanceClassDeleteSuccess();
      } catch (_) {
        yield EditDanceClassDeleteFailure();
      }
    }
  }
}
