part of 'news_post_bloc.dart';

abstract class NewsPostState {}

class NewsPostInitial extends NewsPostState {}

class NewsPostFetchInProgress extends NewsPostState {}

class NewsPostFetchSuccess extends NewsPostState {
  final List<NewsPost> newsPosts;
  NewsPostFetchSuccess({required this.newsPosts});
}

class NewsPostFetchFailure extends NewsPostState {}
