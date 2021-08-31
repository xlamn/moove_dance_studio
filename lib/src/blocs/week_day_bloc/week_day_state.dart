part of 'week_day_bloc.dart';

abstract class WeekDayState {}

class WeekDayInitial extends WeekDayState {}

class WeekDayChangedSuccess extends WeekDayState {
  final int selectedDay;
  WeekDayChangedSuccess({required this.selectedDay});
}

class WeekDayChangedFailure extends WeekDayState {}
