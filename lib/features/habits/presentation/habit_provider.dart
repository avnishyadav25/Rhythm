import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/habit_repository.dart';
import '../domain/habit.dart';

part 'habit_provider.g.dart';

@riverpod
class HabitList extends _$HabitList {
  @override
  Future<List<Habit>> build() async {
    final repository = ref.read(habitRepositoryProvider);
    return repository.getHabits();
  }

  Future<void> addHabit(String title) async {
    final repository = ref.read(habitRepositoryProvider);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await repository.createHabit(title: title);
      return repository.getHabits();
    });
  }

  Future<void> toggleHabit(String id, bool isCompleted) async {
    final repository = ref.read(habitRepositoryProvider);
    // Optimistic update could go here, but keeping it simple
    await repository.toggleHabitCompletion(id, isCompleted);
    ref.invalidateSelf(); // Refresh list
  }
}
