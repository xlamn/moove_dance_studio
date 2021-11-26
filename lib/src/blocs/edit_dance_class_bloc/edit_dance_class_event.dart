part of 'edit_dance_class_bloc.dart';

abstract class EditDanceClassEvent {}

class EditDanceClassStarted extends EditDanceClassEvent {}

class EditDanceClassUpdated extends EditDanceClassEvent {}

class EditDanceClassDeleted extends EditDanceClassEvent {
  final DanceClass danceClass;

  EditDanceClassDeleted({required this.danceClass});
}
