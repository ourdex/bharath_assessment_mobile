import 'package:cross_mobile/api_service.dart';
import 'package:cross_mobile/flashcard_mcq/bloc/following/flash_card_bloc.dart';
import 'package:cross_mobile/flashcard_mcq/bloc/foryou/mcq_bloc.dart';
import 'package:cross_mobile/flashcard_mcq/repositories/tiktok_repository.dart';
import 'package:cross_mobile/timer/bloc/timer_bloc.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.asNewInstance();

void initializeDependencies() async {
  // Register Repositories and Services
  getIt.registerFactory<APIService>(() => APIService());
  getIt.registerFactory<TikTokRepository>(() => TikTokRepository(getIt.get<APIService>()));

  // Register Blocs

  getIt.registerFactory<TimerBloc>(() => TimerBloc());
  getIt.registerFactory<FlashCardBloc>(() => FlashCardBloc());
  getIt.registerFactory<MCQBloc>(() => MCQBloc());
}
