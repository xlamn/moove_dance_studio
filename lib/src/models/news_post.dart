import 'package:json_annotation/json_annotation.dart';
import 'package:moove_dance_studio/moove_dance_studio.dart';

part 'news_post.g.dart';

@JsonSerializable(
  explicitToJson: true,
  anyMap: true,
)
class NewsPost {
  final String title;

  final String? imageUrl;

  final List<NewsPostTag> tags;

  final String? content;

  final DateTime uploadDate;

  NewsPost({
    required this.title,
    this.imageUrl,
    required this.tags,
    this.content,
    required this.uploadDate,
  });

  factory NewsPost.fromJson(Map<String, dynamic> json) => _$NewsPostFromJson(json);

  Map<String, dynamic> toJson() => _$NewsPostToJson(this);
}
