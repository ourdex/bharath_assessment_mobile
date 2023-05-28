import 'package:cross_mobile/flashcard_mcq/bloc/following/flash_card_bloc.dart';
import 'package:cross_mobile/flashcard_mcq/bloc/foryou/mcq_bloc.dart';
import 'package:cross_mobile/flashcard_mcq/models/flash_card.dart';
import 'package:cross_mobile/flashcard_mcq/models/mcq_model.dart';
import 'package:cross_mobile/flashcard_mcq/widget/flash_card_screen.dart';
import 'package:cross_mobile/flashcard_mcq/widget/mcq_screen.dart';
import 'package:cross_mobile/l10n/gen/app_localizations.dart';
import 'package:cross_mobile/timer/bloc/timer_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'l10n/l.dart';

class HomeScreenWidget extends StatefulWidget {
  const HomeScreenWidget({Key? key}) : super(key: key);

  @override
  State<HomeScreenWidget> createState() => _HomeScreenWidgetState();
}

class _HomeScreenWidgetState extends State<HomeScreenWidget> {
  int currentIndex = 0;

  AppLocalizations get locale => L.of(context);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: _appBar(),
          bottomNavigationBar: _bottomNavigationBar(),
          body: currentIndex == 0 ? _flashCardWidget() : _mcqWidget(),
        ));
  }

  AppBar _appBar() {
    return AppBar(
      leading: _timerWidget(),
      leadingWidth: 100,
      title: _tabBar(),
      actions: [
        IconButton(onPressed: () => _search(), icon: const Icon(Icons.search)),
      ],
    );
  }

  Widget _timerWidget() {
    return BlocBuilder<TimerBloc, TimerState>(
      builder: (context, state) {
        if (state is TimerInitial) {
          context.read<TimerBloc>().add(TimerEventStart());
        }
        return Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Row(
            children: [const Icon(Icons.timer), Text(state.formattedTimeLeft)],
          ),
        );
      },
    );
  }

  Widget _tabBar() {
    return TabBar(
      tabs: [
        Tab(
          text: locale.following,
        ),
        Tab(
          text: locale.forYou,
        )
      ],
      indicatorWeight: 5,
      indicatorPadding: const EdgeInsets.symmetric(horizontal: 40.0),
      indicatorColor: Colors.white,
      onTap: (value) => {
        setState(() {
          if (currentIndex != value) {
            if (currentIndex == 0) {
              context.read<FlashCardBloc>().add(FlashCardEventFetchNext());
            } else {
              context.read<MCQBloc>().add(MCQEventFetchNext());
            }
          }
          currentIndex = value;
        })
      },
    );
  }

  void _search() {
    // TODO: Implement the search logic
  }

  Widget _bottomNavigationBar() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.home),
          label: locale.home,
        ),
        BottomNavigationBarItem(icon: const Icon(Icons.assistant_navigation), label: locale.discover),
        BottomNavigationBarItem(icon: const Icon(Icons.timer), label: locale.activity),
        BottomNavigationBarItem(icon: const Icon(Icons.bookmark), label: locale.bookmarks),
        BottomNavigationBarItem(icon: const Icon(Icons.account_circle), label: locale.profile),
      ],
      backgroundColor: Colors.black,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white.withOpacity(0.5),
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (_) => {},
    );
  }

  Widget? _flashCardItemBuilder(BuildContext context, FlashCard flashCard, BoxConstraints constraints) {
    return SizedBox(
      height: constraints.maxHeight,
      child: FlashCardScreen(flashCard: flashCard),
    );
  }

  Widget _flashCardWidget() {
    return BlocBuilder<FlashCardBloc, FlashCardState>(
      builder: (context, state) {
        if (state is FlashCardStateSuccess) {
          return LayoutBuilder(
            builder: (context, constraints) => ListView.builder(
                itemBuilder: (context, index) => _flashCardItemBuilder(context, state.flashCards[index], constraints),
                itemCount: state.flashCards.length),
          );
        } else if (state is FlashCardStateError) {
          return Center(
            child: Text(state.error),
          );
        } else if (state is FlashCardStateLoading) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.deepOrangeAccent),
          );
        } else {
          context.read<FlashCardBloc>().add(FlashCardEventFetchNext());
          return Container();
        }
      },
    );
  }

  Widget _mcqWidget() {
    return BlocBuilder<MCQBloc, MCQState>(
      buildWhen: (previous, current) => current is! MCQStateAnswerLoadedSuccess,
      builder: (context, state) {
        if (state is MCQStateSuccess) {
          return LayoutBuilder(
            builder: (context, constraints) => ListView.builder(
                itemBuilder: (context, index) => _mcqItemBuilder(context, state.mcqs[index], constraints),
                itemCount: state.mcqs.length),
          );
        } else if (state is MCQStateError) {
          return Center(
            child: Text(state.error),
          );
        } else if (state is MCQStateLoading) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.deepOrangeAccent),
          );
        } else {
          context.read<MCQBloc>().add(MCQEventFetchNext());
          return Container();
        }
      },
    );
  }

  Widget _mcqItemBuilder(BuildContext context, MCQModel mcq, BoxConstraints constraints) {
    return SizedBox(
      height: constraints.maxHeight,
      child: MCQScreen(
        mcqModel: mcq,
      ),
    );
  }
}
