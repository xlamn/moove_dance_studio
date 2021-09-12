import 'package:flutter/material.dart';
import 'package:moove_dance_studio/moove_dance_studio.dart';

class NewsPost {
  final String title;

  final AssetImage? image;

  final List<Tag> tags;

  final String content;

  NewsPost({
    required this.title,
    this.image,
    this.tags = const [],
    this.content = '',
  });
}
