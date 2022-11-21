// ignore_for_file: file_names, prefer_const_constructors

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobilearning/functions.dart';

import '../DrawerMobilearning.dart';

class WebQuestIntroductionView extends StatefulWidget {
  const WebQuestIntroductionView({Key? key}) : super(key: key);

  @override
  State<WebQuestIntroductionView> createState() => _WebQuestIntroductionView();
}

class _WebQuestIntroductionView extends State<WebQuestIntroductionView> {
  @override
  Widget build(BuildContext context) {
    var alturaTela = MediaQuery.of(context).size.height;
    final dynamic args = ModalRoute.of(context)?.settings.arguments;

    return Scaffold(
      drawer: DrawerMobilearning(),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(21, 93, 177, 1),
        title: Text(
          'English Mobilearning',
          style: GoogleFonts.arvo(fontSize: 22),
        ),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      body: ListView(
        children: [
          Form(
            child: Column(
              children: [
                Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 10, 10, 20),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                height: 50,
                                width: 100,
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 225, 110, 22),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    if (args.progress != 100)
                                      SalvarProgressoWebQuest(
                                          args, 'Introduction');
                                    
                                      setState(() {
                                        Navigator.pushNamed(context, "/home");
                                      });
                                    
                                  },
                                  child: Text( "Quit",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                              margin: EdgeInsets.only(bottom: 20, top: 20),
                              child: Text('Introduction',
                                  style: GoogleFonts.arvo(
                                      fontSize: 22,
                                      color: Color.fromARGB(255, 0, 0, 0)))),
                          Text(
                            args.activity.introduction.toString(),
                            style: GoogleFonts.arvo(fontSize: 20),
                            maxLines: 50,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 50,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 25,
                          ),
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                Navigator.pushNamed(context, "/home");
                              });
                            },
                            child: const Text(
                              'Voltar etapa',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Container(
                          height: 50,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 25,
                          ),
                          decoration: const BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                          child: TextButton(
                            onPressed: () {
                              if (args.progress != 100)
                                SalvarProgressoWebQuest(args, 'Introduction');
                              
                                setState(() {
                                  Navigator.pushNamed(
                                      context, "/WebQuestTaskView",
                                      arguments: args);
                                });
                            },
                            child: const Text(
                              'Avançar etapa',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
