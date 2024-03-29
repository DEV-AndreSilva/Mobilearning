// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable, file_names

import 'package:dart_date/dart_date.dart';
import 'package:flutter/material.dart';
import 'package:mobilearning/View/ChatDetailPage.dart';

class ConversationList extends StatefulWidget {
  int idUserLogin;
  int userUid;
  String name;
  String imageURL;
  DateTime createTime;
  String status;
  DateTime lastLogin;

  ConversationList(
      {super.key,
      required this.idUserLogin,
      required this.userUid,
      required this.name,
      required this.imageURL,
      required this.createTime,
      required this.status,
      required this.lastLogin
      });

  @override
  State<ConversationList> createState() => ConversationListState();
}

class ConversationListState extends State<ConversationList> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ChatDetailPage(
            idUserLogin: widget.idUserLogin,
            userUid: widget.userUid,
            imageURL: widget.imageURL,
            name: widget.name,
            status: widget.status,
          );
        }));
      },
      child: Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        child: Row(
          children: <Widget>[
            CircleAvatar(
              backgroundImage: NetworkImage(widget.imageURL),
              maxRadius: 30,
            ),
            SizedBox(
              width: 16,
            ),
            Expanded(
              child: Container(
                color: Colors.transparent,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name,
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(widget.status,
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.normal)),
                    ]),
              ),
            ),
            Text(
              widget.lastLogin.format('dd/MM/y').toString(),
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }
}
