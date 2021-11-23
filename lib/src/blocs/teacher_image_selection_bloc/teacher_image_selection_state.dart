part of 'teacher_image_selection_bloc.dart';

abstract class TeacherImageSelectionState {}

class TeacherImageSelectionInitial extends TeacherImageSelectionState {}

class TeacherImagesFetchInProgress extends TeacherImageSelectionState {}

class TeacherImagesFetchSuccess extends TeacherImageSelectionState {
  final List<String> imageUrls;
  TeacherImagesFetchSuccess({required this.imageUrls});
}

class TeacherImagesFetchFailure extends TeacherImageSelectionState {}
