// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WebQuestTask extends StatefulWidget {
  const WebQuestTask({Key? key}) : super(key: key);

  @override
  State<WebQuestTask> createState() => _WebQuestTask();
}

class _WebQuestTask extends State<WebQuestTask> {
  @override
  Widget build(BuildContext context) {
    var alturaTela = MediaQuery.of(context).size.height;
    final dynamic args = ModalRoute.of(context)?.settings.arguments;

    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration:
                  const BoxDecoration(color: Color.fromRGBO(21, 93, 177, 1)),
              accountName: Text(
                'André',
                style: GoogleFonts.arvo(fontSize: 18),
              ),
              accountEmail: Text(
                'andreluis2608@gmail.com',
                style: GoogleFonts.arvo(fontSize: 18),
              ),
              currentAccountPicture: const CircleAvatar(
                child: Text("SZ"),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: Text(
                "My account",
                style: GoogleFonts.arvo(fontSize: 16),
              ),
              onTap: () => {
                Navigator.pushNamed(context, '/login'),
              },
            ),
            ListTile(
                leading: const Icon(Icons.logout),
                title: Text('Logout', style: GoogleFonts.arvo(fontSize: 16)),
                onTap: () => {
                      Navigator.pushNamed(context, '/login'),
                    })
          ],
        ),
      ),
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
                          Container(
                              margin: EdgeInsets.only(bottom: 20),
                              child: Text('Task',
                                  style: GoogleFonts.arvo(
                                      fontSize: 22,
                                      color: Color.fromARGB(255, 0, 0, 0)))),
                          Text(
                            args.activity.task.toString(),
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
                                Navigator.pushNamed(
                                    context, "/WebQuestIntroduction",
                                    arguments: args);
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
                              setState(() {
                                Navigator.pushNamed(context, "/WebQuestProcess",
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
