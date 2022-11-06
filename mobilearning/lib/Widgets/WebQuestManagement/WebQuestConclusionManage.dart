// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobilearning/Widgets/DrawerMobilearning.dart';

import '../../Models/activityModel.dart';

class WebQuestConclusionManage extends StatefulWidget {
  const WebQuestConclusionManage({Key? key}) : super(key: key);

  @override
  State<WebQuestConclusionManage> createState() => _WebQuestConclusionManage();
}

class _WebQuestConclusionManage extends State<WebQuestConclusionManage> {
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
        introduction: "Write a introduction ...",
        task: "Write the task ...",
        process: "The process is ....",
        information: [
          'Link to information 1',
          'Link to information 2',
          'Link to information 3',
          'andre'
        ],
        evaluation: "Evaluation method ....",
        conclusion: "The conclusion ...",
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
      activity.conclusion = conclusionController.text;
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
      conclusionController.text = activityMemory["conclusion"].toString();
    }
  }

  final conclusionController = TextEditingController();

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
                                hintText: 'avaliação ...',
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
                              salvarEtapa("/WebQuestEvaluationManage");
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
                              salvarEtapa("/WebQuestReferencesManage");
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
