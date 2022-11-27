// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobilearning/functions.dart';

import '../DrawerMobilearning.dart';

class WebQuestEvaluationView extends StatefulWidget {
  const WebQuestEvaluationView({Key? key}) : super(key: key);

  @override
  State<WebQuestEvaluationView> createState() => _WebQuestEvaluationView();
}

class _WebQuestEvaluationView extends State<WebQuestEvaluationView> {
  @override
  Widget build(BuildContext context) {
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
                                          args, 'Evaluation');
                                    
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
                              child: Text('Evaluation',
                                  style: GoogleFonts.arvo(
                                      fontSize: 22,
                                      color: Color.fromARGB(255, 0, 0, 0)))),
                                      
                          Container(
                              margin: EdgeInsets.only(bottom: 20, right: 10, left: 10),
                              child: Text('Click on the link to start your assessment',
                                  style: GoogleFonts.arvo(
                                      fontSize: 18,
                                      color: Color.fromARGB(255, 0, 0, 0)))),

                           Container(
                          margin: EdgeInsets.only(bottom: 15, right: 10, left: 10),
                          child: TextButton(
                              child: Text(args.activity.evaluation.toString(),
                                  overflow: TextOverflow.fade,
                                  style: GoogleFonts.arvo(fontSize: 18)),
                              onPressed: () {
                                launchURL(args.activity.evaluation.toString());
                              }))
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 50,
                          width: 100,
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
                                Navigator.pushNamed(
                                    context, "/WebQuestInformationView",
                                    arguments: args);
                              });
                            },
                            child: const Text(
                              'Back',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Container(
                          height: 50,
                          width: 100,
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
                                SalvarProgressoWebQuest(args, 'Evaluation');

                              setState(() {
                                Navigator.pushNamed(
                                    context, "/WebQuestConclusionView",
                                    arguments: args);
                              });
                            },
                            child: const Text(
                              'Next step',
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
