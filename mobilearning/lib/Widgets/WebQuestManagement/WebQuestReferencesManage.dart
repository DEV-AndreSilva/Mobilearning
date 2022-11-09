// ignore_for_file: file_names, prefer_const_constructors

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobilearning/Models/activityModel.dart';
import 'package:mobilearning/Models/userModel.dart';
import 'package:mobilearning/Widgets/DrawerMobilearning.dart';
import 'package:mobilearning/functions.dart';

class WebQuestReferencesManage extends StatefulWidget {
  const WebQuestReferencesManage({Key? key}) : super(key: key);

  @override
  State<WebQuestReferencesManage> createState() => _WebQuestReferencesManage();
}

class _WebQuestReferencesManage extends State<WebQuestReferencesManage> {
  void addReference(String resource) {
    if (resource != "") {
      setState(() {
        informationReferences.add(resource);
        resourceController.clear();
      });
    }
  }

  void deleteReference(int index) {
    setState(() {
      informationReferences.removeAt(index);
    });

    return null;
  }

  void salvarWebQuest() async {
    salvarEtapa(controllers, null, informationReferences);

    try {
      Options opt = Options();
      String token = await SessionManager().get("BearerToken");
      dynamic activityMemory = await SessionManager().get("WebQuest");

      if (token != null && token != '') {
        opt.headers = {"authorization": "bearer $token"};
        var response =
            await Dio().post("https://mobilearning-api.herokuapp.com/activity",
                data: {
                  "idTeacher": activityMemory['idTeacher'],
                  "introduction": activityMemory['introduction'].toString(),
                  "task": activityMemory['task'].toString(),
                  "process": activityMemory['process'].toString(),
                  "information": activityMemory['information'] as List<dynamic>,
                  "evaluation": activityMemory['evaluation'].toString(),
                  "conclusion": activityMemory['conclusion'].toString(),
                  "references": activityMemory['references'] as List<dynamic>,
                  "title": activityMemory['title'].toString(),
                  "subtitle": activityMemory['subtitle'].toString(),
                  "imageURL": activityMemory['imageURL'].toString()
                },
                options: opt);

        if (response.statusCode == 200) {
          Fluttertoast.showToast(
              msg: 'WebQuest cadastrada com sucesso!',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0,
              webPosition: 'center');
        }

        //destroi a sessão de palavras para outra consulta ao banco
        await SessionManager().remove("WebQuest");
        await SessionManager().remove("Activities");

        Future.delayed(Duration(seconds: 3), () {
          setState(() {
            Navigator.pushNamed(context, '/home');
          });
        });
      } else {
        await SessionManager().destroy();
        Navigator.pushNamed(context, '/login');
      }
    } catch (e) {
      print(e);
    }
  }

  List<dynamic> informationReferences = [];
  final resourceController = TextEditingController();

  Map<String, TextEditingController> controllers =
      Map<String, TextEditingController>();

  @override
  void initState() {
    // TODO: implement initState
    controllers.addAll({
      'resource': resourceController,
    });

    recuperarLista();
    super.initState();
  }

  void recuperarLista() async {
    bool containWebquest = await SessionManager().containsKey("WebQuest");
    if (containWebquest) {
      dynamic activityMemory = await SessionManager().get("WebQuest");
      //carregar da memoria na tela
      if (informationReferences != null &&
          activityMemory["references"] != null) {
        informationReferences = activityMemory["references"] as List<dynamic>;
      }
    }

    setState(() {});
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
              child: Text('Information References',
                  style: GoogleFonts.arvo(
                      fontSize: 22, color: Color.fromARGB(255, 0, 0, 0)))),
          Container(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: TextField(
              controller: resourceController,
              onChanged: (value) => {},
              decoration: const InputDecoration(
                  labelText: 'htpps://link', suffixIcon: Icon(Icons.ad_units)),
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
                        "Add a reference",
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
                addReference(resourceController.text);
              }),
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                controller: ScrollController(),
                itemCount: informationReferences.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Container(
                          margin: EdgeInsets.only(right: 10, left: 10),
                          width: larguraTela * 0.8,
                          child: Text(
                            informationReferences[index].toString(),
                            overflow: TextOverflow.fade,
                            style: GoogleFonts.arvo(fontSize: 15),
                          )),
                      IconButton(
                          onPressed: () {
                            deleteReference(index);
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
                    salvarEtapa(controllers, null, informationReferences);
                    setState(() {
                      Navigator.pushNamed(context, "/WebQuestConclusionManage");
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
                    salvarWebQuest();
                  },
                  child: const Text(
                    'Salvar Webquest',
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
