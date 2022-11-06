// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobilearning/Widgets/DrawerMobilearning.dart';

import '../../Models/activityModel.dart';

class WebQuestTaskManage extends StatefulWidget {
  const WebQuestTaskManage({Key? key}) : super(key: key);

  @override
  State<WebQuestTaskManage> createState() => _WebQuestTaskManage();
}

class _WebQuestTaskManage extends State<WebQuestTaskManage> {
  void salvarEtapa(String route) async {
    int idTeacher = 0;

    bool containUser = await SessionManager().containsKey("UserLogin");
    if (containUser) {
      String stringIdTeacher = await SessionManager().get("UserLogin");
      idTeacher = int.parse(stringIdTeacher);
    }

    Activity activity = Activity(
        id: 0,
        idTeacher: idTeacher,
        introduction: "introduction",
        task: "task",
        process: "process",
        information: [],
        evaluation: "evaluation",
        conclusion: "conclusion",
        references: [],
        subtitle: "subtitle",
        imageURL: "imageURL",
        title: "title");

    try {
      bool containWebquest = await SessionManager().containsKey("WebQuest");
      if (containWebquest) {
        dynamic activityMemory = await SessionManager().get("WebQuest");
        activity = Activity(
            id: 0,
            idTeacher: idTeacher,
            introduction: activityMemory["introduction"].toString(),
            task: activityMemory["task"].toString(),
            process: activityMemory["process"].toString(),
            information: activityMemory["information"] as List<dynamic>,
            evaluation: activityMemory["evaluation"].toString(),
            conclusion: activityMemory["conclusion"].toString(),
            references: activityMemory["references"] as List<dynamic>,
            subtitle: activityMemory["subtitle"].toString(),
            imageURL: activityMemory["imageURL"].toString(),
            title: activityMemory["title"].toString());
      }
    } catch (ex) {
      print(ex);
    } finally {
      SessionManager sessionManager = SessionManager();
      activity.task = taskController.text;
      await sessionManager.set('WebQuest', activity);

      setState(() {
        Navigator.pushNamed(context, route);
      });
    }
  }

  void recuperarEtapa() async {
    bool containWebquest = await SessionManager().containsKey("WebQuest");
    if (containWebquest) {
      dynamic activityMemory = await SessionManager().get("WebQuest");
      taskController.text = activityMemory["task"].toString();
    }
  }

  final taskController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    recuperarEtapa();
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
                              child: Text('Task',
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
                              controller: taskController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Digite uma tarefa para webquest";
                                }
                                return null;
                              },
                              keyboardType: TextInputType.multiline,
                              cursorColor: Colors.blue,
                              decoration: const InputDecoration(
                                hintText: 'for complete this activity ...',
                                prefixIcon: Icon(
                                  Icons.assignment,
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
                              salvarEtapa("/WebQuestIntroductionManage");
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
                              salvarEtapa("/WebQuestProcessManage");
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
