part of 'timer_bloc.dart';

abstract class TimerState {
  Duration get timeLeft;

  String get formattedTimeLeft {
    if (timeLeft.inSeconds > 60) {
      return "${timeLeft.inSeconds ~/ 60}m ${timeLeft.inSeconds % 60}s";
    } else {
      return "${timeLeft.inSeconds}s";
    }
  }
}

class TimerInitial extends TimerState {
  @override
  Duration timeLeft = const Duration(minutes: 10);
}

class TimerInProgress extends TimerState {
  final DateTime _startTime;

  TimerInProgress(this._startTime);

  @override
  Duration get timeLeft => Duration(seconds: timerDuration.inSeconds - DateTime.now().difference(_startTime).inSeconds);
}

class TimerFinished extends TimerState {
  @override
  Duration timeLeft = const Duration(minutes: 10);
}
