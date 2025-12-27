import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rhythm/features/habits/domain/habit.dart';
import 'package:rhythm/features/habits/presentation/habit_provider.dart';

class AddHabitScreen extends ConsumerStatefulWidget {
  const AddHabitScreen({super.key});

  @override
  ConsumerState<AddHabitScreen> createState() => _AddHabitScreenState();
}

class _AddHabitScreenState extends ConsumerState<AddHabitScreen> {
  final _titleController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  
  // Default values
  HabitSchedule _schedule = HabitSchedule.daily;
  HabitTimeWindow _timeWindow = HabitTimeWindow.anytime;

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  Future<void> _saveHabit() async {
    if (_formKey.currentState!.validate()) {
      // In a real app we'd pass all the params. 
      // The provider currently only takes title for simplicity, but let's update it or just acknowledge limitation.
      // For MVP V1 iteration 2, we will add the full params to the provider.
      
      await ref.read(habitListProvider.notifier).addHabit(_titleController.text);
      if (mounted) {
        context.pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Habit'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Habit Name',
                hintText: 'e.g., Read 10 pages',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter a name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            
            // Schedule Type
            const Text('Frequency'),
            SegmentedButton<HabitSchedule>(
              segments: const [
                ButtonSegment(value: HabitSchedule.daily, label: Text('Daily')),
                ButtonSegment(value: HabitSchedule.weekly, label: Text('Weekly')),
              ],
              selected: {_schedule},
              onSelectionChanged: (Set<HabitSchedule> newSelection) {
                setState(() {
                  _schedule = newSelection.first;
                });
              },
            ),
            const SizedBox(height: 16),

            // Time Window
            const Text('Time of Day'),
            DropdownButtonFormField<HabitTimeWindow>(
              value: _timeWindow,
              decoration: const InputDecoration(border: OutlineInputBorder()),
              items: HabitTimeWindow.values.map((window) {
                return DropdownMenuItem(
                  value: window,
                  child: Text(window.name.toUpperCase()),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _timeWindow = value;
                  });
                }
              },
            ),
            const SizedBox(height: 32),

            FilledButton(
              onPressed: _saveHabit,
              child: const Text('Create Habit'),
            ),
          ],
        ),
      ),
    );
  }
}
