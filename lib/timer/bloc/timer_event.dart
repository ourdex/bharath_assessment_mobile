part of 'timer_bloc.dart';

abstract class TimerEvent {}

class TimerEventStart extends TimerEvent {}

class TimerEventInProgress extends TimerEvent {
  TimerEventInProgress();
}
