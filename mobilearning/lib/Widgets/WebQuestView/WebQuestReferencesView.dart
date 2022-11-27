// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobilearning/functions.dart';

import '../DrawerMobilearning.dart';

class WebQuestReferencesView extends StatefulWidget {
  const WebQuestReferencesView({Key? key}) : super(key: key);

  @override
  State<WebQuestReferencesView> createState() => _WebQuestReferencesView();
}

class _WebQuestReferencesView extends State<WebQuestReferencesView> {
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
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(10, 10, 10, 20),
            child: Column(
              children: [
                Container(
                    margin: EdgeInsets.only(bottom: 20, top: 20),
                    child: Text('References',
                        style: GoogleFonts.arvo(
                            fontSize: 22,
                            color: Color.fromARGB(255, 0, 0, 0)))),
                 Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                   child: Text(
                    "Para continuar se aprofundando no tema, dê uma olhada nos links abaixo:",
                    style: GoogleFonts.arvo(fontSize: 18),
                    maxLines: 50,
                ),
                 ),
              ],
            ),
          ),
          Flexible(
            child: Container(
                height: alturaTela * 0.5,
                child: ListView.builder(
                    shrinkWrap: true,
                    controller: ScrollController(),
                    itemCount: args?.activity?.references?.length ?? 0,
                    itemBuilder: (context, index) {
                      return Container(
                          alignment: Alignment.center,
                          margin:
                              EdgeInsets.only(bottom: 15, right: 10, left: 10),
                          child: TextButton(
                              child: Text(
                                  args.activity.references[index].toString(),
                                  overflow: TextOverflow.fade,
                                  style: GoogleFonts.arvo(fontSize: 15)),
                              onPressed: () {
                                launchURL(
                                    args.activity.references[index].toString());
                              }));
                    })),
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
                      Navigator.pushNamed(context, "/WebQuestConclusionView",
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
                      SalvarProgressoWebQuest(args, 'References');
                    //finalizar
                    setState(() {
                      Navigator.pushNamed(context, "/home", arguments: args);
                    });
                  },
                  child: Text(
                    args.progress != 100 ? 'End webquest' : "Quit",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
