import 'package:flutter/cupertino.dart';

class ChatMessage{
  int? conversationId;
  int? messageId;
  String? messageText;
  String? messageType;
  String? messageTime;

  ChatMessage({@required this.conversationId,@required this.messageId,@required this.messageText,@required this.messageType,@required this.messageTime});


  Map<String, dynamic> toMap() {
    return {
      'conversation_id': conversationId,
      'message_id': messageId,
      'message_text': messageText,
      'message_type': messageType,
    };
  }

  ChatMessage.fromMap(Map<String, dynamic> res)
      : conversationId = res["conversation_id"],
        messageId = res["message_id"],
        messageText = res["message_text"],
        messageType = res["message_type"];


}