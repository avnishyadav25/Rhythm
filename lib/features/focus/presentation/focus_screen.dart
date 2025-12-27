import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rhythm/features/focus/presentation/timer_provider.dart';

class FocusScreen extends ConsumerWidget {
  const FocusScreen({super.key});

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timerState = ref.watch(timerNotifierProvider);
    final notifier = ref.read(timerNotifierProvider.notifier);
    final remainingSeconds = notifier.remainingSeconds;
    final progress = notifier.progress;

    return Scaffold(
      appBar: AppBar(title: const Text('Focus Session')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 250,
              height: 250,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CircularProgressIndicator(
                    value: progress,
                    strokeWidth: 12,
                    backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  Center(
                    child: Text(
                      _formatTime(remainingSeconds),
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                            fontFeatures: [const FontFeature.tabularFigures()],
                          ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 48),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (timerState == TimerState.running)
                  FloatingActionButton.large(
                    onPressed: notifier.pauseTimer,
                    child: const Icon(Icons.pause),
                  )
                else if (timerState == TimerState.paused)
                  FloatingActionButton.large(
                    onPressed: notifier.resumeTimer,
                    child: const Icon(Icons.play_arrow),
                  )
                else
                  FloatingActionButton.large(
                    onPressed: () => notifier.startTimer(minutes: 25),
                    child: const Icon(Icons.play_arrow),
                  ),
                  
                if (timerState != TimerState.initial) ...[
                  const SizedBox(width: 24),
                  FilledButton.tonal(
                    onPressed: notifier.stopTimer,
                    child: const Text('Stop'),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
