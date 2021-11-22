part of 'week_day_bloc.dart';

abstract class WeekDayEvent {}

class GetCurrentWeekDay extends WeekDayEvent {}

class WeekDayChanged extends WeekDayEvent {
  final int selectedDay;
  final int currentWeek;

  WeekDayChanged({
    required this.selectedDay,
    required this.currentWeek,
  });
}
