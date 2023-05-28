import 'package:cross_mobile/theme/app_theme.dart';
import 'package:cross_mobile/utils/dependencies.dart';
import 'package:cross_mobile/flashcard_mcq/bloc/following/flash_card_bloc.dart';
import 'package:cross_mobile/flashcard_mcq/bloc/foryou/mcq_bloc.dart';
import 'package:cross_mobile/home_screen.dart';
import 'package:cross_mobile/timer/bloc/timer_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt.get<TimerBloc>()..add(TimerEventStart()),
        ),
        BlocProvider(
          create: (context) => getIt.get<FlashCardBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt.get<MCQBloc>(),
        ),
      ],
      child: MaterialApp(
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        home: const HomeScreenWidget(),
      ),
    );
  }
}
