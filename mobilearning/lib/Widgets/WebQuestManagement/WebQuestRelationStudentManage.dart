// ignore_for_file: file_names, prefer_const_constructors

import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobilearning/Models/UserActivityResumeModel.dart';
import 'package:mobilearning/Widgets/DrawerMobilearning.dart';

class WebQuestRelationStudentManage extends StatefulWidget {
  const WebQuestRelationStudentManage({Key? key}) : super(key: key);

  @override
  State<WebQuestRelationStudentManage> createState() =>
      _WebQuestRelationStudentManage();
}

class _WebQuestRelationStudentManage
    extends State<WebQuestRelationStudentManage> {
  void addRelation(UserActivitResume student) {
    if (student != "") 
    {
      setState(() {
        studentsDatabase.remove(student);
        studentsRelation.add(student);
      });
    }
  }

  void removeRelation(UserActivitResume student) 
  {
    setState(() {
        studentsRelation.remove(student);
        studentsDatabase.add(student);
    });

    return null;
  }

  void salvarEtapaRelation( List<UserActivitResume> listRelated)
  {
   var session = SessionManager();
   String jsonEncodeUserActivityResume = jsonEncode(listRelated);
   session.set("studentsRelation", jsonEncodeUserActivityResume);
  }

  List<UserActivitResume> studentsRelation = [];
  List<UserActivitResume> studentsDatabase = [];

  final studentController = TextEditingController();

  Map<String, TextEditingController> controllers =
      Map<String, TextEditingController>();

  @override
  void initState() {
    // TODO: implement initState
    controllers.addAll({
      'student': studentController,
    });

    recuperarLista();
    super.initState();
  }

  void recuperarLista() async {
    //Sessão possui token
    bool containToken = await SessionManager().containsKey("BearerToken");

    List<UserActivitResume> studentsRelationTemp = [];
    List<UserActivitResume> studentsDatabaseTemp = [];

    Options opt = Options();

    //recupera a lista com todos os estudantes
    if (containToken) {
      String token = await SessionManager().get("BearerToken");
      opt.headers = {"authorization": "bearer $token"};
      var responseAllStudents = await Dio().get(
          'https://mobilearning-api.herokuapp.com/student/ListStudents',
          options: opt);

      if (responseAllStudents.statusCode == 200) {
        List<dynamic> body = jsonDecode(responseAllStudents.data);

        for (var element in body) {
          studentsDatabaseTemp.add(UserActivitResume.fromJsonStudent(element));
        }
      }
    }

    //recupera a lista dos estudantes relacionados a atividade
      dynamic activityMemory = await SessionManager().get("WebQuest");
      bool containListRelated = await SessionManager().containsKey("studentsRelation");

      if(containListRelated)
      {
        dynamic studentsRelationMemory = await SessionManager().get("studentsRelation");
        //List<dynamic> studentsMemoryJson = jsonDecode( studentsRelationMemory);
        studentsRelationMemory.forEach((element) {
              studentsRelationTemp.add(UserActivitResume.fromJsonStudent(element));
        });
      }

      else if (activityMemory['id'] != null && containToken) 
      {
        String token = await SessionManager().get("BearerToken");
        opt.headers = {"authorization": "bearer $token"};
        var responseStudentsRelation = await Dio().get(
            'https://mobilearning-api.herokuapp.com/userActivity/ListUsersFromActivity?idActivity=${activityMemory['id']}',
            options: opt);

        if (responseStudentsRelation.statusCode == 200) {
          List<dynamic> body = jsonDecode(responseStudentsRelation.data);

          for (var element in body) {
            studentsRelationTemp.add(UserActivitResume.fromJson(element));
          }
        }
      }

      var listIDStudentRelated = [];
      
    
      studentsDatabaseTemp.forEach((databasetemp) 
      {
          studentsRelationTemp.forEach((element) {
            if(element.idUser == databasetemp.idUser)
            {
              if(!listIDStudentRelated.contains(element.idUser))
              {
                listIDStudentRelated.add(element.idUser);
              }
            }
          });

      });

      studentsDatabaseTemp.forEach((element) {
          if(!listIDStudentRelated.contains(element.idUser))
          {
            studentsDatabase.add(element);
          }

      });

    studentsRelation = studentsRelationTemp;

    SessionManager().set("studentsRelationOld", jsonEncode(studentsRelation));


    setState(() {

       
    });
  }

  @override
  Widget build(BuildContext context) {
    var larguraTela = MediaQuery.of(context).size.width;
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
      body: Column(
        children: [
          Container(
              margin: EdgeInsets.only(top: 20),
              child: Text('Students Relations',
                  style: GoogleFonts.arvo(
                      fontSize: 22, color: Color.fromARGB(255, 0, 0, 0)))),
          Container(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
            child: TextField(
              controller: studentController,
              onChanged: (value) => {},
              decoration: const InputDecoration(
                  labelText: 'Type a student name',
                  suffixIcon: Icon(Icons.school_outlined)),
            ),
          ),
          Flexible(
            child: Container(
              height: alturaTela * 0.3,
              child: ListView.builder(
                  shrinkWrap: true,
                  controller: ScrollController(),
                  itemCount: studentsDatabase.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                          color: index % 2 == 0
                              ? Colors.grey[100]
                              : Colors.grey[300]),
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: GestureDetector(
                        onTap: () => addRelation(studentsDatabase[index]),
                        child: Row(
                          children: [
                            Container(
                                margin: EdgeInsets.only(
                                  right: 10,
                                  left: 10,
                                ),
                                width: larguraTela * 0.5,
                                child: Text(
                                  studentsDatabase[index].name.toString(),
                                  overflow: TextOverflow.fade,
                                  style: GoogleFonts.arvo(fontSize: 15),
                                )),
                            Container(
                              child: Text("Add Relation"),
                              margin: EdgeInsets.only(right: 10, left: 10),
                            ),
                            Icon(Icons.add_reaction),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 20),
              child: Text('Students Related',
                  style: GoogleFonts.arvo(
                      fontSize: 22, color: Color.fromARGB(255, 0, 0, 0)))),
          Flexible(
            child: Container(
              height: alturaTela * 0.3,
              child: ListView.builder(
                  shrinkWrap: true,
                  controller: ScrollController(),
                  itemCount: studentsRelation.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                          color: index % 2 == 0
                              ? Colors.grey[100]
                              : Colors.grey[300]),
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: GestureDetector(
                        onTap: () => removeRelation(studentsRelation[index]),
                        child: Row(
                          children: [
                            Container(
                                margin: EdgeInsets.only(
                                  right: 10,
                                  left: 10,
                                ),
                                width: larguraTela * 0.5,
                                child: Text(
                                  studentsRelation[index].name.toString(),
                                  overflow: TextOverflow.fade,
                                  style: GoogleFonts.arvo(fontSize: 15),
                                )),
                            Container(
                              child: Text("Remove Relation"),
                              margin: EdgeInsets.only(right: 10, left: 10),
                            ),
                            Icon(Icons.delete_forever),
                          ],
                        ),
                      ),
                    );
                  }),
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
                    //salvarEtapa(controllers, null, informationReferences);
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
                    salvarEtapaRelation(studentsRelation);
                    setState(() {
                      Navigator.pushNamed(context, "/WebQuestReferencesManage");
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
      ),
    );
  }
}
