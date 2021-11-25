import 'package:bloc/bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:moove_dance_studio/moove_dance_studio.dart';

part 'upload_news_post_event.dart';
part 'upload_news_post_state.dart';

class UploadNewsPostBloc extends Bloc<UploadNewsPostEvent, UploadNewsPostState> {
  final DatabaseReference databaseReference;

  UploadNewsPostBloc({required FirebaseDatabase database})
      : databaseReference = database.reference().child("News Post"),
        super(UploadNewsPostInitial());

  @override
  Stream<UploadNewsPostState> mapEventToState(UploadNewsPostEvent event) async* {
    if (event is NewsPostUploaded) {
      yield UploadNewsPostInProgress();
      try {
        await databaseReference.push().set(
              event.newsPost.toJson(),
            );
        yield UploadNewsPostSuccess();
      } catch (_) {
        yield UploadNewsPostFailure();
      }
    }
  }
}
