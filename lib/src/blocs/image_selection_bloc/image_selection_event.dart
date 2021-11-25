part of 'image_selection_bloc.dart';

abstract class ImageSelectionEvent {}

class ImageSelectionStarted extends ImageSelectionEvent {}

class ImageSelectionRefreshed extends ImageSelectionEvent {}
