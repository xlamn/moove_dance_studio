// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dance_class.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DanceClass _$DanceClassFromJson(Map<String, dynamic> json) => DanceClass(
      teacher: Teacher.fromJson(json['teacher'] as Map<String, dynamic>),
      type: _$enumDecode(_$DanceClassTypeEnumMap, json['type']),
      level: _$enumDecode(_$DanceClassLevelEnumMap, json['level']),
      time: DateTime.parse(json['time'] as String),
      durationInMin: json['durationInMin'] as int,
    );

Map<String, dynamic> _$DanceClassToJson(DanceClass instance) =>
    <String, dynamic>{
      'teacher': instance.teacher.toJson(),
      'type': _$DanceClassTypeEnumMap[instance.type],
      'level': _$DanceClassLevelEnumMap[instance.level],
      'time': instance.time.toIso8601String(),
      'durationInMin': instance.durationInMin,
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$DanceClassTypeEnumMap = {
  DanceClassType.hiphop: 'hiphop',
  DanceClassType.popping: 'popping',
  DanceClassType.locking: 'locking',
  DanceClassType.house: 'house',
  DanceClassType.female: 'female',
};

const _$DanceClassLevelEnumMap = {
  DanceClassLevel.beginner: 'beginner',
  DanceClassLevel.starter: 'starter',
  DanceClassLevel.intermediate: 'intermediate',
  DanceClassLevel.masterclass: 'masterclass',
};
