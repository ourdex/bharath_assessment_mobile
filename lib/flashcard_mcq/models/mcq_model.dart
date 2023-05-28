import 'dart:collection';

import 'package:cross_mobile/flashcard_mcq/models/mcq_option.dart';
import 'package:cross_mobile/flashcard_mcq/models/user.dart';

class MCQModel {
  final String type;
  final int id;
  final String playlist;
  final String question;
  final String description;
  User user;
  List<MCQOption> options;

  MCQModel(this.type, this.id, this.playlist, this.question, this.description, this.user, this.options);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MCQModel &&
          runtimeType == other.runtimeType &&
          type == other.type &&
          id == other.id &&
          playlist == other.playlist &&
          question == other.question &&
          description == other.description &&
          user == other.user;

  @override
  int get hashCode =>
      type.hashCode ^ id.hashCode ^ playlist.hashCode ^ question.hashCode ^ description.hashCode ^ user.hashCode;

  factory MCQModel.fromJson(Map<String, dynamic> map) => MCQModel(
      map["type"],
      map["id"],
      map["playlist"],
      map["question"],
      map["description"],
      User.fromJson(map["user"]),
      (map["options"] as List<dynamic>).cast<Map<String, dynamic>>().map((e) => MCQOption.fromJson(e)).toList());

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = HashMap();
    map["type"] = type;
    map["id"] = id;
    map["playlist"] = playlist;
    map["question"] = question;
    map["description"] = description;
    map["user"] = user.toJson();
    map["options"] = options.map((e) => e.toJson());
    return map;
  }
}
