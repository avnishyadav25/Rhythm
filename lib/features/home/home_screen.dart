import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:rhythm/features/habits/presentation/add_habit_screen.dart';
import 'package:rhythm/features/habits/presentation/habit_list_tile.dart';
import 'package:rhythm/features/habits/presentation/habit_provider.dart';
import 'package:rhythm/features/focus/presentation/focus_screen.dart';
import 'package:rhythm/features/reading/presentation/reading_screen.dart';
import 'package:rhythm/features/mood/presentation/mood_sheet.dart';
import 'package:rhythm/features/insights/presentation/insights_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    _TodayView(),
    Center(child: Text('Focus (Use Today view)')),
    ReadingScreen(),
    InsightsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
        destinations: const <NavigationDestination>[
          NavigationDestination(
            icon: Icon(Icons.today),
            label: 'Today',
          ),
          NavigationDestination(
            icon: Icon(Icons.timer),
            label: 'Focus',
          ),
          NavigationDestination(
            icon: Icon(Icons.book),
            label: 'Read',
          ),
          NavigationDestination(
            icon: Icon(Icons.insights),
            label: 'Insights',
          ),
        ],
      ),
    );
  }
}

class _TodayView extends ConsumerWidget {
  const _TodayView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final today = DateTime.now();
    final dateString = DateFormat('EEEE, MMM d').format(today);
    final habitsAsync = ref.watch(habitListProvider);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(
                    'Today',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    dateString,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                  ),
                ],
              ),
              // User profile or settings placeholder
              const CircleAvatar(
                child: Icon(Icons.person),
              ),
            ],
          ),
         
          const SizedBox(height: 24),
          // Habits Section
          _SectionHeader(
            title: 'Habits', 
            onAddRepressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const AddHabitScreen()),
              );
            }
          ),
          const SizedBox(height: 8),
          
          Expanded(
            child: habitsAsync.when(
              data: (habits) {
                if (habits.isEmpty) {
                   return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.check_circle_outline, size: 48, color: Theme.of(context).disabledColor),
                        const SizedBox(height: 8),
                        const Text('No habits yet. Add one to get started!'),
                      ],
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: habits.length,
                  itemBuilder: (context, index) {
                    return HabitListTile(habit: habits[index]);
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error: $err')),
            ),
          ),
          
          const SizedBox(height: 16),
          // Quick Actions
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: FilledButton.icon(
                  onPressed: () {
                     Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const FocusScreen()),
                    );
                  },
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('Focus'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: FilledButton.tonalIcon(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => const MoodSheet(),
                    );
                  },
                  icon: const Icon(Icons.mood),
                  label: const Text('Log Mood'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onAddRepressed;

  const _SectionHeader({required this.title, required this.onAddRepressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        IconButton(
          onPressed: onAddRepressed,
          icon: const Icon(Icons.add_circle_outline),
        ),
      ],
    );
  }
}
