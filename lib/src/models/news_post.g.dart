// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsPost _$NewsPostFromJson(Map json) => NewsPost(
      title: json['title'] as String,
      imageUrl: json['imageUrl'] as String?,
      tags: (json['tags'] as List<dynamic>)
          .map((e) => NewsPostTag.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      content: json['content'] as String?,
      uploadDate: DateTime.parse(json['uploadDate'] as String),
    );

Map<String, dynamic> _$NewsPostToJson(NewsPost instance) => <String, dynamic>{
      'title': instance.title,
      'imageUrl': instance.imageUrl,
      'tags': instance.tags.map((e) => e.toJson()).toList(),
      'content': instance.content,
      'uploadDate': instance.uploadDate.toIso8601String(),
    };
