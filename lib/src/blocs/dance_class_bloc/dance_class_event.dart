part of 'dance_class_bloc.dart';

abstract class DanceClassEvent {}

class DanceClassStarted extends DanceClassEvent {}

class DanceClassFetched extends DanceClassEvent {
  int currentDay;
  int currentWeek;

  DanceClassFetched({
    required this.currentDay,
    required this.currentWeek,
  });
}
