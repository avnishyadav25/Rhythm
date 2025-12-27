import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import '../domain/habit.dart';

// part 'habit_repository.g.dart';

// In a real app, this would talk to Supabase/Isar.
// For MVP Phase 2 start, we'll use a simple in-memory list or mock.

class HabitRepository {
  final List<Habit> _mockHabits = [];

  Future<List<Habit>> getHabits() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockHabits;
  }

  Future<Habit> createHabit({
    required String title,
    HabitSchedule schedule = HabitSchedule.daily,
    HabitTimeWindow window = HabitTimeWindow.anytime,
  }) async {
    final newHabit = Habit(
      id: const Uuid().v4(),
      userId: 'test-user', // Mock user ID
      title: title,
      scheduleType: schedule,
      timeWindow: window,
      createdAt: DateTime.now(),
    );
    _mockHabits.add(newHabit);
    return newHabit;
  }

  Future<void> toggleHabitCompletion(String habitId, bool isCompleted) async {
    final index = _mockHabits.indexWhere((h) => h.id == habitId);
    if (index != -1) {
      _mockHabits[index] = _mockHabits[index].copyWith(completedToday: isCompleted);
    }
  }
}

// Simple Provider for the Repo
final habitRepositoryProvider = Provider<HabitRepository>((ref) {
  return HabitRepository();
});
