part of 'week_selector_bloc.dart';

abstract class WeekSelectorState {}

class WeekSelectorInitial extends WeekSelectorState {}

class WeekChangedSuccess extends WeekSelectorState {
  final int selectedWeek;
  WeekChangedSuccess({
    required this.selectedWeek,
  });
}

class WeekChangedFailure extends WeekSelectorState {}
