part of 'dance_class_bloc.dart';

abstract class DanceClassState {}

class DanceClassInitial extends DanceClassState {}

class DanceClassFetchInProgress extends DanceClassState {}

class DanceClassFetchSuccess extends DanceClassState {
  final List<DanceClass> danceClasses;
  DanceClassFetchSuccess({required this.danceClasses});
}

class DanceClassFetchFailure extends DanceClassState {}
