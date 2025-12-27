import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MoodSheet extends ConsumerStatefulWidget {
  const MoodSheet({super.key});

  @override
  ConsumerState<MoodSheet> createState() => _MoodSheetState();
}

class _MoodSheetState extends ConsumerState<MoodSheet> {
  double _score = 3.0; // 1 to 5
  final List<String> _selectedTags = [];
  final _tags = ['Sleep', 'Stress', 'Energy', 'Exercise', 'Social', 'Work'];
  
  void _saveMood() {
    // Save to provider/repo
    // ref.read(moodProvider.notifier).addEntry(...)
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Mood logged!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      height: 500,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'How are you feeling?',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('😞', style: _score == 1 ? const TextStyle(fontSize: 40) : const TextStyle(fontSize: 24, color: Colors.grey)),
              Text('😐', style: _score == 3 ? const TextStyle(fontSize: 40) : const TextStyle(fontSize: 24, color: Colors.grey)),
              Text('🙂', style: _score == 5 ? const TextStyle(fontSize: 40) : const TextStyle(fontSize: 24, color: Colors.grey)),
            ],
          ),
          Slider(
            value: _score,
            min: 1,
            max: 5,
            divisions: 4,
            label: _score.toInt().toString(),
            onChanged: (val) {
              setState(() {
                _score = val;
              });
            },
          ),
          const SizedBox(height: 24),
          const Text('What affected your mood?'),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: _tags.map((tag) {
              final isSelected = _selectedTags.contains(tag);
              return FilterChip(
                label: Text(tag),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    if (selected) {
                      _selectedTags.add(tag);
                    } else {
                      _selectedTags.remove(tag);
                    }
                  });
                },
              );
            }).toList(),
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: _saveMood,
              child: const Text('Save Entry'),
            ),
          ),
        ],
      ),
    );
  }
}
