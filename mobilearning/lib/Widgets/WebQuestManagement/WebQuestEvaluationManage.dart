// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobilearning/Models/userModel.dart';
import 'package:mobilearning/Widgets/DrawerMobilearning.dart';
import 'package:mobilearning/functions.dart';

import '../../Models/activityModel.dart';

class WebQuestEvaluationManage extends StatefulWidget {
  const WebQuestEvaluationManage({Key? key}) : super(key: key);

  @override
  State<WebQuestEvaluationManage> createState() => _WebQuestEvaluationManage();
}

class _WebQuestEvaluationManage extends State<WebQuestEvaluationManage> {
  final EvaluationController = TextEditingController();

  Map<String, TextEditingController> controllers =
      Map<String, TextEditingController>();

  @override
  void initState() {
    // TODO: implement initState

    controllers.addAll({
      'evaluation': EvaluationController,
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
                              child: Text('Evaluation',
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
                              controller: EvaluationController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Digite o link para avaliação para webquest";
                                }
                                return null;
                              },
                              keyboardType: TextInputType.multiline,
                              cursorColor: Colors.blue,
                              decoration: const InputDecoration(
                                hintText: 'avaliação ...',
                                prefixIcon: Icon(
                                  Icons.menu_book,
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
                                    context, "/WebQuestInformationManage");
                              });
                            },
                            child: const Text(
                              'Voltar',
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
                              salvarEtapa(controllers, null, null);
                              setState(() {
                                Navigator.pushNamed(
                                    context, "/WebQuestConclusionManage");
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
