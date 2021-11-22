import 'package:bloc/bloc.dart';
import 'package:moove_dance_studio/moove_dance_studio.dart';

part 'week_selector_event.dart';
part 'week_selector_state.dart';

class WeekSelectorBloc extends Bloc<WeekSelectorEvent, WeekSelectorState> {
  final DanceClassBloc danceClassBloc;

  WeekSelectorBloc({required this.danceClassBloc}) : super(WeekSelectorInitial());

  @override
  Stream<WeekSelectorState> mapEventToState(WeekSelectorEvent event) async* {
    if (event is GetCurrentWeek) {
      yield WeekChangedSuccess(
        selectedWeek: DateTime.now().getWeekNumber(),
      );
    } else if (event is WeekChanged) {
      if (event.isNextWeek) {
        final nextWeek = event.currentWeekNumber + 1;
        danceClassBloc.add(DanceClassFetched(currentDay: event.currentDay, currentWeek: nextWeek));
        yield WeekChangedSuccess(
          selectedWeek: nextWeek,
        );
      } else {
        final previousWeek = event.currentWeekNumber - 1;
        danceClassBloc.add(DanceClassFetched(currentDay: event.currentDay, currentWeek: previousWeek));
        yield WeekChangedSuccess(
          selectedWeek: previousWeek,
        );
      }
    }
  }
}
