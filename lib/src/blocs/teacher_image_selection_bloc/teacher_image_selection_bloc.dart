import 'package:bloc/bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';

part 'teacher_image_selection_event.dart';
part 'teacher_image_selection_state.dart';

class TeacherImageSelectionBloc extends Bloc<TeacherImageSelectionEvent, TeacherImageSelectionState> {
  final Reference storage;

  TeacherImageSelectionBloc({required FirebaseStorage storage})
      : storage = storage.ref("teacher"),
        super(TeacherImageSelectionInitial());

  @override
  Stream<TeacherImageSelectionState> mapEventToState(TeacherImageSelectionEvent event) async* {
    if (event is TeacherImageSelectionStarted) {
      yield TeacherImagesFetchInProgress();
      try {
        final list = <String>[];
        final listResult = await storage.listAll();

        for (final image in listResult.items) {
          final imageUrl = await image.getDownloadURL();
          list.add(imageUrl);
        }

        yield TeacherImagesFetchSuccess(imageUrls: list);
      } catch (_) {
        yield TeacherImagesFetchFailure();
      }
    }
  }
}
