part of 'week_selector_bloc.dart';

abstract class WeekSelectorEvent {}

class GetCurrentWeek extends WeekSelectorEvent {}

class WeekChanged extends WeekSelectorEvent {
  final int currentDay;
  final int currentWeekNumber;
  final bool isNextWeek;

  WeekChanged({
    required this.currentDay,
    required this.currentWeekNumber,
    this.isNextWeek = true,
  });
}
