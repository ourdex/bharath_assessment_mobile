import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cross_mobile/utils/dependencies.dart';
import 'package:cross_mobile/flashcard_mcq/models/flash_card.dart';

import '../../repositories/tiktok_repository.dart';

part 'flash_card_event.dart';

part 'flash_card_state.dart';

class FlashCardBloc extends Bloc<FlashCardEvent, FlashCardState> {
  late TikTokRepository tikTokRepository;

  FlashCardBloc() : super(FollowingInitial()) {
    tikTokRepository = getIt.get<TikTokRepository>();
    on<FlashCardEventFetchNext>((event, emit) => _fetchNext(event, emit));
  }

  Future _fetchNext(FlashCardEventFetchNext event, Emitter<FlashCardState> emit) async {
    emit(FlashCardStateLoading());
    try {
      FlashCard flashCard = await tikTokRepository.fetchNextFollowing();
      emit(FlashCardStateSuccess([flashCard]));
    } catch (error) {
      emit(FlashCardStateError(error.toString()));
    }
  }
}
