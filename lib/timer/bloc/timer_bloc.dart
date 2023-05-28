import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cross_mobile/utils/constants.dart';

part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  DateTime? _startTime;
  Timer? _timer;

  TimerBloc() : super(TimerInitial()) {
    on<TimerEventStart>(_startTimer);
    on<TimerEventInProgress>(
      (event, emit) => emit(TimerInProgress(_startTime!)),
    );
  }

  _startTimer(TimerEventStart event, Emitter<TimerState> emit) {
    _startTime = DateTime.now();
    if (_timer != null) {
      _timer?.cancel();
    }
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        final now = DateTime.now();
        if (now.difference(_startTime!) > timerDuration) {
          _timer?.cancel();
        }
        add(TimerEventInProgress());
      },
    );
  }
}
