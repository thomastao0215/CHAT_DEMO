import 'package:flutter/cupertino.dart';

class ChatMessage{
  String? conversationId;
  String? messageId;
  String? messageText;
  String? messageType;
  String? messageTime;

  ChatMessage({@required this.conversationId,@required this.messageId,@required this.messageText,@required this.messageType,@required this.messageTime});


  Map<String, dynamic> toMap() {
    return {
      'conversation_id': conversationId,
      'message_id': messageId,
      'messageText': messageText,
      'message_type': messageType,
      'message_time': messageTime,
    };
  }

  ChatMessage.fromMap(Map<String, dynamic> res)
      : conversationId = res["conversation_id"],
        messageText = res["message_text"];


}