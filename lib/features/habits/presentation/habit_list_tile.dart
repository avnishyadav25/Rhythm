import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rhythm/features/habits/domain/habit.dart';
import 'package:rhythm/features/habits/presentation/habit_provider.dart';

class HabitListTile extends ConsumerWidget {
  final Habit habit;

  const HabitListTile({super.key, required this.habit});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surfaceContainer,
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Checkbox(
          value: habit.completedToday,
          onChanged: (bool? value) {
            if (value != null) {
               ref.read(habitListProvider.notifier).toggleHabit(habit.id, value);
            }
          },
        ),
        title: Text(
          habit.title,
          style: TextStyle(
            decoration: habit.completedToday ? TextDecoration.lineThrough : null,
            color: habit.completedToday ? Theme.of(context).disabledColor : null,
          ),
        ),
        subtitle: Text('🔥 ${0} days'), // Placeholder for streak
        trailing: Icon(
          Icons.arrow_forward_ios, 
          size: 16,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        onTap: () {
          // TODO: Open habit details/analytics
        },
      ),
    );
  }
}
