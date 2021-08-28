import 'package:flutter/material.dart';
import 'package:moove_dance_studio/moove_dance_studio.dart';

class Tag extends StatelessWidget {
  final String tagText;
  final Color tagTextColor;
  final Color tagBackgroundColor;

  Tag(
      {required this.tagText,
      this.tagTextColor = Colors.black,
      this.tagBackgroundColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: SizeConstants.small, vertical: SizeConstants.mini),
        color: tagBackgroundColor,
        child: Text(
          tagText,
          style: TextStyle(color: tagTextColor),
        ),
      ),
    );
  }
}

class DanceClassLevelTag extends StatelessWidget {
  final DanceClass danceClass;

  DanceClassLevelTag({required this.danceClass});

  @override
  Widget build(BuildContext context) {
    var tagText;
    var tagTextColor;
    var tagBackgroundColor;

    switch (danceClass.level) {
      case (DanceClassLevel.beginner):
        tagText = 'beginner'.toUpperCase();
        tagTextColor = Colors.black;
        tagBackgroundColor = Colors.white;
        break;
      case (DanceClassLevel.starter):
        tagText = 'starter'.toUpperCase();
        tagTextColor = Colors.white;
        tagBackgroundColor = Colors.green;
        break;
      case (DanceClassLevel.intermediate):
        tagText = 'intermediate'.toUpperCase();
        tagTextColor = Colors.white;
        tagBackgroundColor = Colors.black54;
        break;
      case (DanceClassLevel.masterclass):
        tagText = 'masterclass'.toUpperCase();
        tagTextColor = Colors.white;
        tagBackgroundColor = Colors.red;
        break;
      default:
        tagText = '';
        tagTextColor = Colors.white;
        tagBackgroundColor = Colors.black;
    }

    return Material(
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: SizeConstants.small, vertical: SizeConstants.mini),
        color: tagBackgroundColor,
        child: Text(
          tagText,
          style: TextStyle(color: tagTextColor, fontSize: 16.0),
        ),
      ),
    );
  }
}
