import 'package:bloc/bloc.dart';

part 'week_day_event.dart';
part 'week_day_state.dart';

class WeekDayBloc extends Bloc<WeekDayEvent, WeekDayState> {
  WeekDayBloc() : super(WeekDayInitial());

  @override
  Stream<WeekDayState> mapEventToState(WeekDayEvent event) async* {
    if (event is WeekDayChanged) {
      yield WeekDayChangedSuccess(selectedDay: event.selectedDay);
    }
  }
}
