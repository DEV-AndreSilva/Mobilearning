// ignore_for_file: must_be_immutable, prefer_const_constructors, file_names

import 'package:dio/dio.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobilearning/Models/activityModel.dart';
import 'package:mobilearning/Models/userModel.dart';

import '../View/ActivityPage.dart';

class ActivityList extends StatefulWidget {
  Activity activity;

  ActivityList({super.key, required this.activity});

  @override
  State<ActivityList> createState() => _ActivityListState();
}



class _ActivityListState extends State<ActivityList> {

  void deleteActivity (int idActivity)async
{
  //Sessão possui token
  bool containToken = await SessionManager().containsKey("BearerToken");

  //Sessão possui login
  bool containUser = await SessionManager().containsKey("UserLogin");

  if(containToken && containUser)
  {
    String token = await SessionManager().get("BearerToken");
    
    dynamic user = await SessionManager().get("UserLogin");
    User jsonUser = User.fromJson(user);
    int idTeacher = jsonUser.id;

    Options opt = Options();
    opt.headers = {"authorization": "bearer $token"};
    var response = await Dio().delete("https://mobilearning-api.herokuapp.com/activity/delete?id=${idActivity}&idTeacher=${idTeacher}",
  
            options: opt);
  
    //verifica se atividade foi cadastrada
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: 'WebQuest Deletada com sucesso!',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
          webPosition: 'center');
    }

        //destroi a sessão de palavras para outra consulta ao banco
        await SessionManager().remove("Activities");

        //com a classe publica é possivel chamar o metdodo de um estado anterior da tela        
        context.findAncestorStateOfType<ActivityPageState>()?.GetActivitiesFromMemory("", context);
      

  }

}

  void updateWebQuest()async {

     //abre o arquivo de sessão
    SessionManager sessionManager = SessionManager();

    //atualiza o arquivo de sessão com o arquivo da memoria
    await sessionManager.set('WebQuest', widget.activity);


    setState(() {
                          Navigator.pushNamed(
                              context, "/WebQuestBasicInfoManage");
                             
                        });
  }


  @override
  Widget build(BuildContext context) {
    var larguraTela = MediaQuery.of(context).size.width;
    var alturaTela = MediaQuery.of(context).size.height;

    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 15, bottom: 15),
                width: larguraTela*0.45,
                child: Text(
                  "WebQuest:",
                  overflow: TextOverflow.fade,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                width: larguraTela*0.40,
                
                child: Text(widget.activity.title!, style: TextStyle(fontSize: 20)))
            ],
          ),
          SizedBox(
            width: larguraTela * 0.90,
            child: ExtendedImage.network(
              widget.activity.imageURL!,
              shape: BoxShape.rectangle,
              borderRadius: const BorderRadius.all(Radius.circular(30)),
            ),
          ),
          ExpansionTile(
            title: Text("More information"),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    padding: EdgeInsets.only(left: 5,right: 5),
                    child: GestureDetector(
                      child: Container(
                        margin: EdgeInsets.only(bottom: 10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.orange[700],
                          border: Border.all(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                            child: Row(
                              children: [
                                Icon(Icons.edit, color: Colors.white,),
                                Container(
                                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: Text(
                          "Edit",
                          style: GoogleFonts.arvo(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white),
                        ),
                                ),
                              ],
                            )),
                      ),
                      onTap: () => {
                        updateWebQuest()
                        
                      },
                    ),
                  ),

                   Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    padding: EdgeInsets.only(left: 5,right: 5),
                    child: GestureDetector(
                      child: Container(
                        margin: EdgeInsets.only(bottom: 10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color:Colors.red[700],
                          border: Border.all(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                            child: Row(
                              children: [
                                Icon(Icons.delete, color: Colors.white),
                                Container(
                                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: Text(
                          "Delete",
                          style: GoogleFonts.arvo(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white),
                        ),
                                ),
                              ],
                            )),
                      ),
                      onTap: () => {
                            deleteActivity(widget.activity.id!)
                      }
                      
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
  

}
