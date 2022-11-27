// ignore_for_file: file_names, prefer_const_constructors

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobilearning/Widgets/DrawerMobilearning.dart';
import 'package:mobilearning/functions.dart';

class WebBasicInfoManage extends StatefulWidget {
  const WebBasicInfoManage({Key? key}) : super(key: key);

  @override
  State<WebBasicInfoManage> createState() => _WebBasicInfoManage();
}

class _WebBasicInfoManage extends State<WebBasicInfoManage> {
  final titleController = TextEditingController();
  final subTitleController = TextEditingController();
  final imgUrlController = TextEditingController();
  Map<String, TextEditingController> controllers =
      Map<String, TextEditingController>();

  @override
  void initState() {
    // TODO: implement initState

    controllers.addAll({
      'title': titleController,
      'subtitle': subTitleController,
      'imageURL': imgUrlController,
    });

    recuperarEtapa(controllers, null, null);
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
                              //salvarEtapa(controllers, null, null);
                              limparSessao();
                              setState(() {
                                Navigator.pushNamed(context, "/home");
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
                                    context, "/WebQuestIntroductionManage");
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
