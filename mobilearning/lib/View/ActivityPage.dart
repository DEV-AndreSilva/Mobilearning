// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, file_names, use_build_context_synchronously, non_constant_identifier_names

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:mobilearning/Widgets/ActivityList.dart';

import '../Models/activityModel.dart';
import '../Models/userModel.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({Key? key}) : super(key: key);

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

Future<List<Activity>> GetActivitiesFromDataBase(
    BuildContext? context) async {
  try {
    Options opt = Options();

    String? token = await SessionManager().get("BearerToken");
    dynamic user = await SessionManager().get("UserLogin");

    if (token != null && token != '' && user != null && user != '') {
      opt.headers = {"authorization": "bearer $token"};
      User usuarioLogado = User.fromJson(user);
      String idUsuarioLogado = usuarioLogado.id.toString();

      var response = await Dio().get(
          'https://mobilearning-api.herokuapp.com/activity/listActivities?idTeacher=${idUsuarioLogado}',
          options: opt);
      List<Activity> activities = [];

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.data);

        for (var element in body) {
          activities.add(Activity.fromJson(element));
        }

        return activities;
      } else {
        await SessionManager().destroy();
        Navigator.pushNamed(context!, '/login');
      }
    }
  } catch (e) {
    print(e);
    List<Activity> words = [];
    return words;
  }

  List<Activity> words = [];
  return words;
}

class _ActivityPageState extends State<ActivityPage> {
  List<Activity> activities = [];

  _ActivityPageState() {
    //preenche a lista com todos os registros do banco de dados
    GetActivitiesFromMemory('', null);
  }

//Método que busca a lista de palavras da memória, caso não exista chama busca do banco de dados
  void GetActivitiesFromMemory(String key, BuildContext? context) async {
    //Verifica se a lista existe na sessão
    bool containActivities =
        await SessionManager().containsKey("Activities");
    if (containActivities) {
      //limpa a lista da tela
      activities = [];
      dynamic res = await SessionManager().get("Activities");

      //verifica se há resultado
      if (res != null && res != '') {
        //preenche a lista da tela com o elemento da memória
        for (var element in res) {
          activities.add(Activity.fromJson(element));
        }
      }
    } else {
      //Caso a lista não exista em memória consulta o banco de dados
      var listActivities = await GetActivitiesFromDataBase(context);
      String jsonEncodeWords = jsonEncode(listActivities);

      //adiciona a lista em memória
      var sessionManager = SessionManager();
      await sessionManager.set('Activities', jsonEncodeWords);
      activities = listActivities;
    }

    //Lista temporária que preenchera a tela
    List<Activity> results = [];

    // Se o Campo de texto está em branco ou com apenas espaços exibe todos os registros
    if (key.isEmpty) {
      results = activities;
    } else {
      results = activities;
      // Preenche a nova lista de resultados apenas com os nomes que possuem o texto procurado
      results = results
          .where((activity) => activity.title!
              .toLowerCase()
              .contains(key.toLowerCase()))
          .toList();
    }

    setState(() {
      //atualiza a interface gráfica
      setState(() {
        activities = results;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //search bar
        Container(
          margin: EdgeInsets.only(bottom: 15),
          child: Padding(padding: EdgeInsets.only(top: 10,left: 25,right: 25),
                  child: TextField(
                    onChanged: (value) => GetActivitiesFromMemory(value, context),
                    decoration: InputDecoration(
                      hintText: "Search...",
                      hintStyle: TextStyle(color: Colors.grey.shade600),
                      prefixIcon: Icon(Icons.search, color: Colors.grey.shade600,),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      contentPadding: EdgeInsets.all(8),
                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: BorderSide(color: Colors.grey.shade100) )
                    ) ,
                  ),),
        ),

        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            controller: ScrollController(),
            itemCount: activities.length,
            itemBuilder: (context, index) => ActivityList(activity: activities[index])
          ),
        ),
      ],
    );
  }
}
