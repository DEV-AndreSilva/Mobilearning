// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:mobilearning/Models/chatMessageModel.dart';

class ChatDetailPage extends StatefulWidget {
  int userUid;
  String imageURL;
  String name;

ChatDetailPage({super.key, required this.userUid, required this.imageURL,required this.name });

  @override
  State<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {

  List<ChatMessage> messages = [
    ChatMessage(messageContent: "Hello André", messageType: "receiver"),
    ChatMessage(messageContent: "How are you?", messageType: "receiver"),
    ChatMessage(messageContent: "I'm good and you?", messageType: "sender"),
    ChatMessage(messageContent: "I'm good too", messageType: "receiver"),
    ChatMessage(messageContent: "Do you need anything?", messageType: "sender"),

    ChatMessage(messageContent: "Hello André", messageType: "receiver"),
    ChatMessage(messageContent: "How are you?", messageType: "receiver"),
    ChatMessage(messageContent: "I'm good and you?", messageType: "sender"),
    ChatMessage(messageContent: "I'm good too", messageType: "receiver"),
    ChatMessage(messageContent: "Do you need anything?", messageType: "sender"),
    
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromRGBO(21,93,177,1),
        flexibleSpace: SafeArea(
          child:Container(
            padding: EdgeInsets.only(right: 50),
            child: Row(
              children: <Widget>[
                IconButton(onPressed: (){
                  Navigator.pop(context);
                }, icon: Icon(Icons.arrow_back, color: Colors.white,),
                iconSize: 25,),
                SizedBox(height: 2,),
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
                      Text(widget.name, style: TextStyle(color: Colors.white,fontSize: 20),),
                      SizedBox(height: 6,),
                      Text("Online", style: TextStyle(color: Colors.white70, fontSize: 16),),
                  ]) ,
                ),
                Icon(Icons.settings, color: Colors.white,size: 25,),
              ]),
            ),
          ),
        
      ),
      body: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                reverse: true,
                itemCount: messages.length,
                shrinkWrap: true,
                controller: ScrollController(),
                padding: EdgeInsets.only(top: 10, bottom: 10),
                itemBuilder: (context, index){
                return Container(
                  padding: EdgeInsets.only(left: 16, right: 16,top: 10,bottom: 10),
                  child: Align(
                    alignment: (messages[index].messageType=="receiver"? Alignment.topLeft:Alignment.topRight),
                    child: Container(
                      decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: (messages[index].messageType == "receiver"? Colors.grey.shade200: Colors.blue[200]),
                        ),
                        padding: EdgeInsets.all(16),
                        child: Text(messages[index].messageContent, style: TextStyle(fontSize: 15),),
                      ),
                    )
                  
                  );
                
              }),
            ),
        
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 90,
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.attach_file),
                          ),
                        ),
                        Flexible(
                                child: Container(
                                margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
                                padding: EdgeInsets.symmetric(horizontal: 13),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                child: TextField(
                                    decoration: InputDecoration(
                                    border: InputBorder.none,
                                    suffixIcon: Icon(Icons.face),
                                  ),
                                  onChanged: (value) {
                                    // if (value.isEmpty)
                                    //   setState(() => showMicIcon = true);
                                    // else
                                    //   setState(() => showMicIcon = false);
                                  },
                                )),
                          ),
                      ],
                    ),
                  ),
                ]
              )
            
              
          ],
      )
      
    );
  }
}