import 'package:chat_demo/manager/dbProvider.dart';
import 'package:chat_demo/page/chatListPage.dart';
import 'package:flutter/material.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();

  runApp(App());
}

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChattList',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: ChatListPage(title: "Chat Demo",)
    );
  }
}