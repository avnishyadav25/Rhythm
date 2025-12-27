import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'timer_provider.g.dart';

enum TimerState { initial, running, paused, finished }

@riverpod
class TimerNotifier extends _$TimerNotifier {
  Timer? _timer;
  static const int _defaultDuration = 25 * 60; // 25 minutes

  @override
  TimerState build() {
    ref.onDispose(() {
      _timer?.cancel();
    });
    return TimerState.initial;
  }

  int _remainingSeconds = _defaultDuration;
  int get remainingSeconds => _remainingSeconds;
  
  double get progress => _remainingSeconds / _defaultDuration;

  void startTimer({int minutes = 25}) {
    if (state == TimerState.initial || state == TimerState.finished) {
      _remainingSeconds = minutes * 60;
    }
    state = TimerState.running;
    _startTicker();
  }

  void pauseTimer() {
    _timer?.cancel();
    state = TimerState.paused;
  }

  void resumeTimer() {
    if (state == TimerState.paused) {
      state = TimerState.running;
      _startTicker();
    }
  }

  void stopTimer() {
    _timer?.cancel();
    _remainingSeconds = _defaultDuration;
    state = TimerState.initial;
  }

  void _startTicker() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        _remainingSeconds--;
        // Force rebuild to update UI
        ref.notifyListeners();
      } else {
        _timer?.cancel();
        state = TimerState.finished;
        // Here we would save the session
      }
    });
  }
}
