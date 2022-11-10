// ignore_for_file: prefer_const_constructors, file_names
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ManagmentPage extends StatefulWidget {
  const ManagmentPage({super.key});

  @override
  State<ManagmentPage> createState() => _ManagmentPageState();
}

class _ManagmentPageState extends State<ManagmentPage> {
  @override
  Widget build(BuildContext context) {

    var larguraTela = MediaQuery.of(context).size.width;


    return Column(children: [
      Container(
          margin: EdgeInsets.only(bottom: 20, top: 20),
          child: Text('Management',
              style: GoogleFonts.arvo(
                  fontSize: 22, color: Color.fromARGB(255, 0, 0, 0)))),
      Container(
        margin: EdgeInsets.only(bottom: 30),
        child: GestureDetector(
          onTap: () {
            setState(() {
              Navigator.pushNamed(context, '/calunos');
            });
          },
          child: Container(
            width: larguraTela*0.8,
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 10, bottom: 10, left: 50, right: 50),
            
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Color.fromRGBO(129, 201, 250, 1)),
            child: Column(
              children: [
                Icon(
                  Icons.person_add,
                  size: 100,
                ),
                Text(
                  "Students",
                  style: TextStyle(fontSize: 22),
                )
              ],
            ),
          ),
        ),
      ),
            Container(
        margin: EdgeInsets.only(bottom: 30),
        child: GestureDetector(
          onTap: () {
            setState(() {
              Navigator.pushNamed(context, '/cprofessores');
            });
          },
          child: Container(
            width: larguraTela*0.8,
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 10, bottom: 10, left: 50, right: 50),
            
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Color.fromRGBO(129, 201, 250, 1)),
            child: Column(
              children: [
                Icon(
                  Icons.school,
                  size: 100,
                ),
                Text(
                  "Teachers",
                  style: TextStyle(fontSize: 22),
                )
              ],
            ),
          ),
        ),
      ),
    
                  Container(
        margin: EdgeInsets.only(bottom: 30),
        child: GestureDetector(
          onTap: () {
            setState(() {
              Navigator.pushNamed(context, '/WebQuestBasicInfoManage');
            });
          },
          child: Container(
            width: larguraTela*0.8,
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 10, bottom: 10, left: 50, right: 50),
            
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Color.fromRGBO(129, 201, 250, 1)),
            child: Column(
              children: [
                Icon(
                  Icons.work,
                  size: 100,
                ),
                Text(
                  "Activities",
                  style: TextStyle(fontSize: 22),
                )
              ],
            ),
          ),
        ),
      ),
    
         
    ]);
  }
}
