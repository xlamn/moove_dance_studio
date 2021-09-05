part of 'week_selector_bloc.dart';

abstract class WeekSelectorState {}

class WeekSelectorInitial extends WeekSelectorState {}

class WeekChangedSuccess extends WeekSelectorState {
  final int weekNumber;
  WeekChangedSuccess({
    required this.weekNumber,
  });
}

class WeekChangedFailure extends WeekSelectorState {}
