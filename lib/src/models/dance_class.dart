import 'package:moove_dance_studio/moove_dance_studio.dart';
import 'package:json_annotation/json_annotation.dart';

part 'dance_class.g.dart';

@JsonSerializable(
  explicitToJson: true,
  anyMap: true,
)
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

  factory DanceClass.fromJson(Map<String, dynamic> json) =>
      _$DanceClassFromJson(json);

  Map<String, dynamic> toJson() => _$DanceClassToJson(this);
}
