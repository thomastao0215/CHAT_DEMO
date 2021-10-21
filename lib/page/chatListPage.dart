import 'package:chat_demo/manager/dbProvider.dart';
import 'package:chat_demo/model/chatConversation.dart';
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
        await this.queryUsers();
      });
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
      ChatUser(name: "Jack", avatarURL: "https://randomuser.me/api/portraits/men/2.jpg", time: "Yesterday"),
      ChatUser(name: "Henry",  avatarURL: "https://randomuser.me/api/portraits/men/3.jpg", time: "20 Sep"),
      ChatUser(name: "Julia",  avatarURL: "https://randomuser.me/api/portraits/women/4.jpg", time: "1 Oct"),
      ChatUser(name: "Jane Russel", messageText: "Awesome Setup", avatarURL: "https://randomuser.me/api/portraits/women/2.jpg", time: "Now"),
      ChatUser(name: "Glady's Murphy", messageText: "That's Great", avatarURL: "https://randomuser.me/api/portraits/men/9.jpg", time: "Yesterday"),
      ChatUser(name: "Jorge Henry", messageText: "Hey where are you?", avatarURL: "https://randomuser.me/api/portraits/women/7.jpg", time: "31 Mar"),
      ChatUser(name: "Philip Fox", messageText: "Busy! Call me in 20 mins", avatarURL: "https://randomuser.me/api/portraits/women/11.jpg", time: "28 Mar"),
    ];
    return await this.handler.insertUser(chatUsers);
  }

  Future<int> addConversations() async {
    final List<ChatUser> chatUsers = [
      ChatUser(name: "Jack", avatarURL: "https://randomuser.me/api/portraits/men/2.jpg", time: "Yesterday"),
      ChatUser(name: "Henry",  avatarURL: "https://randomuser.me/api/portraits/men/3.jpg", time: "20 Sep"),
      ChatUser(name: "Julia",  avatarURL: "https://randomuser.me/api/portraits/women/4.jpg", time: "1 Oct"),
      ChatUser(name: "Jane Russel", messageText: "Awesome Setup", avatarURL: "https://randomuser.me/api/portraits/women/2.jpg", time: "Now"),
      ChatUser(name: "Glady's Murphy", messageText: "That's Great", avatarURL: "https://randomuser.me/api/portraits/men/9.jpg", time: "Yesterday"),
      ChatUser(name: "Jorge Henry", messageText: "Hey where are you?", avatarURL: "https://randomuser.me/api/portraits/women/7.jpg", time: "31 Mar"),
      ChatUser(name: "Philip Fox", messageText: "Busy! Call me in 20 mins", avatarURL: "https://randomuser.me/api/portraits/women/11.jpg", time: "28 Mar"),
    ];
    final List<ChatConversation> chatConversations  = [
      ChatConversation(chatUser: chatUsers[0].id, time: "Now",messageText: "Awesome Setup",isRead: false),
      ChatConversation(chatUser: chatUsers[1].id, time: "Yesterday",messageText: "That's Great",isRead: false),
      ChatConversation(chatUser: chatUsers[2].id, time:  "31 Mar",messageText: "Hey where are you?",isRead: true),
      ChatConversation(chatUser: chatUsers[3].id, time:  "28 Mar",messageText: "Busy! Call me in 20 mins",isRead: true)
    ];
    return await this.handler.insertConversations(chatConversations);
  }



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
        child: RefreshIndicator(
          onRefresh: () =>_pullToRefresh(context),
          child: FutureBuilder<List<ChatConversation>>(
            future: mockNetworkData(),
            builder: (context,snapshot){
              if (snapshot.hasError) print(snapshot.error);
              return snapshot.hasData ?
              ListView.builder(
                  itemCount:  snapshot.data!.length,
                  itemBuilder: (context,index) {
                    return ConversationItem(
                        chatConversation:  snapshot.data![index],
                        users: users
                    );
                  }
              ) :Center(child: CircularProgressIndicator());
            },

          )
        ),
      )
    );
  }
  Future<void> _pullToRefresh(BuildContext context) async {
    var result = this.handler.retrieveConversations();
  }

  Future<List<ChatConversation>> mockNetworkData() async {
    return this.handler.retrieveConversations();
  }


  Future fetchFruit() async {
    return this.handler.retrieveConversations();
  }


}

