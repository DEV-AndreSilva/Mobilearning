// ignore_for_file: prefer_const_constructors, file_names
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';

 class ManagmentPage extends StatefulWidget {
  const ManagmentPage({super.key});

  @override
  State<ManagmentPage> createState() => _ManagmentPageState();
}

class _ManagmentPageState extends State<ManagmentPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
      Container(
        margin: EdgeInsets.only(bottom: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: (){
                 setState(() {
                    Navigator.pushNamed(context, '/calunos');
                 });
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: Color.fromRGBO(129,201,250,1)),
                child: Column(
                  
                  children: [
                    Icon(Icons.person_add,size: 100,),
                    Text("Manage Student", style: TextStyle(fontSize: 22),)
                  ],
                ),
              ),
            ),
           GestureDetector(
            onTap: (){
                setState(() {
                    Navigator.pushNamed(context, '/cprofessores');
                 });
              },
             child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: Color.fromRGBO(129,201,250,1)),
                child: Column(
                  children: [
                    Icon(Icons.person_add,size: 100,),
                    Text("Manage Teacher", style: TextStyle(fontSize: 22),)
                  ],
                ),
              ),
           ),
          ]),
      ),

          Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: (){

              },
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: Color.fromRGBO(129,201,250,1)),
              child: Column(
                children: [
                  Icon(Icons.add_box_rounded,size: 100,),
                  Text("Manage Activity", style: TextStyle(fontSize: 22),)
                ],
              ),
            ),
          ),
         GestureDetector(
          onTap: (){

              },
           child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: Color.fromRGBO(129,201,250,1)),
              child: Column(
                children: [
                  Icon(Icons.people_alt_rounded,size: 100,),
                  Text("Manage Groups", style: TextStyle(fontSize: 22),)
                ],
              ),
            ),
         ),
        ]),
    ]);
  }
}