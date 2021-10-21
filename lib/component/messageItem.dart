import 'package:chat_demo/model/chatMessage.dart';
import 'package:flutter/material.dart';

class MessageItem extends StatefulWidget {
  ChatMessage? message;


  MessageItem({@required this.message});

  @override
  _MessageItemState createState() => _MessageItemState();
}

class _MessageItemState extends State<MessageItem> {

  bool is_good = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.message?.messageText);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        setState(() {
          is_good = !is_good;
        });
      },
      child: Container(
        padding: EdgeInsets.only(left: 14,right: 14,top: 10,bottom: 10),
        child: Align(
          alignment: (widget.message?.messageType == "receiver"?Alignment.topLeft:Alignment.topRight),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: (widget.message?.messageType  == "receiver"?Colors.grey.shade200:Colors.blue[200]),
            ),
            padding: EdgeInsets.all(16),
            child: Text(widget.message?.messageText != null ? "${widget.message?.messageText} ${is_good == true ?"👍":""}":"", style: TextStyle(fontSize: 15),),
          ),
        ),
      )
    );
  }
}