part of 'week_day_bloc.dart';

abstract class WeekDayEvent {}

class WeekDayChanged extends WeekDayEvent {
  final int selectedDay;

  WeekDayChanged({required this.selectedDay});
}
