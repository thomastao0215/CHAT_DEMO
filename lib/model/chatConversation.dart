import 'package:chat_demo/model/chatMessage.dart';
import 'package:chat_demo/model/chatUser.dart';
import 'package:flutter/cupertino.dart';

class ChatConversation{
  int? conversationId;
  int? chatUser;
  String? time;
  String? messageText;
  int? isRead;
  String? chatUserStr;
  List<ChatMessage>? messageList;

  ChatConversation({
    this.conversationId,
    this.chatUser,
    this.time,
    this.messageText,
    this.isRead,
    this.messageList
  });

  ChatConversation.fromMap(Map<String, dynamic> res)
      : conversationId = res["conversation_id"],
        chatUser = res["chat_user"],
        messageText = res["message_text"],
        time = res["time"],
        isRead = 1;

  Map<String, dynamic> toMap() {
    return {
      'conversation_id': conversationId,
      'chat_user': chatUser,
      'message_text': messageText,
      'time': time
    };
  }

}