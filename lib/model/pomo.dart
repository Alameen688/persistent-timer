import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vibrate/vibrate.dart';

class PomoModel extends ChangeNotifier {
  static const SESSION_TIME = Duration(minutes: 25);
  static const BREAK_TIME = Duration(minutes: 5);
  bool isBreak = false;
  Function onTimerUpdate;
  Duration _currentTime = PomoModel.SESSION_TIME;
  Duration startTime = PomoModel.SESSION_TIME;
  final Stopwatch _stopwatch = Stopwatch();
  double _currentSessionProgress = 0.0;

  set currentTime(Duration time) {
    startTime = _currentTime = time;
  }

  get currentTime => _currentTime;

  get formattedCurrentTime => DateFormat('mm:ss').format(
      DateTime(DateTime.now().year, 0, 0, 0, 0, _currentTime.inSeconds));

  get isRunning => _stopwatch.isRunning;

  get currentSessionProgress => _currentSessionProgress;

  start() {
    isBreak = false;
    currentTime = PomoModel.SESSION_TIME;
    _run();
  }

  _run() {
    _stopwatch.reset();
    _stopwatch.start();
    _timer();
  }

  reset() {
    _stopwatch.stop();
    _stopwatch.reset();
    _currentTime = startTime = SESSION_TIME;
  }

  _timer() async {
    _currentTime = startTime - _stopwatch.elapsed;
    _currentTime.inSeconds > 0 && isRunning
        ? Timer(Duration(seconds: 1), _timer)
        : _stopwatch.stop();

    _currentSessionProgress = double.parse(
        ((startTime.inSeconds - currentTime.inSeconds) / startTime.inSeconds)
            .toStringAsFixed(3));
    debugPrint('getting here');
    notifyListeners();
    if (startTime == SESSION_TIME && _currentTime.inSeconds == 0 && !isBreak) {
      if (await Vibrate.canVibrate) Vibrate.vibrate();
      await Future.delayed(Duration(seconds: 1));
      isBreak = true;
      currentTime = BREAK_TIME;
      _run();
    }
  }
}

