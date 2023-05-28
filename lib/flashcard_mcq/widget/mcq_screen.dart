import 'package:cross_mobile/flashcard_mcq/bloc/foryou/mcq_bloc.dart';
import 'package:cross_mobile/flashcard_mcq/models/mcq_model.dart';
import 'package:cross_mobile/flashcard_mcq/models/mcq_option.dart';
import 'package:cross_mobile/flashcard_mcq/widget/user_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MCQScreen extends StatefulWidget {
  final MCQModel mcqModel;

  const MCQScreen({Key? key, required this.mcqModel}) : super(key: key);

  @override
  State<MCQScreen> createState() => _MCQScreenState();
}

class _MCQScreenState extends State<MCQScreen> {
  MCQOption? selectedAnswer;
  List<MCQOption>? correctAnswers;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xff0A222E), Color(0xff173B50)])),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Flexible(child: _mcqWidget()),
          const SizedBox(
            height: 16,
          ),
          _userInfoWidget()
        ],
      ),
    );
  }

  Widget _mcqWidget() {
    return Column(
      children: [_questionWidget(), const Spacer(), _mcqOptionsWidget()],
    );
  }

  Widget _questionWidget() {
    return Text(
      "${widget.mcqModel.question}  ",
      style: const TextStyle(fontSize: 18, color: Colors.white),
    );
  }

  Widget _userInfoWidget() => UserInfoWidget(user: widget.mcqModel.user);

  Widget _mcqOptionsWidget() {
    return BlocListener<MCQBloc, MCQState>(
      listener: (context, state) {
        if (state is MCQStateAnswerLoadedSuccess) {
          setState(() {
            correctAnswers = state.answers;
          });
        }
      },
      child: Column(
        children: widget.mcqModel.options.map((e) => _mcqOptionItem(e)).toList(),
      ),
    );
  }

  Widget _mcqOptionItem(MCQOption option) {
    MCQOptionState state = _getState(option);
    return GestureDetector(
      onTap: () => {
        if (selectedAnswer == null) {_onOptionTapped(option)}
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(color: _optionColor(state), borderRadius: BorderRadius.circular(8)),
        width: double.infinity,
        constraints: const BoxConstraints(minHeight: 50),
        child: Row(
          children: [
            Flexible(
                child: Text(
              option.answer,
              style: const TextStyle(color: Colors.white),
            )),
            if (selectedAnswer != null) ...[_getIcon(state)]
          ],
        ),
      ),
    );
  }

  Color _optionColor(MCQOptionState state) {
    switch (state) {
      case MCQOptionState.correct:
        return const Color(0xff53A68B);
      case MCQOptionState.incorrect:
        return const Color(0xff80403E);
      case MCQOptionState.notSelected:
        return const Color(0xff395563);
    }
  }

  Widget _getIcon(MCQOptionState state) {
    switch (state) {
      case MCQOptionState.correct:
        return const Icon(
          Icons.check_circle,
          color: Color(0xff53A68B),
        );
      case MCQOptionState.incorrect:
        return const Icon(
          Icons.cancel,
          color: Color(0xff80403E),
        );
      case MCQOptionState.notSelected:
        return const SizedBox();
    }
  }

  _onOptionTapped(MCQOption option) {
    selectedAnswer = option;
    context.read<MCQBloc>().add(MCQEventFetchAnswer(widget.mcqModel.id.toString()));
  }

  MCQOptionState _getState(MCQOption option) {
    if (selectedAnswer == null) {
      return MCQOptionState.notSelected;
    } else {
      if (selectedAnswer == option) {
        if (correctAnswers?.contains(option) == true) {
          return MCQOptionState.correct;
        } else {
          return MCQOptionState.incorrect;
        }
      } else {
        if (correctAnswers?.contains(option) == true) {
          return MCQOptionState.correct;
        }
        return MCQOptionState.notSelected;
      }
    }
  }
}

enum MCQOptionState { incorrect, correct, notSelected }
