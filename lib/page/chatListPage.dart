import 'package:chat_demo/manager/dbProvider.dart';
import 'package:chat_demo/model/chatConversation.dart';
import 'package:chat_demo/model/chatMessage.dart';
import 'package:chat_demo/model/chatUser.dart';
import 'package:chat_demo/component/conversationItem.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';


class ChatListPage extends StatefulWidget {
  ChatListPage({Key? key, this.title}) : super(key: key);
  String? title = 'title';


  @override
  _ChatListPageState createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {

  late DatabaseHandler handler;
  late List<ChatUser> users = [];

  @override
  void initState()  {
    super.initState();


    this.handler = DatabaseHandler();
    this.handler.initializeDB().whenComplete(() async {
      await this.addUsers().whenComplete(() async {
        await this.addConversations();
        // await this.addMessages();
      });
      await this.queryUsers();
    });

  }

  Future<void> queryUsers() async {
    var result = this.handler.retrieveChatUser();
    setState(() {
      result.then((value) => {
        users = value
      });
    });
  }

  Future<int> addUsers() async {
    final List<ChatUser> chatUsers = [
      ChatUser(id:0,name: "Jack", avatarURL: "https://randomuser.me/api/portraits/men/2.jpg", time: "Yesterday"),
      ChatUser(id:1,name: "Henry",  avatarURL: "https://randomuser.me/api/portraits/men/3.jpg", time: "20 Sep"),
      ChatUser(id:2,name: "Julia",  avatarURL: "https://randomuser.me/api/portraits/women/4.jpg", time: "1 Oct"),
      ChatUser(id:3,name: "Jane Russel", messageText: "Awesome Setup", avatarURL: "https://randomuser.me/api/portraits/women/2.jpg", time: "Now"),
    ];
    return await this.handler.insertUser(chatUsers);
  }

  Future<int> addConversations() async {
    final List<ChatConversation> chatConversations  = [
      ChatConversation(chatUser: 0, time: "Now",messageText: "Awesome Setup",isRead: 0),
      ChatConversation(chatUser: 1, time: "Yesterday",messageText: "That's Great",isRead: 1),
      ChatConversation(chatUser: 2, time:  "31 Mar",messageText: "Hey where are you?",isRead: 0),
      ChatConversation(chatUser: 3, time:  "28 Mar",messageText: "Busy! Call me in 20 mins",isRead: 1),
    ];
    return await this.handler.insertConversations(chatConversations);
  }

  // Future<int> addMessages() async {
  //   List<ChatMessage> messages = [
  //     ChatMessage(conversationId:0,messageId:0,messageText: "Hello, Will", messageType: "receiver"),
  //     ChatMessage(conversationId:0,messageId:1,messageText: "How have you been?", messageType: "receiver"),
  //     ChatMessage(conversationId:0,messageId:2,messageText: "Hey Kriss, I am doing fine dude. wbu?", messageType: "sender"),
  //     ChatMessage(conversationId:0,messageId:3,messageText: "ehhhh, doing OK.", messageType: "receiver"),
  //     ChatMessage(conversationId:0,messageId:4,messageText: "Is there any thing wrong?", messageType: "sender"),
  //     ChatMessage(conversationId:0,messageId:5,messageText: "ehhhh, doing OK.", messageType: "receiver"),
  //   ];
  //   return await this.handler.insertMessages(messages);
  // }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title!),
        backgroundColor: Colors.white,
      ),
      body: Container(
          child: FutureBuilder<List<ChatConversation>>(
            future: mockNetworkData(),
            builder: (context,snapshot){
              if (snapshot.hasError) print(snapshot.error);
              print( snapshot.data!.length);
              return snapshot.hasData ?
              ListView.builder(
                  itemCount:  snapshot.data!.length,
                  itemBuilder: (context,index) {
                    print(index);
                    return ConversationItem(
                        chatConversation:  snapshot.data![index],
                        users: users
                    );
                  }
              ) :Center(child: CircularProgressIndicator());
            },

          )
      )
    );
  }

  Future<List<ChatConversation>> mockNetworkData() async {
    return this.handler.retrieveConversations();
  }




}

