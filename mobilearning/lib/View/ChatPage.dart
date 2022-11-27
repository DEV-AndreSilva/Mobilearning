// ignore_for_file: prefer_const_constructors, file_names, must_be_immutable
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobilearning/Models/chatUsersModel.dart';
import 'package:mobilearning/Widgets/ConversationList.dart';

class ChatPage extends StatefulWidget {
  int idUserLogin;

  ChatPage({super.key, required this.idUserLogin});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  String textSearch = "";
  List<ChatUsers> chatUsers = [];

  void runFilter(String filter) {
    textSearch = filter;
  }

  Stream<List<ChatUsers>> readUsersList() {
    if (textSearch != "") {
      return FirebaseFirestore.instance
          .collection("Users")
          .where(
            "userUid",
            isNotEqualTo: widget.idUserLogin,
          )
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => ChatUsers.fromJson(doc.data()))
              .where((element) => element.name
                  .toUpperCase()
                  .startsWith(textSearch.toUpperCase()))
              .toList());
    } else {
      return FirebaseFirestore.instance
          .collection("Users")
          .where("userUid", isNotEqualTo: widget.idUserLogin)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => ChatUsers.fromJson(doc.data()))
              .toList());
    }
  }

  Widget buildChatUsers(ChatUsers chat) {
    {
      return ConversationList(
        idUserLogin: widget.idUserLogin,
        userUid: chat.userUid,
        name: chat.name,
        imageURL: chat.imageURL,
        createTime: chat.createTime,
        status: chat.status,
        lastLogin: chat.lastLogin,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      //search bar
      Padding(
        padding: EdgeInsets.only(top: 10, left: 25, right: 25),
        child: TextField(
          onChanged: (value) => runFilter(value),
          decoration: InputDecoration(
              hintText: "Search...",
              hintStyle: TextStyle(color: Colors.grey.shade600),
              prefixIcon: Icon(
                Icons.search,
                color: Colors.grey.shade600,
              ),
              filled: true,
              fillColor: Colors.grey.shade100,
              contentPadding: EdgeInsets.all(8),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.grey.shade100))),
        ),
      ),

      SizedBox(
        width: 16,
      ),

      //lista de conversas
      Expanded(
          child: StreamBuilder<List<ChatUsers>>(
        stream: readUsersList(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Algo deu errado ${snapshot.error}");
          } else if (snapshot.hasData) {
            final chatUsers = snapshot.data!;

            return ListView(
              children: chatUsers.map(buildChatUsers).toList(),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      )),
   
    ]);
  }
}
