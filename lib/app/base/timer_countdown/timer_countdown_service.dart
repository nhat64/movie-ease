import 'dart:async';

import 'package:flutter/material.dart';

class TimerCountdownService {
  final ValueNotifier<int> _currentSeconds = ValueNotifier(-1);
  Timer? _timer;

  ValueNotifier<int> get currentSeconds => _currentSeconds;

  void startCountdown(int seconds) {
    _currentSeconds.value = seconds;
    _timer?.cancel(); // Hủy timer hiện tại nếu có
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_currentSeconds.value >= 0) {
        _currentSeconds.value--;
      } else {
        _timer?.cancel();
      }
    });
  }

  void cancelTimer() {
    _timer?.cancel();
    _currentSeconds.value = -1;
  }

  bool isTiming() {
    return _currentSeconds.value > 0;
  }
}
