part of 'teacher_selector_bloc.dart';

abstract class TeacherSelectorState extends Equatable {
  final Teacher? selectedTeacher;
  final List<Teacher>? teachers;

  TeacherSelectorState({
    this.selectedTeacher,
    this.teachers,
  });

  @override
  List<Object?> get props => [selectedTeacher, teachers];
}

class TeacherSelectorInitial extends TeacherSelectorState {}

class TeachersFetchInProgress extends TeacherSelectorState {}

class TeachersFetchSuccess extends TeacherSelectorState {
  final Teacher selectedTeacher;
  final List<Teacher> teachers;

  TeachersFetchSuccess({
    required this.selectedTeacher,
    required this.teachers,
  }) : super(
          selectedTeacher: selectedTeacher,
          teachers: teachers,
        );
}

class TeachersFetchFailure extends TeacherSelectorState {}
