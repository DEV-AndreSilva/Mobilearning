// ignore_for_file: prefer_const_constructors, file_names


import 'package:carbon_icons/carbon_icons.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobilearning/Models/glossaryWordModel.dart';

import '../Widgets/DrawerMobilearning.dart';

class WordPage extends StatefulWidget {
  const WordPage({Key? key}) : super(key: key);

  @override
  State<WordPage> createState() => _WordPageState();
}

class _WordPageState extends State<WordPage> {
  final englishWord = TextEditingController();
  final portugueseWord = TextEditingController();
  final englishDefinition = TextEditingController();
  final portugueseDefinition = TextEditingController();
  bool alter = true;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    void alterWord(int wordID, String englishWord, String englishDefinition,
        String portugueseWord, String portugueseDefinition) async {
      try {
        Options opt = Options();
        String token = await SessionManager().get("BearerToken");

        if (token != '') {
          opt.headers = {"authorization": "bearer $token"};

          var response = await Dio()
              .put('https://mobilearning-api.herokuapp.com/word/$wordID',
                  data: {
                    'PortugueseWord': portugueseWord,
                    'EnglishWord': englishWord,
                    'PortugueseDefinition': portugueseDefinition,
                    'EnglishDefinition': englishDefinition
                  },
                  options: opt);

          if (response.statusCode == 200) {
            Fluttertoast.showToast(
                msg: 'Word updated with success!',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 3,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0,
                webPosition: 'center');
          }

          //destroi a sessão de palavras para outra consulta ao banco
          await SessionManager().remove("Words");

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

    void deleteWord(int wordID) async {
      try {
        Options opt = Options();
        String token = await SessionManager().get("BearerToken");

        if (token != '') {
          opt.headers = {"authorization": "bearer $token"};

          var response = await Dio().delete(
              'https://mobilearning-api.herokuapp.com/word/$wordID',
              options: opt);

          if (response.statusCode == 200) {
            Fluttertoast.showToast(
                msg: 'Word deleted with success!',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 3,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0,
                webPosition: 'center');
          }

          //destroi a sessão de palavras para outra consulta ao banco
          await SessionManager().remove("Words");

          Future.delayed(Duration(seconds: 3), () {
            setState(() {
              Navigator.pushNamed(context, '/home');
            });
          });
        }
      } catch (e) {
        print(e);
      }
    }

    void createWord(String englishWord, String englishDefinition,
        String portugueseWord, String portugueseDefinition) async {
      try {
        Options opt = Options();
        String token = await SessionManager().get("BearerToken");

        if (token != '') {
          opt.headers = {"authorization": "bearer $token"};
          var response =
              await Dio().post('https://mobilearning-api.herokuapp.com/word',
                  data: {
                    'PortugueseWord': portugueseWord,
                    'EnglishWord': englishWord,
                    'PortugueseDefinition': portugueseDefinition,
                    'EnglishDefinition': englishDefinition
                  },
                  options: opt);

          if (response.statusCode == 200) {
            Fluttertoast.showToast(
                msg: 'Word created with success!',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 3,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 18.0,
                webPosition: 'center');
          }

          //destroi a sessão de palavras para outra consulta ao banco
          await SessionManager().remove("Words");

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

    bool validateForm(
        String engWord, String portWord, String engDefin, String portdef) {
      if (engWord == "" || portWord == "" || engDefin == "" || portdef == "") {
        Fluttertoast.showToast(
            msg: "Complete all fields !",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 4,
            backgroundColor: Colors.redAccent,
            textColor: Colors.white,
            fontSize: 18.0,
            webPosition: 'center');

        return false;
      }

      return true;
    }

    final dynamic args = ModalRoute.of(context)?.settings.arguments;

    bool isAlter = args != null ? true : false;

    if (args != null && alter) {
      GlossaryWord word = GlossaryWord(
          id: args.id,
          userId: args.userId,
          englishWord: args.englishWord,
          portugueseWord: args.portugueseWord,
          englishDefinition: args.englishDefinition,
          portugueseDefinition: args.portugueseDefinition);

      englishWord.text = word.englishWord;
      portugueseWord.text = word.portugueseWord;
      englishDefinition.text = word.englishDefinition;
      portugueseDefinition.text = word.portugueseDefinition;

      //controle da atualização da tela
      alter = false;
    }

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
            key: _formKey,
            child: Column(
              children: <Widget>[
                args !=null ?
                Container(
                  
                    margin: EdgeInsets.only(top: alturaTela * 0.025, right: 20),
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          
                          icon: Icon(
                            Icons.delete,
                            size: 40,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            if (args.id != 0) {
                              return deleteWord(args.id);
                            } 
                          },
                        ),
                      ],
                    ))
                    : Container(),
                Container(
                  margin: EdgeInsets.only(
                      top: alturaTela * 0.025, right: 20, left: 20),
                  height: 50,
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
                    controller: englishWord,
                    keyboardType: TextInputType.text,
                    cursorColor: Colors.blue,
                    decoration: const InputDecoration(
                      hintText: 'Write the new english word',
                      prefixIcon: Icon(CarbonIcons.letter_aa_large,
                          color: Colors.blue, size: 25.0),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: 10,
                    right: 20,
                    left: 20,
                  ),
                  height: 50,
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
                    controller: portugueseWord,
                    keyboardType: TextInputType.text,
                    cursorColor: Colors.blue,
                    decoration: const InputDecoration(
                      hintText: 'Write the new portuguese word',
                      prefixIcon: Icon(CarbonIcons.letter_bb,
                          color: Colors.blue, size: 25.0),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(20),
                  margin: const EdgeInsets.only(
                    top: 10,
                    right: 20,
                    left: 20,
                  ),
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
                  child: Column(children: [
                    TextField(
                      controller: englishDefinition,
                      decoration: InputDecoration(
                          hintText: "Write the english definition",
                          border: InputBorder.none,
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.blue))),
                      keyboardType: TextInputType.multiline,
                      maxLines: 4,
                    ),
                  ]),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(20),
                  margin: const EdgeInsets.only(
                    top: 10,
                    right: 20,
                    left: 20,
                  ),
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
                  child: Column(children: [
                    TextField(
                      controller: portugueseDefinition,
                      decoration: InputDecoration(
                          hintText: "Write the portuguese definition",
                          border: InputBorder.none,
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.blue))),
                      keyboardType: TextInputType.multiline,
                      maxLines: 4,
                    ),
                  ]),
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
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            Navigator.pop(context);
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
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      child: TextButton(
                        onPressed: () {
                          if (validateForm(
                              englishWord.text,
                              englishDefinition.text,
                              portugueseWord.text,
                              portugueseDefinition.text)) {
                            if (isAlter) {
                              alterWord(
                                  args.id,
                                  englishWord.text,
                                  englishDefinition.text,
                                  portugueseWord.text,
                                  portugueseDefinition.text);
                            } else {
                              createWord(
                                  englishWord.text,
                                  englishDefinition.text,
                                  portugueseWord.text,
                                  portugueseDefinition.text);
                            }
                          }
                        },
                        child: const Text(
                          'Confirmar',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
