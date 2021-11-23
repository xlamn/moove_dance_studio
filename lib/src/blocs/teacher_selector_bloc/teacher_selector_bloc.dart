import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:moove_dance_studio/moove_dance_studio.dart';

part 'teacher_selector_event.dart';
part 'teacher_selector_state.dart';

class TeacherSelectorBloc extends Bloc<TeacherSelectorEvent, TeacherSelectorState> {
  final DatabaseReference databaseReference;

  TeacherSelectorBloc({required FirebaseDatabase database})
      : databaseReference = database.reference().child("Teacher"),
        super(TeacherSelectorInitial());

  @override
  Stream<TeacherSelectorState> mapEventToState(TeacherSelectorEvent event) async* {
    if (event is TeacherSelectorStarted) {
      yield TeachersFetchInProgress();
      try {
        List<Teacher> teachers = [];
        await databaseReference.once().then((DataSnapshot snapshot) {
          Map<dynamic, dynamic> values = snapshot.value;
          values.forEach((key, values) {
            teachers.add(Teacher.fromJson(Map<String, dynamic>.from(values)));
          });
        }).timeout(Duration(seconds: 5));

        teachers.sort((a, b) => a.teacherName.compareTo(b.teacherName));

        yield TeachersFetchSuccess(
          selectedTeacher: teachers.first,
          teachers: teachers,
        );
      } catch (_) {
        yield TeachersFetchFailure();
      }
    } else if (event is TeacherSelected) {
      yield TeachersFetchSuccess(
        selectedTeacher: event.selectedTeacher,
        teachers: state.teachers!,
      );
    }
  }
}
