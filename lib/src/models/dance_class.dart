import 'package:flutter/widgets.dart';
import 'package:moove_dance_studio/moove_dance_studio.dart';

class DanceClass {
  final String teacherName;

  final ImageProvider teacherImage;

  final String typeOfClass;

  final DanceClassLevel level;

  final String time;

  const DanceClass({
    required this.teacherName,
    this.teacherImage = const AssetImage('assets/coaches/tobi.jpg'),
    required this.typeOfClass,
    required this.level,
    required this.time,
  });
}
