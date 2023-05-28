part of 'mcq_bloc.dart';

abstract class MCQState {}

class MCQInitial extends MCQState {}

class MCQStateLoading extends MCQState {}

class MCQStateSuccess extends MCQState {
  final List<MCQModel> mcqs;

  MCQStateSuccess(this.mcqs);
}

class MCQStateError extends MCQState {
  String error;

  MCQStateError(this.error);
}

class MCQStateAnswerLoadedSuccess extends MCQState {
  List<MCQOption> answers;

  MCQStateAnswerLoadedSuccess(this.answers);
}
