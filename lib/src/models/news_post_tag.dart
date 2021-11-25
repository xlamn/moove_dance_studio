import 'dart:ui';

import 'package:json_annotation/json_annotation.dart';
import 'package:moove_dance_studio/moove_dance_studio.dart';

part 'news_post_tag.g.dart';

@JsonSerializable()
class NewsPostTag {
  @JsonKey(required: true)
  @ColorConverter()
  final Color color;

  final String text;

  NewsPostTag({required this.color, required this.text});

  factory NewsPostTag.fromJson(Map<String, dynamic> json) => _$NewsPostTagFromJson(json);

  Map<String, dynamic> toJson() => _$NewsPostTagToJson(this);
}
