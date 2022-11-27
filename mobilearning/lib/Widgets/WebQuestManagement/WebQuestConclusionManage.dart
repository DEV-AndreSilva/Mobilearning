// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobilearning/Widgets/DrawerMobilearning.dart';
import 'package:mobilearning/functions.dart';


class WebQuestConclusionManage extends StatefulWidget {
  const WebQuestConclusionManage({Key? key}) : super(key: key);

  @override
  State<WebQuestConclusionManage> createState() => _WebQuestConclusionManage();
}

class _WebQuestConclusionManage extends State<WebQuestConclusionManage> {
  final conclusionController = TextEditingController();

  Map<String, TextEditingController> controllers =
      Map<String, TextEditingController>();

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState

    controllers.addAll({
      'conclusion': conclusionController,
    });

    recuperarEtapa(controllers, null, null);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var alturaTela = MediaQuery.of(context).size.height;

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
                      margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
                      child: Column(
                        children: [
                          Container(
                              margin: EdgeInsets.only(bottom: 20),
                              child: Text('Conclusion',
                                  style: GoogleFonts.arvo(
                                      fontSize: 22,
                                      color: Color.fromARGB(255, 0, 0, 0)))),
                          Container(
                            padding: EdgeInsets.fromLTRB(0, 5, 0, 20),
                            margin:
                                EdgeInsets.only(top: 5, right: 20, left: 20),
                            height: alturaTela * 0.5,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 3,
                                ),
                              ],
                            ),
                            child: TextFormField(
                              maxLines: 20,
                              controller: conclusionController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Digite o link para avaliação para webquest";
                                }
                                return null;
                              },
                              keyboardType: TextInputType.multiline,
                              cursorColor: Colors.blue,
                              decoration: const InputDecoration(
                                hintText: 'conclusao ...',
                                prefixIcon: Icon(
                                  Icons.timer,
                                  color: Colors.blue,
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 15,
                                ),
                              ),
                            ),
                          ),
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
                              salvarEtapa(controllers, null, null);
                              setState(() {
                                Navigator.pushNamed(
                                    context, "/WebQuestEvaluationManage");
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
                              salvarEtapa(controllers, null, null);
                              setState(() {
                                Navigator.pushNamed(
                                    context, "/WebQuestRelationManage");
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
