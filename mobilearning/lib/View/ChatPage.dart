// ignore_for_file: prefer_const_constructors, file_names
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:mobilearning/Models/chatUsersModel.dart';
import 'package:mobilearning/Widgets/ConversationList.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  
  List<ChatUsers> chatUsers =[
    ChatUsers(userUid: 1, name: "Jane Russel", messageText: "Awesome Setup", imageURL: "https://th.bing.com/th/id/OIP.NIjCKgHbDTjdTPDD6oLuRgHaHa?pid=ImgDet&rs=1", time: "Now"),
    ChatUsers(userUid: 2, name: "Glady's Murphy", messageText: "That's Great", imageURL: "https://th.bing.com/th/id/OIP.NIjCKgHbDTjdTPDD6oLuRgHaHa?pid=ImgDet&rs=1", time: "Yesterday"),
    ChatUsers(userUid: 3, name: "Jorge Henry", messageText: "Hey where are you?", imageURL: "https://th.bing.com/th/id/OIP.NIjCKgHbDTjdTPDD6oLuRgHaHa?pid=ImgDet&rs=1", time: "31 Mar"),
    ChatUsers(userUid: 4, name: "Philip Fox", messageText: "Busy! Call me in 20 mins", imageURL: "https://th.bing.com/th/id/OIP.NIjCKgHbDTjdTPDD6oLuRgHaHa?pid=ImgDet&rs=1", time: "28 Mar"),
    ChatUsers(userUid: 5, name: "Debra Hawkins", messageText: "Thankyou, It's awesome", imageURL: "https://th.bing.com/th/id/OIP.NIjCKgHbDTjdTPDD6oLuRgHaHa?pid=ImgDet&rs=1", time: "23 Mar"),
    ChatUsers(userUid: 6, name: "Jacob Pena", messageText: "will update you in evening", imageURL: "https://th.bing.com/th/id/OIP.NIjCKgHbDTjdTPDD6oLuRgHaHa?pid=ImgDet&rs=1", time: "17 Mar"),
    ChatUsers(userUid: 7, name: "Andrey Jones", messageText: "Can you please share the file?", imageURL: "https://th.bing.com/th/id/OIP.NIjCKgHbDTjdTPDD6oLuRgHaHa?pid=ImgDet&rs=1", time: "24 Feb"),
    ChatUsers(userUid: 8, name: "John Wick", messageText: "How are you?", imageURL: "https://th.bing.com/th/id/OIP.NIjCKgHbDTjdTPDD6oLuRgHaHa?pid=ImgDet&rs=1", time: "18 Feb"),
 
  ];
  
   // lista de dados que sera exibida
  List<ChatUsers> foundUsers = [];

  @override
  initState() {
    //No começo todos os dados serão exibidos
    foundUsers = chatUsers;
    super.initState();
  }

  // Função que é chamada quando o campo de texto muda
  void runFilter(String enteredKeyword) {
    List<ChatUsers>  results = [];

     // Se o Campo de texto está em branco ou com apenas espaços exibe todos os registros
    if (enteredKeyword.isEmpty) {
      results = chatUsers;
    }
     else {
      // Preenche a nova lista de resultados apenas com os nomes que possuem o texto procurado
      results = chatUsers.where((user) => user.name.toLowerCase().contains(enteredKeyword.toLowerCase())).toList();
    }

    // Refresh the UI
    setState(() {
      foundUsers = results;
    });
  }


  @override  
  Widget build(BuildContext context) {
    return Column(
      
      children:[
        //search bar
        Padding(padding: EdgeInsets.only(top: 10,left: 25,right: 25),
                child: TextField(
                  onChanged: (value) => runFilter(value),
                  decoration: InputDecoration(
                    hintText: "Search...",
                    hintStyle: TextStyle(color: Colors.grey.shade600),
                    prefixIcon: Icon(Icons.search, color: Colors.grey.shade600,),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    contentPadding: EdgeInsets.all(8),
                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(color: Colors.grey.shade100) )
                  ) ,
                ),),

                SizedBox(width: 16,),

                //lista de conversas
                Expanded(child: ListView.builder(
                  itemCount: foundUsers.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.only(top: 16,),
                  controller: ScrollController(),
                  itemBuilder: (context,index){
                    return ConversationList(
                      userUid: foundUsers[index].userUid,
                      name: foundUsers[index].name,
                      messageText: foundUsers[index].messageText,
                      imageURL: foundUsers[index].imageURL,
                      time: foundUsers[index].time,
                      isMessageRead: (index ==0 || index ==3)?true:false,
                      );
                  },
                ),
                ),
                SizedBox(width: 16,),
    ]);
  }
}