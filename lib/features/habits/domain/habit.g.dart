// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HabitImpl _$$HabitImplFromJson(Map<String, dynamic> json) => _$HabitImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      title: json['title'] as String,
      scheduleType:
          $enumDecodeNullable(_$HabitScheduleEnumMap, json['scheduleType']) ??
              HabitSchedule.daily,
      targetCount: (json['targetCount'] as num?)?.toInt() ?? 1,
      timeWindow:
          $enumDecodeNullable(_$HabitTimeWindowEnumMap, json['timeWindow']) ??
              HabitTimeWindow.anytime,
      createdAt: DateTime.parse(json['createdAt'] as String),
      completedToday: json['completedToday'] as bool? ?? false,
    );

Map<String, dynamic> _$$HabitImplToJson(_$HabitImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'title': instance.title,
      'scheduleType': _$HabitScheduleEnumMap[instance.scheduleType]!,
      'targetCount': instance.targetCount,
      'timeWindow': _$HabitTimeWindowEnumMap[instance.timeWindow]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'completedToday': instance.completedToday,
    };

const _$HabitScheduleEnumMap = {
  HabitSchedule.daily: 'daily',
  HabitSchedule.weekly: 'weekly',
};

const _$HabitTimeWindowEnumMap = {
  HabitTimeWindow.morning: 'morning',
  HabitTimeWindow.afternoon: 'afternoon',
  HabitTimeWindow.evening: 'evening',
  HabitTimeWindow.anytime: 'anytime',
};
