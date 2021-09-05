part of 'week_selector_bloc.dart';

abstract class WeekSelectorEvent {}

class GetCurrentWeek extends WeekSelectorEvent {}

class WeekChanged extends WeekSelectorEvent {
  final int currentWeekNumber;
  final bool isNextWeek;

  WeekChanged({
    required this.currentWeekNumber,
    this.isNextWeek = true,
  });
}
