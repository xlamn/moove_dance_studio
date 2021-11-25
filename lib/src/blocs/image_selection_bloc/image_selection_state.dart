part of 'image_selection_bloc.dart';

abstract class ImageSelectionState {}

class ImageSelectionInitial extends ImageSelectionState {}

class ImagesFetchInProgress extends ImageSelectionState {}

class ImagesFetchSuccess extends ImageSelectionState {
  final List<String> imageUrls;
  ImagesFetchSuccess({required this.imageUrls});
}

class ImagesFetchFailure extends ImageSelectionState {}
