// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, file_names, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:mobilearning/Models/chatMessageModel.dart';
import 'package:mobilearning/Models/userModel.dart';

class ChatDetailPage extends StatefulWidget {
  int userUid;
  String imageURL;
  String name;
  int idUserLogin;

  ChatDetailPage(
      {super.key,
      required this.userUid,
      required this.imageURL,
      required this.name,
      required this.idUserLogin});

  @override
  State<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {

   var _scrollController = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Stream<List<ChatMessage>> readMessages() {
    String docName = "";
    if (widget.userUid < widget.idUserLogin) {
      docName = widget.userUid.toString() + widget.idUserLogin.toString();
    } else {
      docName = widget.idUserLogin.toString() + widget.userUid.toString();
    }
    

    return FirebaseFirestore.instance
        .collection("UsersMessages")
        .doc(docName)
        .collection("Messages")
        .orderBy('dateSent')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ChatMessage.fromJson(doc.data()))
            .toList());

    
  }

  Future<bool> docExists(String docName) async {
    var a = await FirebaseFirestore.instance.collection(docName).doc().get();
    if (a.exists) {
      return true;
    } else {
      return false;
    }
  }

  Future sendMessage(String message) async {
    String docName = "";
    if (widget.userUid < widget.idUserLogin) {
      docName = widget.userUid.toString() + widget.idUserLogin.toString();
    } else {
      docName = widget.idUserLogin.toString() + widget.userUid.toString();
    }

    if (await docExists(docName)) {
      final docMessage = FirebaseFirestore.instance
          .collection("UsersMessages")
          .doc(docName)
          .collection('Messages')
          .doc();
      //sem especificar o doc é possivel pegar o id dele depois da criação
      ChatMessage mensagem = ChatMessage(
          messageId: docMessage.id,
          messageContent: message,
          dateSent: DateTime.now(),
          idUserWritter: widget.idUserLogin.toString());
      var jsonMessage = mensagem.toJson();
      await docMessage.set(jsonMessage);
    } else {
      final docUsers = FirebaseFirestore.instance
          .collection("UsersMessages")
          .doc(docName)
          .set({});

      final docMessage = FirebaseFirestore.instance
          .collection("UsersMessages")
          .doc(docName)
          .collection('Messages')
          .doc();
      //sem especificar o doc é possivel pegar o id dele depois da criação
      ChatMessage mensagem = ChatMessage(
          messageId: docMessage.id,
          messageContent: message,
          dateSent: DateTime.now(),
          idUserWritter: widget.idUserLogin.toString());
      var jsonMessage = mensagem.toJson();
      await docMessage.set(jsonMessage);
    }

    textMessageController.clear();
  }

  Widget buildMessage(ChatMessage message) {
    return Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
        child: Align(
          alignment: (message.idUserWritter == widget.idUserLogin.toString()
              ? Alignment.topRight
              : Alignment.topLeft),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: (message.idUserWritter == widget.idUserLogin.toString()
                  ? Colors.blue[200]
                  : Colors.grey.shade200),
            ),
            padding: EdgeInsets.all(16),
            child: Text(
              message.messageContent,
              style: TextStyle(fontSize: 15),
            ),
          ),
        ));
  }

  final textMessageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Color.fromRGBO(21, 93, 177, 1),
          flexibleSpace: SafeArea(
            child: Container(
              padding: EdgeInsets.only(right: 50),
              child: Row(children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  iconSize: 25,
                ),
                SizedBox(
                  height: 2,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(widget.imageURL),
                    maxRadius: 30,
                  ),
                ),
                SizedBox(height: 12),
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          widget.name,
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          "Online",
                          style: TextStyle(color: Colors.white70, fontSize: 16),
                        ),
                      ]),
                ),
                Icon(
                  Icons.settings,
                  color: Colors.white,
                  size: 25,
                ),
              ]),
            ),
          ),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
                child: StreamBuilder<List<ChatMessage>>(
              stream: readMessages(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text("Algo deu errado ${snapshot.error}");
                } else if (snapshot.hasData) {
                  final messages = snapshot.data!;

                  return ListView(
                    controller: _scrollController,
                    children: messages.map(buildMessage).toList(),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            )),
            Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              SizedBox(
                height: 90,
                child: Row(
                  children: [
                    Flexible(
                      child: Container(
                          margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
                          padding: EdgeInsets.symmetric(horizontal: 13),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: TextField(
                            controller: textMessageController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              
                            ),
                            onSubmitted: (value) {
                              sendMessage(value);
                            },
                          )),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
                      child: IconButton(
                        onPressed: () {
                          sendMessage(textMessageController.text);
                        },
                        icon: Icon(Icons.send),
                      ),
                    ),
                  ],
                ),
              ),
            ])
          ],
        ));
  }
}
