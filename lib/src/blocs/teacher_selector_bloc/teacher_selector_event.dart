part of 'teacher_selector_bloc.dart';

abstract class TeacherSelectorEvent {}

class TeacherSelectorStarted extends TeacherSelectorEvent {}

class TeacherSelected extends TeacherSelectorEvent {
  final Teacher selectedTeacher;

  TeacherSelected({required this.selectedTeacher});
}
