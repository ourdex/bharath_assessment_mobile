import 'package:bloc/bloc.dart';
import 'package:cross_mobile/flashcard_mcq/models/mcq_option.dart';
import 'package:cross_mobile/utils/dependencies.dart';
import 'package:cross_mobile/flashcard_mcq/models/mcq_model.dart';
import 'package:cross_mobile/flashcard_mcq/repositories/tiktok_repository.dart';

part 'mcq_event.dart';

part 'mcq_state.dart';

class MCQBloc extends Bloc<MCQEvent, MCQState> {
  TikTokRepository get _tikTokRepository => getIt.get<TikTokRepository>();

  MCQBloc() : super(MCQInitial()) {
    on<MCQEventFetchNext>(
      (event, emit) => _fetchNextMCQ(event, emit),
    );
    on<MCQEventFetchAnswer>(
      (event, emit) => _fetchAnswer(event, emit),
    );
  }

  Future _fetchNextMCQ(MCQEvent event, Emitter<MCQState> emit) async {
    emit(MCQStateLoading());
    try {
      final response = await _tikTokRepository.fetchNextForYou();
      emit(MCQStateSuccess([response]));
    } catch (error) {
      emit(MCQStateError(error.toString()));
    }
  }

  Future _fetchAnswer(MCQEventFetchAnswer event, Emitter<MCQState> emit) async {
    try {
      final response = await _tikTokRepository.fetchAnswers(event.id);
      emit(MCQStateAnswerLoadedSuccess(response));
    } catch (error) {
      emit(MCQStateError(error.toString()));
    }
  }
}
