import 'package:bloc/bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:moove_dance_studio/moove_dance_studio.dart';

part 'news_post_event.dart';
part 'news_post_state.dart';

class NewsPostBloc extends Bloc<NewsPostEvent, NewsPostState> {
  final DatabaseReference databaseReference;

  NewsPostBloc({required FirebaseDatabase database})
      : databaseReference = database.reference().child("News Post"),
        super(NewsPostInitial());

  @override
  Stream<NewsPostState> mapEventToState(NewsPostEvent event) async* {
    if (event is NewsPostStarted || event is NewsPostFetched) {
      yield NewsPostFetchInProgress();
      try {
        List<NewsPost> newsPosts = [];
        await databaseReference.once().then((DataSnapshot snapshot) {
          Map<dynamic, dynamic> values = snapshot.value;
          values.forEach((key, values) {
            newsPosts.add(NewsPost.fromJson(Map<String, dynamic>.from(values)));
          });
        }).timeout(Duration(seconds: 5));

        newsPosts.sort((a, b) => b.uploadDate.compareTo(a.uploadDate));

        yield NewsPostFetchSuccess(newsPosts: newsPosts);
      } catch (e) {
        print(e);
        yield NewsPostFetchFailure();
      }
    }
  }
}
