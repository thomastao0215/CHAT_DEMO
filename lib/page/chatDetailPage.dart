import 'package:chat_demo/model/chatConversation.dart';
import 'package:chat_demo/model/chatMessage.dart';
import 'package:chat_demo/manager/dbProvider.dart';
import 'package:chat_demo/component/messageItem.dart';
import 'package:chat_demo/model/chatUser.dart';
import 'package:flutter/material.dart';


class ChatDetailPage extends StatefulWidget {
  ChatDetailPage({Key? key, this.chatConversation,required this.users}) : super(key: key);

  final ChatConversation? chatConversation;
  final List<ChatUser> users;


  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {

  late DatabaseHandler handler;

  List<ChatMessage> messages = [];

  late ChatMessage send_message;

  final fieldText = TextEditingController();



  Future<void> _pullToRefresh(BuildContext context) async {

  }

  Future sendMessage() async {
    var message = ChatMessage(conversationId: widget.chatConversation?.conversationId!, messageId: messages.length, messageText: fieldText.text, messageType: 'sender', messageTime: 'now');
    fieldText.clear();
    await this.handler.sendMessage(message).then((value) => {
      fetchMessages().then((value){
        setState(() {
          messages = value;
        });
      })
    });
  }

  Future replyMessage() async {
    var message = ChatMessage(conversationId: widget.chatConversation?.conversationId!, messageId: messages.length, messageText: messages[messages.length-1].messageText, messageType: 'receiver', messageTime: 'now');
    await this.handler.sendMessage(message).then((value) => {
      fetchMessages().then((value){
        setState(() {
          messages = value;
        });
      })
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.handler = DatabaseHandler();
    fetchMessages().then((value){
      setState(() {
          messages = value;
      });
    });

  }

  Future<List<ChatMessage>> fetchMessages() async {
    return await this.handler.retrieveChatMessage(widget.chatConversation!.conversationId!);
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          flexibleSpace: SafeArea(
            child: Container(
              padding: EdgeInsets.only(right: 16),
              child: Row(
                children: <Widget>[
                  IconButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back,color: Colors.black,),
                  ),
                  SizedBox(width: 2,),
                  CircleAvatar(
                    backgroundImage: NetworkImage(widget.users[widget.chatConversation!.chatUser!].avatarURL!),
                    maxRadius: 20,
                  ),
                  SizedBox(width: 12,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(widget.users[widget.chatConversation!.chatUser!].name!,style: TextStyle( fontSize: 16 ,fontWeight: FontWeight.w600),),
                        SizedBox(height: 6,),
                        Text("Online",style: TextStyle(color: Colors.grey.shade600, fontSize: 13),),
                      ],
                    ),
                  ),
                  Icon(Icons.settings,color: Colors.black54,),
                ],
              ),
            ),
          ),
        ),
        body: Stack(
          children: <Widget>[
            RefreshIndicator(
                child: ListView.builder(
                  itemCount: messages.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.only(top: 10,bottom: 10),
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, index){
                    return MessageItem(message: messages[index]);
                  },
                ),
                onRefresh: () =>_pullToRefresh(context),
                // onRefresh: _pullToRefresh
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: EdgeInsets.only(left: 10,bottom: 10,top: 10),
                height: 60,
                width: double.infinity,
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: (){
                      },
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: Colors.lightBlue,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Icon(Icons.camera_alt, color: Colors.white, size: 20, ),
                      ),
                    ),
                    SizedBox(width: 15,),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: "Write message...",
                            hintStyle: TextStyle(color: Colors.black54),
                            border: InputBorder.none
                        ),

                        controller: fieldText,
                      ),
                    ),
                    SizedBox(width: 15,),
                    FloatingActionButton(
                      onPressed: (){
                        sendMessage();
                        Future.delayed(Duration(seconds: 1), () {
                          // 5 seconds over, navigate to Page2.
                          replyMessage();
                        });
                      },
                      child: Icon(Icons.send,color: Colors.white,size: 18,),
                      backgroundColor: Colors.amber,
                      elevation: 0,
                    ),
                  ],

                ),
              ),
            ),
          ],
        ),


    );


  }
}
