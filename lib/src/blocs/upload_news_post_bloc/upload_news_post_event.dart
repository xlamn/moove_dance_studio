part of 'upload_news_post_bloc.dart';

abstract class UploadNewsPostEvent {}

class NewsPostUploaded extends UploadNewsPostEvent {
  final NewsPost newsPost;

  NewsPostUploaded({required this.newsPost});
}
