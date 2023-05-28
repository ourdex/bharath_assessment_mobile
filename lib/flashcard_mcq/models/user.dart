import 'dart:collection';

class User {
  final String name;
  final String avatar;

  User(this.name, this.avatar);

  factory User.fromJson(Map<String, dynamic> map) => User(map["name"], map["avatar"]);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = HashMap();
    map["name"] = name;
    map["avatar"] = avatar;
    return map;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User && runtimeType == other.runtimeType && name == other.name && avatar == other.avatar;

  @override
  int get hashCode => name.hashCode ^ avatar.hashCode;
}
