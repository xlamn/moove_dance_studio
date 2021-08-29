import 'package:flutter/material.dart';
import 'package:moove_dance_studio/moove_dance_studio.dart';

class Tag extends StatelessWidget {
  final String tagText;
  final Color? color;

  Tag({
    required this.tagText,
    this.color = Colors.orange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        color: color?.withOpacity(0.2) ??
            Theme.of(context).primaryColor.withOpacity(0.2),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withOpacity(0.2),
            spreadRadius: 0.25,
            blurRadius: 5.0,
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(
        horizontal: SizeConstants.normal,
        vertical: SizeConstants.small,
      ),
      child: Text(
        tagText,
        style: TextStyle(
          color: color ?? Theme.of(context).textTheme.bodyText1!.color,
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
    var tagColor;

    switch (danceClass.level) {
      case (DanceClassLevel.beginner):
        tagText = 'beginner'.toUpperCase();
        tagColor = Colors.blue;
        break;
      case (DanceClassLevel.starter):
        tagText = 'starter'.toUpperCase();
        tagColor = Colors.green;
        break;
      case (DanceClassLevel.intermediate):
        tagText = 'intermediate'.toUpperCase();
        tagColor = Colors.orange;
        break;
      case (DanceClassLevel.masterclass):
        tagText = 'masterclass'.toUpperCase();
        tagColor = Colors.red;
        break;
      default:
        tagText = '';
        tagColor = Colors.black;
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        color: tagColor?.withOpacity(0.2) ??
            Theme.of(context).primaryColor.withOpacity(0.2),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withOpacity(0.2),
            spreadRadius: 0.25,
            blurRadius: 5.0,
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(
        horizontal: SizeConstants.normal,
        vertical: SizeConstants.small,
      ),
      child: Text(
        tagText,
        style: TextStyle(
          color: tagColor ?? Theme.of(context).textTheme.bodyText1!.color,
        ),
      ),
    );
  }
}
