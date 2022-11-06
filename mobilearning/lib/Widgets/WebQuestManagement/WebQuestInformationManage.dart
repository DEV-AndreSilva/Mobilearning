// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobilearning/Models/activityModel.dart';
import 'package:mobilearning/Widgets/DrawerMobilearning.dart';

class WebQuestInformationManage extends StatefulWidget {
  const WebQuestInformationManage({Key? key}) : super(key: key);

  @override
  State<WebQuestInformationManage> createState() =>
      _WebQuestInformationManage();
}

class _WebQuestInformationManage extends State<WebQuestInformationManage> {
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
        information: [
          'Link to information 1',
          'Link to information 2',
          'Link to information 3',
          'andre'
        ],
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
      activity.information = informationResources;
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

      setState(() {
        informationResources = activityMemory["information"];
      });
    }
  }

  void addResource(String resource) {
    if (resource != "") {
      setState(() {
        informationResources.add(resource);
        resourceController.clear();
      });
    }
  }

  void deleteResource(int index) {
    setState(() {
      informationResources.removeAt(index);
    });

    return null;
  }

  List<dynamic> informationResources = [];
  final resourceController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    recuperarEtapa();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var larguraTela = MediaQuery.of(context).size.width;
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
        children: [
          Container(
              margin: EdgeInsets.only(bottom: 0, top: 20),
              child: Text('Information Resources',
                  style: GoogleFonts.arvo(
                      fontSize: 22, color: Color.fromARGB(255, 0, 0, 0)))),
          Container(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: TextField(
              controller: resourceController,
              onChanged: (value) => {},
              decoration: const InputDecoration(
                  labelText: 'htpps://link', suffixIcon: Icon(Icons.link)),
            ),
          ),
          GestureDetector(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 75.0, right: 75.0, bottom: 20.0),
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(21, 93, 177, 1),
                    border: Border.all(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Add a resource",
                        style: GoogleFonts.arvo(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                      // Icon(Icons.add,color: Colors.white,)
                    ],
                  )),
                ),
              ),
              onTap: () {
                addResource(resourceController.text);
              }),
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                controller: ScrollController(),
                itemCount: informationResources.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Container(
                          margin: EdgeInsets.only(right: 10, left: 10),
                          width: larguraTela * 0.8,
                          child: Text(
                            informationResources[index].toString(),
                            overflow: TextOverflow.fade,
                            style: GoogleFonts.arvo(fontSize: 15),
                          )),
                      IconButton(
                          onPressed: () {
                            deleteResource(index);
                          },
                          icon: Icon(Icons.delete))
                    ],
                  );
                }),
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
                    salvarEtapa("/WebQuestProcessManage");
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
                    salvarEtapa("/WebQuestEvaluationManage");
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
      ),
    );
  }
}
