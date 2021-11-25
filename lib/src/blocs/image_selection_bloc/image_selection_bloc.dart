import 'package:bloc/bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';

part 'image_selection_event.dart';
part 'image_selection_state.dart';

class ImageSelectionBloc extends Bloc<ImageSelectionEvent, ImageSelectionState> {
  final Reference storage;

  ImageSelectionBloc({required FirebaseStorage storage, required String reference})
      : storage = storage.ref(reference),
        super(ImageSelectionInitial());

  @override
  Stream<ImageSelectionState> mapEventToState(ImageSelectionEvent event) async* {
    if (event is ImageSelectionStarted || event is ImageSelectionRefreshed) {
      yield ImagesFetchInProgress();
      try {
        final list = <String>[];
        final listResult = await storage.listAll();

        for (final image in listResult.items) {
          final imageUrl = await image.getDownloadURL();
          list.add(imageUrl);
        }

        yield ImagesFetchSuccess(imageUrls: list);
      } catch (_) {
        yield ImagesFetchFailure();
      }
    }
  }
}
