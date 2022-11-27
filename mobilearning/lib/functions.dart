import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobilearning/Models/activityModel.dart';
import 'package:mobilearning/Models/userModel.dart';
import 'package:url_launcher/url_launcher.dart';

void recuperarEtapa(Map<String, TextEditingController> controllers,
    List<dynamic>? informationResources, List<dynamic>? references) async {
  //verifico se na sessão existe a key WebQuest
  bool containWebquest = await SessionManager().containsKey("WebQuest");
  if (containWebquest) {
    //recupero a key
    dynamic activityMemory = await SessionManager().get("WebQuest");

    //altero o valor do text controller de acordo com seu tipo
    controllers.forEach((key, value) {
      switch (key) {
        case "title":
          value.text = activityMemory["title"]??"";
          break;
        case "subtitle":
          value.text = activityMemory["subtitle"]??"";
          break;
        case "imageURL":
          value.text = activityMemory["imageURL"]??"";
          break;
        case "introduction":
          value.text = activityMemory["introduction"]??"";
          break;
        case "task":
          value.text = activityMemory["task"]??"";
          break;
        case "process":
          value.text = activityMemory["process"]??"";
          break;
        case "evaluation":
          value.text = activityMemory["evaluation"]??"";
          break;
        case "conclusion":
          value.text = activityMemory["conclusion"]??"";
      }
    });

  }
}

void salvarEtapa(Map<String, TextEditingController> controllers,
    List<dynamic>? informationResources, List<dynamic>? references) async {
  Activity activity = Activity();

  try {
    int idTeacher = 0;

    //verifico se existe sessão de usuário
    bool containUser = await SessionManager().containsKey("UserLogin");
    if (containUser) {
      dynamic user = await SessionManager().get("UserLogin");
      User jsonUser = User.fromJson(user);
      idTeacher = jsonUser.id;
    }

    //verifica se existe WebQuest na sessão
    bool containWebquest = await SessionManager().containsKey("WebQuest");

    //atualiza o registro da memória com os dados que existem na sessão
    if (containWebquest) {
      dynamic activityMemory = await SessionManager().get("WebQuest");

      //carregar activityMemory em activity

      if (activityMemory['id'] != ""  &&  activityMemory['id'] != null) {
        activity.id = activityMemory['id'];
      }

      if (activityMemory['introduction'] != ""  &&  activityMemory['introduction'] != null) {
        activity.introduction = activityMemory['introduction'].toString();
      }

      if (activityMemory['task']!= ""  && activityMemory['task'] != null) {
        activity.task = activityMemory['task'].toString();
      }

      if (activityMemory['process']!= ""  &&
          activityMemory['process'] != null) {
        activity.process = activityMemory['process'].toString();
      }

      if (activityMemory['evaluation']!= ""  &&
          activityMemory['evaluation'] != null) {
        activity.evaluation = activityMemory['evaluation'].toString();
      }

      if (activityMemory['conclusion']!= ""  &&
          activityMemory['conclusion'] != null) {
        activity.conclusion = activityMemory['conclusion'].toString();
      }


      if (activityMemory['imageURL']!= ""  &&
          activityMemory['imageURL'] != null) {
        activity.imageURL = activityMemory['imageURL'].toString();
      }

      if (activityMemory['subtitle']!= ""  &&
          activityMemory['subtitle'] != null) {
        activity.subtitle = activityMemory['subtitle'].toString();
      }

      if (activityMemory['title']!= ""  && activityMemory['title'] != null) {
        activity.title = activityMemory['title'].toString();
      }

      activity.idTeacher = idTeacher;

      if(activityMemory['information'] != null)
      {
       activity.information =  activityMemory['information'];
      }

      if(activityMemory['references'] != null)
      {
       activity.references=  activityMemory['references'];
      }


    }
  } catch (ex) {
    print("erro ${ex}");
    ;
  } finally {
    //abre o arquivo de sessão
    SessionManager sessionManager = SessionManager();

    //atualiza o arquivo da memória com os dados que vieram da tela
    controllers.forEach((key, value) {
      switch (key) {
        case "title":
          activity.title = value.text;
          break;
        case "subtitle":
          activity.subtitle = value.text;
          break;
        case "imageURL":
          activity.imageURL = value.text;
          break;
        case "introduction":
          activity.introduction = value.text;
          break;
        case "task":
          activity.task = value.text;
          break;
        case "process":
          activity.process = value.text;
          break;

        case "evaluation":
          activity.evaluation = value.text;
          break;

        case "conclusion":
          activity.conclusion = value.text;
          break;
      }
    });

    //atualizar memória
    if (informationResources != null)
    {
      activity.information =  informationResources ;
    }

    if (references != null) 
    {
      activity.references =  references ;
    }

    //atualiza o arquivo de sessão com o arquivo da memoria
    await sessionManager.set('WebQuest', activity);
  }
}

void limparSessao()async
{
   await SessionManager().remove("WebQuest");
}


  void SalvarProgressoWebQuest(dynamic args, String stage) async {
    if (args != null) {
      Options opt = Options();
      double progress = 0.0;

      String token = await SessionManager().get("BearerToken");
      switch(stage)
      {
        case "Introduction":
        progress = 14.2;
        break;

        case "Task":
        progress = 28.4;
        break;

        case "Process":
        progress = 42.6;
        break;

        case "Information":
        progress = 56.8;
        break;

        case "Evaluation":
        progress = 71.0;
        break;

        case "Conclusion":
        progress = 85.2;
        break;

        case "References":
        progress = 100;
        break;
        
        default:break;
      }

      if (token != '') {
        opt.headers = {"authorization": "bearer $token"};
        var response = await Dio().put(
            'https://mobilearning-api.herokuapp.com/userActivity/update?id=${args.id}',
            data: {
              "idUser": args.idUser,
              "idActivity": args.idActivity,
              "currentStage": stage,
              "progress": progress.toString(),
            },
            options: opt);

        if (response.statusCode != 200) {
            print("Erro ao salvar progresso");
        }
      }
    }
  }

  String getRouteContinue (String stage)
  {
    String route = "";

     switch(stage)
      {
        case "Introduction": case "introduction":
        route = "/WebQuestIntroductionView";
        break;

        case "Task":case "task":
        route = "/WebQuestTaskView";
        break;

        case "Process":case "process":
        route = "/WebQuestProcessView";
        break;

        case "Information":case "information":
        route = "/WebQuestInformationView";
        break;

        case "Evaluation":case "evaluation":
        route = "/WebQuestEvaluationView";
        break;

        case "Conclusion":case "conclusion":
        route = "/WebQuestConclusionView";
        break;

        case "References":case "references":
        route = "/WebQuestReferencesView";
        break;
        
        default:break;
      }

    return route;
  }

void launchURL(String url) async =>
    await canLaunch(url) ? await launch(url) : Fluttertoast.showToast(
          msg: 'Link invalido, contate seu professor',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 4,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
          webPosition: 'center');
  
