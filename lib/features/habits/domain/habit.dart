import 'package:freezed_annotation/freezed_annotation.dart';

part 'habit.freezed.dart';
part 'habit.g.dart';

enum HabitSchedule { daily, weekly }
enum HabitTimeWindow { morning, afternoon, evening, anytime }

@freezed
class Habit with _$Habit {
  const factory Habit({
    required String id,
    required String userId,
    required String title,
    @Default(HabitSchedule.daily) HabitSchedule scheduleType,
    @Default(1) int targetCount,
    @Default(HabitTimeWindow.anytime) HabitTimeWindow timeWindow,
    required DateTime createdAt,
    @Default(false) bool completedToday, // Helper for UI, might be computed separately in real DB
  }) = _Habit;

  factory Habit.fromJson(Map<String, dynamic> json) => _$HabitFromJson(json);
}
