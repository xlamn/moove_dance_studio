part of 'edit_dance_class_bloc.dart';

abstract class EditDanceClassState {}

class EditDanceClassInitial extends EditDanceClassState {}

class EditDanceClassStartSuccess extends EditDanceClassState {}

class EditDanceClassStartFailure extends EditDanceClassState {}

class EditDanceClassUpdateSuccess extends EditDanceClassState {}

class EditDanceClassUpdateInProgress extends EditDanceClassState {}

class EditDanceClassUpdateFailure extends EditDanceClassState {}

class EditDanceClassDeleteInProgress extends EditDanceClassState {}

class EditDanceClassDeleteSuccess extends EditDanceClassState {}

class EditDanceClassDeleteFailure extends EditDanceClassState {}
