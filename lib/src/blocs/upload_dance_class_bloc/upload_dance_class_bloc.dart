import 'package:bloc/bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:moove_dance_studio/moove_dance_studio.dart';

part 'upload_dance_class_event.dart';
part 'upload_dance_class_state.dart';

class UploadDanceClassBloc extends Bloc<UploadDanceClassEvent, UploadDanceClassState> {
  final DatabaseReference databaseReference;

  UploadDanceClassBloc({required FirebaseDatabase database})
      : databaseReference = database.reference().child("Dance Class"),
        super(UploadDanceClassInitial());

  @override
  Stream<UploadDanceClassState> mapEventToState(UploadDanceClassEvent event) async* {
    if (event is DanceClassUploaded) {
      yield UploadDanceClassInProgress();
      try {
        await databaseReference.push().set(
              event.danceClass.toJson(),
            );
        yield UploadDanceClassSuccess();
      } catch (_) {
        yield UploadDanceClassFailure();
      }
    }
  }
}
