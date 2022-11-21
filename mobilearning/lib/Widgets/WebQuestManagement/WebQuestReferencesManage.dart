// ignore_for_file: file_names, prefer_const_constructors

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobilearning/Models/UserActivityResumeModel.dart';
import 'package:mobilearning/Models/activityModel.dart';
import 'package:mobilearning/Models/studentModel.dart';
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

  String verficarPreenchimentoCampos(
      dynamic activityMemory, List<dynamic> references) {
    String mensagem = "Preencha as etapas: ";
    String preencher = "";

    if (activityMemory['introduction'] == null)
      preencher += " - introduction";
    else if (activityMemory['introduction'] == "")
      preencher += " - introduction";

    if (activityMemory['task'] == null)
      preencher += " - task";
    else if (activityMemory['task'] == "") preencher += " - task";

    if (activityMemory['process'] == null)
      preencher += " - process";
    else if (activityMemory['process'] == "") preencher += " - process";

    if (activityMemory['information'] == null)
      preencher += " - information";
    else if (activityMemory['information'].length == 0)
      preencher += " - information";

    if (activityMemory['evaluation'] == null)
      preencher += " - evaluation";
    else if (activityMemory['evaluation'] == "") preencher += " - evaluation";

    if (activityMemory['conclusion'] == null)
      preencher += " - conclusion";
    else if (activityMemory['conclusion'] == "") preencher += " - conclusion";

    if (activityMemory['title'] == null)
      preencher += " - title";
    else if (activityMemory['title'] == "") preencher += " - title";

    if (activityMemory['subtitle'] == null)
      preencher += " - subtitle";
    else if (activityMemory['subtitle'] == "") preencher += " - subtitle";

    if (activityMemory['imageURL'] == null)
      preencher += " - imageURL";
    else if (activityMemory['imageURL'] == "") preencher += " - imageURL";

    if (references.length == 0) preencher += " - References";

    if (preencher == "")
      return preencher;
    else
      return mensagem + preencher;
  }

  void salvarWebQuest() async {
    salvarEtapa(controllers, null, informationReferences);

    try {
      //Sessão possui token
      bool containToken = await SessionManager().containsKey("BearerToken");
      //Sessão possui WebQuest
      bool containWebquest = await SessionManager().containsKey("WebQuest");
      //Sessão possui login
      bool containUser = await SessionManager().containsKey("UserLogin");

      //verifica se os tokens foram carregados
      if (containToken && containWebquest && containUser) {
        String token = await SessionManager().get("BearerToken");
        dynamic activityMemory = await SessionManager().get("WebQuest");
        dynamic user = await SessionManager().get("UserLogin");
        User jsonUser = User.fromJson(user);
        int idTeacher = jsonUser.id;

        //verifica se os campos obrigatórios para cadastro da webquest foram preenchidos
        var preencher =
            verficarPreenchimentoCampos(activityMemory, informationReferences);

        if (preencher == '') {
          Options opt = Options();
          opt.headers = {"authorization": "bearer $token"};

          if (activityMemory['id'] != null) {
            var response = await Dio().put(
                "https://mobilearning-api.herokuapp.com/activity/update?id=${activityMemory['id']}",
                data: {
                  "idTeacher": idTeacher,
                  "introduction": activityMemory['introduction'].toString(),
                  "task": activityMemory['task'].toString(),
                  "process": activityMemory['process'].toString(),
                  "information": activityMemory['information'] as List<dynamic>,
                  "evaluation": activityMemory['evaluation'].toString(),
                  "conclusion": activityMemory['conclusion'].toString(),
                  "references": informationReferences,
                  "title": activityMemory['title'].toString(),
                  "subtitle": activityMemory['subtitle'].toString(),
                  "imageURL": activityMemory['imageURL'].toString()
                },
                options: opt);

            bool containListStudentRelated = await SessionManager().containsKey("studentsRelation");

            //carrego as atividades da memória
            dynamic studentsRelationMemory ="";
            dynamic studentsRelationOld = "";
            if (containListStudentRelated) 
            {
              List<UserActivitResume> studentsMemory = [];
              List<UserActivitResume> studentsMemoryOld = [];

              
               studentsRelationMemory = await SessionManager().get("studentsRelation");
               studentsRelationOld = await SessionManager().get("studentsRelationOld");

              studentsRelationMemory.forEach((element) {
              studentsMemory.add(UserActivitResume.fromJsonStudent(element));
               });

               studentsRelationOld.forEach((element) {
              studentsMemoryOld.add(UserActivitResume.fromJsonStudent(element));
               });

              List<int> idsUsersNew = [];
              List<int> idsUsersOld = [];

              //crio a lista com os ids dos novos e dos antigos
              studentsMemory.forEach((elementNew) 
              {
                idsUsersNew.add(elementNew.idUser!);  
              });

              studentsMemoryOld.forEach((elementOld) 
              {
                idsUsersOld.add(elementOld.idUser!);  
              });

              //removo os antigos que não tem na lista nova [1,2,3] [1,2]
              List<int> idsRemove = idsUsersOld.toSet().difference(idsUsersNew.toSet()).toList();

              //adiciono os novos que não tem na lista antiga
              List<int> idsAdd = idsUsersNew.toSet().difference(idsUsersOld.toSet()).toList();

              idsAdd.forEach((idUser) async {

                var response = await Dio().post(
                "https://mobilearning-api.herokuapp.com/userActivity",
                data: {
                  "idUser":idUser,
                  "idActivity":activityMemory['id'],
                  "currentStage": "introduction",
                  "progress":"14"
                },
                options: opt);

               });

               
            idsRemove.forEach((idUser)async {

                var response = await Dio().delete(
                "https://mobilearning-api.herokuapp.com/userActivity/delete?idUser=${idUser}&idActivity=${activityMemory['id']}",
                options: opt);


            });

            }


            //verifica se atividade foi cadastrada
            if (response.statusCode == 200) {
              Fluttertoast.showToast(
                  msg: 'WebQuest atualizada com sucesso!',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 3,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0,
                  webPosition: 'center');
            }

            Future.delayed(Duration(seconds: 3), () {
              setState(() {
                Navigator.pushNamed(context, '/home');
              });
            });
          } else {
            bool containListStudentRelated =
                await SessionManager().containsKey("studentsRelation");
            dynamic studentsRelationMemory ="";
            if (containListStudentRelated) {
               studentsRelationMemory =
                  await SessionManager().get("studentsRelation");
            }

            var response = await Dio().post(
                "https://mobilearning-api.herokuapp.com/activity",
                data: {
                  "idTeacher": idTeacher,
                  "introduction": activityMemory['introduction'].toString(),
                  "task": activityMemory['task'].toString(),
                  "process": activityMemory['process'].toString(),
                  "information": activityMemory['information'] as List<dynamic>,
                  "evaluation": activityMemory['evaluation'].toString(),
                  "conclusion": activityMemory['conclusion'].toString(),
                  "references": informationReferences,
                  "title": activityMemory['title'].toString(),
                  "subtitle": activityMemory['subtitle'].toString(),
                  "imageURL": activityMemory['imageURL'].toString(),
                  "usersActivity": studentsRelationMemory
                },
                options: opt);

            //verifica se atividade foi cadastrada
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

           
            Future.delayed(Duration(seconds: 3), () {
              setState(() {
                Navigator.pushNamed(context, '/home');
              });
            });
          }

        //destroi a sessão de palavras para outra consulta ao banco
        await SessionManager().remove("WebQuest");
        await SessionManager().remove("Activities");
        await SessionManager().remove("studentsRelation");
        await SessionManager().remove("studentsRelationOld");

        } else {
          Fluttertoast.showToast(
              msg: preencher,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 5,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0,
              webPosition: 'center');
        }
      } else {
        print("objetos da memória necessários para cadastro não encontrado");
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
                      Navigator.pushNamed(context, "/WebQuestRelationManage");
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
