part of 'flash_card_bloc.dart';

abstract class FlashCardState {}

class FollowingInitial extends FlashCardState {}

class FlashCardStateLoading extends FlashCardState {}

class FlashCardStateSuccess extends FlashCardState {
  List<FlashCard> flashCards;

  FlashCardStateSuccess(this.flashCards);
}

class FlashCardStateError extends FlashCardState {
  String error;

  FlashCardStateError(this.error);
}
