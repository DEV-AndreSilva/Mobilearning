import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:mobilearning/Models/activityModel.dart';
import 'package:mobilearning/Models/userModel.dart';

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


