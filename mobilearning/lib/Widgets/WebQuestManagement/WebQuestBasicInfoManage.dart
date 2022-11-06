// ignore_for_file: file_names, prefer_const_constructors

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobilearning/Models/activityModel.dart';
import 'package:mobilearning/Widgets/DrawerMobilearning.dart';

class WebBasicInfoManage extends StatefulWidget {
  const WebBasicInfoManage({Key? key}) : super(key: key);

  @override
  State<WebBasicInfoManage> createState() => _WebBasicInfoManage();
}

class _WebBasicInfoManage extends State<WebBasicInfoManage> {
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
        ],
        evaluation: "Evaluation method ....",
        conclusion: "The conclusion ...",
        references: [
          'Link to reference 1',
          'Link to reference 2',
          'Link to reference 3',
        ],
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
      activity.title = titleController.text;
      activity.subtitle = subTitleController.text;
      activity.imageURL = imgUrlController.text;
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
      titleController.text = activityMemory["title"].toString();
      subTitleController.text = activityMemory["subtitle"].toString();
      imgUrlController.text = activityMemory["imageURL"].toString();
    }
  }

  final titleController = TextEditingController();
  final subTitleController = TextEditingController();
  final imgUrlController = TextEditingController();

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
                              child: Text('Basic Information',
                                  style: GoogleFonts.arvo(
                                      fontSize: 22,
                                      color: Color.fromARGB(255, 0, 0, 0)))),
                          Container(
                            margin: EdgeInsets.only(
                                top: 5, bottom: 5, right: 20, left: 20),
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
                              controller: titleController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Digite um titulo para webquest";
                                }
                                return null;
                              },
                              keyboardType: TextInputType.text,
                              cursorColor: Colors.blue,
                              decoration: const InputDecoration(
                                hintText: 'Title',
                                prefixIcon: Icon(
                                  Icons.title,
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
                          Container(
                            margin: EdgeInsets.only(
                                top: 5, bottom: 5, right: 20, left: 20),
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
                              controller: subTitleController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Digite um subtitulo para webquest";
                                }
                                return null;
                              },
                              keyboardType: TextInputType.text,
                              cursorColor: Colors.blue,
                              decoration: const InputDecoration(
                                hintText: 'Subtitle',
                                prefixIcon: Icon(
                                  Icons.subtitles,
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
                          Container(
                            margin: EdgeInsets.only(
                                top: 5, bottom: 20, right: 20, left: 20),
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
                              controller: imgUrlController,
                              onChanged: (value) {
                                if (value.length > 10) {
                                  setState(() {
                                    imgUrlController.text;
                                  });
                                }
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Digite uma url de imagem para webquest";
                                }
                                return null;
                              },
                              keyboardType: TextInputType.text,
                              cursorColor: Colors.blue,
                              decoration: const InputDecoration(
                                hintText: 'Image Url',
                                prefixIcon: Icon(
                                  Icons.image,
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
                          SizedBox(
                            width: larguraTela * 0.9,
                            child: ExtendedImage.network(
                              imgUrlController.text,
                              shape: BoxShape.rectangle,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(30)),
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
                              salvarEtapa("/home");
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
                              salvarEtapa("/WebQuestIntroductionManage");
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
