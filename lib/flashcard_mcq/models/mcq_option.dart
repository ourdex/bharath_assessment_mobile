import 'dart:collection';

class MCQOption {
  final String id;
  final String answer;

  MCQOption(this.id, this.answer);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = HashMap();
    map["id"] = id;
    map["name"] = answer;
    return map;
  }

  factory MCQOption.fromJson(Map<String, dynamic> map) => MCQOption(map["id"], map["answer"]);

  @override
  bool operator ==(Object other) => other is MCQOption && id == other.id;

  @override
  int get hashCode => id.hashCode ^ answer.hashCode;
}
