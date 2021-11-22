import 'package:bloc/bloc.dart';
import 'package:moove_dance_studio/moove_dance_studio.dart';

part 'week_day_event.dart';
part 'week_day_state.dart';

class WeekDayBloc extends Bloc<WeekDayEvent, WeekDayState> {
  final DanceClassBloc danceClassBloc;

  WeekDayBloc({required this.danceClassBloc}) : super(WeekDayInitial());

  @override
  Stream<WeekDayState> mapEventToState(WeekDayEvent event) async* {
    if (event is GetCurrentWeekDay) {
      yield WeekDayChangedSuccess(selectedDay: DateTime.now().day % 7);
    }

    if (event is WeekDayChanged) {
      danceClassBloc.add(DanceClassFetched(currentDay: event.selectedDay, currentWeek: event.currentWeek));
      yield WeekDayChangedSuccess(selectedDay: event.selectedDay);
    }
  }
}
