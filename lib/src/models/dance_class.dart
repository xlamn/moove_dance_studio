import 'package:moove_dance_studio/moove_dance_studio.dart';

class DanceClass {
  final Teacher teacher;

  final DanceClassType type;

  final DanceClassLevel level;

  final DateTime time;

  final int durationInMin;

  const DanceClass({
    required this.teacher,
    required this.type,
    required this.level,
    required this.time,
    required this.durationInMin,
  });

  // Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
  //       'teacherName': teacherName,
  //       'type': type.toString(),
  //       'level': level.toString(),
  //       'time': time.toString(),
  //     };
}
