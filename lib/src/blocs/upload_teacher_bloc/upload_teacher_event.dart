part of 'upload_teacher_bloc.dart';

abstract class UploadTeacherEvent {}

class TeacherUploaded extends UploadTeacherEvent {
  final Teacher teacher;

  TeacherUploaded({required this.teacher});
}
