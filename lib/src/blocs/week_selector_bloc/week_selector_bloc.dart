import 'package:bloc/bloc.dart';
import 'package:moove_dance_studio/moove_dance_studio.dart';

part 'week_selector_event.dart';
part 'week_selector_state.dart';

class WeekSelectorBloc extends Bloc<WeekSelectorEvent, WeekSelectorState> {
  WeekSelectorBloc() : super(WeekSelectorInitial());

  @override
  Stream<WeekSelectorState> mapEventToState(WeekSelectorEvent event) async* {
    if (event is GetCurrentWeek) {
      yield WeekChangedSuccess(
        weekNumber: DateTime.now().getWeekNumber(),
      );
    } else if (event is WeekChanged) {
      if (event.isNextWeek) {
        yield WeekChangedSuccess(
          weekNumber: event.currentWeekNumber + 1,
        );
      } else {
        yield WeekChangedSuccess(
          weekNumber: event.currentWeekNumber - 1,
        );
      }
    }
  }
}
