part of 'upload_news_post_bloc.dart';

abstract class UploadNewsPostState {}

class UploadNewsPostInitial extends UploadNewsPostState {}

class UploadNewsPostInProgress extends UploadNewsPostState {}

class UploadNewsPostSuccess extends UploadNewsPostState {}

class UploadNewsPostFailure extends UploadNewsPostState {}
