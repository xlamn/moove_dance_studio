part of 'upload_dance_class_bloc.dart';

abstract class UploadDanceClassEvent {}

class DanceClassUploaded extends UploadDanceClassEvent {
  final DanceClass danceClass;

  DanceClassUploaded({required this.danceClass});
}
