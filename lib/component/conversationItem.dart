import 'package:chat_demo/page/chatDetailPage.dart';
import 'package:chat_demo/main.dart';
import 'package:chat_demo/model/chatConversation.dart';
import 'package:chat_demo/model/chatUser.dart';
import 'package:flutter/material.dart';

class ConversationItem extends StatefulWidget {
  ChatConversation? chatConversation;
  List<ChatUser> users;

  ConversationItem({@required this.chatConversation,required this.users});

  @override
  _ConversationItemState createState() => _ConversationItemState();
}
class _ConversationItemState extends State<ConversationItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatDetailPage(chatConversation: widget.chatConversation,users: widget.users,)),
          );
      },
      child: Container(
        padding: EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(widget.users[widget.chatConversation!.chatUser!].avatarURL!),
                    maxRadius: 30,
                  ),
                  SizedBox(width: 16,),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(widget.users[widget.chatConversation!.chatUser!].name!, style: TextStyle(fontSize: 16),),
                          SizedBox(height: 6,),
                          Text(widget.chatConversation!.messageText!,style: TextStyle(fontSize: 13,color: Colors.grey.shade600, fontWeight: widget.chatConversation!.isRead! == 1?FontWeight.bold:FontWeight.normal),),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(widget.chatConversation!.time!,style: TextStyle(fontSize: 12,fontWeight: widget.chatConversation!.isRead! == 1 ?FontWeight.bold:FontWeight.normal),),
          ],
        ),
      ),
    );
  }
}