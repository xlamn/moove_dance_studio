// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_post_tag.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsPostTag _$NewsPostTagFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['color'],
  );
  return NewsPostTag(
    color: const ColorConverter().fromJson(json['color'] as String),
    text: json['text'] as String,
  );
}

Map<String, dynamic> _$NewsPostTagToJson(NewsPostTag instance) =>
    <String, dynamic>{
      'color': const ColorConverter().toJson(instance.color),
      'text': instance.text,
    };
