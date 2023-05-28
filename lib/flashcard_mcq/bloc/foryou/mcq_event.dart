part of 'mcq_bloc.dart';

abstract class MCQEvent {}

class MCQEventFetchNext extends MCQEvent {}

class MCQEventFetchAnswer extends MCQEvent {
  String id;
  MCQEventFetchAnswer(this.id);
}
