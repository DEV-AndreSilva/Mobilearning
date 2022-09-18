// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:mobilearning/View/ChatDetailPage.dart';

class ConversationList extends StatefulWidget {
  int userUid;
  String name;
  String messageText;
  String imageURL;
  String time;
  bool isMessageRead;
  
  ConversationList({super.key, required this.userUid,required this.name, required this.messageText,required this.imageURL,required this.time, required this.isMessageRead});

  @override
  State<ConversationList> createState() => _ConversationListState();

  
}

class _ConversationListState extends State<ConversationList> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:(){
        Navigator.push(context, MaterialPageRoute(builder: (context){
            return ChatDetailPage(userUid: widget.userUid, imageURL: widget.imageURL, name: widget.name,);
        }));
      } ,
      child: Container(
        padding: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
        child: Row(
          children: <Widget>[CircleAvatar(
            backgroundImage: NetworkImage(widget.imageURL),
            maxRadius: 30,
          ),
          SizedBox(width: 16,),
          Expanded(child: Container(
            color: Colors.transparent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.name,style: TextStyle(fontSize: 16),),
                SizedBox(height: 6,),
                Text(widget.messageText,style: TextStyle(fontSize: 13, color:Colors.grey.shade600, fontWeight: widget.isMessageRead? FontWeight.bold : FontWeight.normal)),
              ]
              ),
            ),
          ),
          Text(widget.time,style: TextStyle(fontSize: 12,fontWeight: widget.isMessageRead?FontWeight.bold:FontWeight.normal),),
          ],
        ),
      ),
    );
  }
}