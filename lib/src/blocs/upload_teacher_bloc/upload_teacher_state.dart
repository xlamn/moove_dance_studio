part of 'upload_teacher_bloc.dart';

abstract class UploadTeacherState {}

class UploadTeacherInitial extends UploadTeacherState {}

class UploadTeacherInProgress extends UploadTeacherState {}

class UploadTeacherSuccess extends UploadTeacherState {}

class UploadTeacherFailure extends UploadTeacherState {}
