import 'package:bloc/bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:moove_dance_studio/moove_dance_studio.dart';

part 'dance_class_event.dart';
part 'dance_class_state.dart';

class DanceClassBloc extends Bloc<DanceClassEvent, DanceClassState> {
  final DatabaseReference databaseReference;

  DanceClassBloc({required FirebaseDatabase database})
      : databaseReference = database.reference().child("Dance Class"),
        super(DanceClassInitial());

  @override
  Stream<DanceClassState> mapEventToState(DanceClassEvent event) async* {
    if (event is DanceClassStarted) {
      yield DanceClassFetchInProgress();
      try {
        List<DanceClass> danceClasses = [];
        await databaseReference.once().then((DataSnapshot snapshot) {
          Map<dynamic, dynamic> values = snapshot.value;
          values.forEach((key, values) {
            danceClasses.add(DanceClass.fromJson(Map<String, dynamic>.from(values)));
          });
        }).timeout(Duration(seconds: 5));

        final filteredDanceClasses = danceClasses
            .where(
              (danceClass) => danceClass.time.isSameDate(DateTime.now()),
            )
            .toList();

        yield DanceClassFetchSuccess(danceClasses: filteredDanceClasses);
      } catch (_) {
        yield DanceClassFetchFailure();
      }
    }
    if (event is DanceClassFetched) {
      yield DanceClassFetchInProgress();
      try {
        List<DanceClass> danceClasses = [];
        await databaseReference.once().then((DataSnapshot snapshot) {
          Map<dynamic, dynamic> values = snapshot.value;
          values.forEach((key, values) {
            danceClasses.add(DanceClass.fromJson(Map<String, dynamic>.from(values)));
          });
        }).timeout(Duration(seconds: 5));

        final filteredDanceClasses = danceClasses
            .where(
              (danceClass) => danceClass.time.isSameDate(
                event.currentWeek.getDateByWeekNumber().add(
                      Duration(days: event.currentDay - 1),
                    ),
              ),
            )
            .toList();

        yield DanceClassFetchSuccess(danceClasses: filteredDanceClasses);
      } catch (_) {
        yield DanceClassFetchFailure();
      }
    }
  }
}
