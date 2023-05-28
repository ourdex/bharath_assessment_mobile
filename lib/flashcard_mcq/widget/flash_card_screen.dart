import 'package:cross_mobile/flashcard_mcq/models/flash_card.dart';
import 'package:cross_mobile/flashcard_mcq/widget/user_info_widget.dart';
import 'package:cross_mobile/l10n/gen/app_localizations.dart';
import 'package:flutter/material.dart';

import '../../l10n/l.dart';

class FlashCardScreen extends StatefulWidget {
  final FlashCard flashCard;

  const FlashCardScreen({Key? key, required this.flashCard}) : super(key: key);

  @override
  State<FlashCardScreen> createState() => _FlashCardScreenState();
}

class _FlashCardScreenState extends State<FlashCardScreen> {
  bool showAnswer = false;

  AppLocalizations get locale => L.of(context);

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
          Flexible(
              child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => _onTap(),
            child: showAnswer ? _detailAnswerWidget() : Center(child: _questionWidget()),
          )),
          const SizedBox(
            height: 16,
          ),
          _userInfoWidget()
        ],
      ),
    );
  }

  Widget _answerWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          locale.answer,
          style: const TextStyle(color: Colors.greenAccent, fontSize: 12),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            widget.flashCard.flashCardBack,
            style: const TextStyle(color: Colors.white70, fontSize: 18),
          ),
        )
      ],
    );
  }

  Widget _detailAnswerWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [_questionWidget(), _seperatorWidget(), _answerWidget(), const Spacer(), _moreInfoWidget()],
    );
  }

  Widget _questionWidget() {
    return Text(
      widget.flashCard.flashCardFront,
      style: const TextStyle(fontSize: 18, color: Colors.white),
    );
  }

  Widget _seperatorWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      margin: const EdgeInsets.symmetric(vertical: 24),
      height: 2,
      color: Colors.white10,
    );
  }

  List<Widget> get _options => [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: _optionItem(Colors.deepOrangeAccent, 1),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: _optionItem(Colors.orange, 2),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: _optionItem(Colors.yellow, 3),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: _optionItem(Colors.green.shade300, 4),
        ),
        _optionItem(Colors.green, 5),
      ];

  Widget _moreInfoWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            locale.howWellDoYouKnow,
            style: const TextStyle(color: Colors.white38),
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: _options,
          )
        ],
      ),
    );
  }

  Widget _optionItem(Color color, int index) {
    return GestureDetector(
      onTap: () => _onOptionSelected(index),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(8)), color: color),
        child: Center(
          child: Text("$index"),
        ),
      ),
    );
  }

  void _onTap() {
    setState(() {
      showAnswer = !showAnswer;
    });
  }

  _onOptionSelected(int index) {
    // TODO: Implementation for option selection
  }

  Widget _userInfoWidget() => UserInfoWidget(user: widget.flashCard.user);
}
