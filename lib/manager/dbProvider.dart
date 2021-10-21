import 'package:chat_demo/model/chatConversation.dart';
import 'package:chat_demo/model/chatMessage.dart';
import 'package:chat_demo/model/chatUser.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHandler {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'databasexxx'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE conversations(conversation_id INTEGER PRIMARY KEY AUTOINCREMENT, chat_user INTEGER,message_text TEXT,time TEXT)",
        );
        await database.execute(
          "CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, message_text TEXT ,avatar_url TEXT)",
        );

        await database.execute(
          "CREATE TABLE messages(message_id INTEGER, conversation_id INTEGER,message_text TEXT,message_type TEXT,PRIMARY KEY(message_id,conversation_id))",
        );

      },
      version: 1,
    );
  }

  Future<int> insertUser(List<ChatUser> users) async {
    int result = 0;
    final Database db = await initializeDB();
    for(var user in users){
      result = await db.insert('users', user.toMap());
    }
    return result;
  }

  Future<int> sendMessage(ChatMessage message) async {
    int result = 0;
    final Database db = await initializeDB();
    result = await db.insert('messages', message.toMap());
    return result;
  }


  Future<int> insertConversations(List<ChatConversation> conversations) async {
    int result = 0;
    final Database db = await initializeDB();
    for(var conversation in conversations){
      result = await db.insert('conversations', conversation.toMap());
    }
    return result;
  }


  Future<int> insertMessages(List<ChatMessage> messages) async {
    int result = 0;
    final Database db = await initializeDB();
    for(var message in messages){
      result = await db.insert('messages', message.toMap());
    }
    return result;
  }



  Future<List<ChatConversation>> retrieveConversations() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query('conversations');
    return queryResult.map((e) => ChatConversation.fromMap(e)).toList();
  }

  Future<List<ChatUser>> retrieveChatUser() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query('users');
    return queryResult.map((e) => ChatUser.fromMap(e)).toList();
  }

  Future<List<ChatMessage>> retrieveChatMessage(int conversation_id) async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query('messages',where: 'conversation_id =${conversation_id}');
    return queryResult.map((e) => ChatMessage.fromMap(e)).toList();
  }

}