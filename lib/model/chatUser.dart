import 'package:flutter/cupertino.dart';

class ChatUser {
  int? id;
  String? name;
  String? messageText;
  String? avatarURL;
  String? time;

  ChatUser(
      {@required this.name, @required this.messageText, @required this.avatarURL, @required this.time});

  ChatUser.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        name = res["name"],
        avatarURL = res["avatar_url"];


  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'avatar_url': avatarURL};
  }


}