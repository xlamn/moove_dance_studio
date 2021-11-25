import 'package:bloc/bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:moove_dance_studio/moove_dance_studio.dart';

part 'upload_teacher_event.dart';
part 'upload_teacher_state.dart';

class UploadTeacherBloc extends Bloc<UploadTeacherEvent, UploadTeacherState> {
  final DatabaseReference databaseReference;

  UploadTeacherBloc({required FirebaseDatabase database})
      : databaseReference = database.reference().child("Teacher"),
        super(UploadTeacherInitial());

  @override
  Stream<UploadTeacherState> mapEventToState(UploadTeacherEvent event) async* {
    if (event is TeacherUploaded) {
      yield UploadTeacherInProgress();
      try {
        await databaseReference.push().set(
              event.teacher.toJson(),
            );
        yield UploadTeacherSuccess();
      } catch (_) {
        yield UploadTeacherFailure();
      }
    }
  }
}
