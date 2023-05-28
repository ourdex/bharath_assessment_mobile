import 'dart:collection';

import 'package:cross_mobile/flashcard_mcq/models/user.dart';

class FlashCard {
  final String type;
  final int id;
  final String playlist;
  final String flashCardFront;
  final String flashCardBack;
  final String description;
  User user;

  FlashCard(this.type, this.id, this.playlist, this.flashCardFront, this.flashCardBack, this.description, this.user);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FlashCard &&
          runtimeType == other.runtimeType &&
          type == other.type &&
          id == other.id &&
          playlist == other.playlist &&
          flashCardFront == other.flashCardFront &&
          flashCardBack == other.flashCardBack &&
          description == other.description;

  @override
  int get hashCode =>
      type.hashCode ^
      id.hashCode ^
      playlist.hashCode ^
      flashCardFront.hashCode ^
      flashCardBack.hashCode ^
      description.hashCode;

  factory FlashCard.fromJson(Map<String, dynamic> map) => FlashCard(map["type"], map["id"], map["playlist"],
      map["flashcard_front"], map["flashcard_back"], map["description"], User.fromJson(map["user"]));

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = HashMap();
    map["type"] = type;
    map["id"] = id;
    map["playlist"] = playlist;
    map["flashcard_front"] = flashCardFront;
    map["flashcard_back"] = flashCardBack;
    map["description"] = description;
    map["user"] = user.toJson();
    return map;
  }
}
