import 'package:cross_mobile/flashcard_mcq/models/user.dart';
import 'package:flutter/material.dart';

class UserInfoWidget extends StatelessWidget {
  final User user;

  const UserInfoWidget({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          user.name,
          style: const TextStyle(color: Colors.white, fontSize: 14),
        )
      ],
    );
  }
}
