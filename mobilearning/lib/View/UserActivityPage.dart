// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, file_names, use_build_context_synchronously, non_constant_identifier_names

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';

import '../Models/UserActivityModel.dart';
import '../Models/activityModel.dart';
import '../Models/userModel.dart';
import '../Widgets/UserActivityList.dart';

class UserActivityPage extends StatefulWidget {
  const UserActivityPage({Key? key}) : super(key: key);

  @override
  State<UserActivityPage> createState() => _UserActivityPageState();
}

Future<List<UserActivity>> GetActivitiesFromDataBase(BuildContext? context) async {
  try {
    Options opt = Options();

    String? token = await SessionManager().get("BearerToken");
    dynamic user = await SessionManager().get("UserLogin");

    if (token != null && token != '' && user != null && user!= '') {
      opt.headers = {"authorization": "bearer $token"};
      User usuarioLogado = User.fromJson(user);
      String idUsuarioLogado = usuarioLogado.id.toString();

      var response = await Dio().get(
          'https://mobilearning-api.herokuapp.com/userActivity/ListUserActivities?idUser=$idUsuarioLogado',
          options: opt);
      List<UserActivity> activities = [];

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.data);

         for (var element in body) {
           activities.add(UserActivity.fromJson(element));
         }

        return activities;
      } else {
        await SessionManager().destroy();
        Navigator.pushNamed(context!, '/login');
      }
    }
  } catch (e) {
    print(e);
    List<UserActivity> words = [];
    return words;
  }

  List<UserActivity> words = [];
  return words;
}

class _UserActivityPageState extends State<UserActivityPage> {
  List<UserActivity> activities = [];

  _UserActivityPageState() {
    //preenche a lista com todos os registros do banco de dados
    GetActivitiesFromMemory('', null);
  }

//Método que busca a lista de palavras da memória, caso não exista chama busca do banco de dados
  void GetActivitiesFromMemory(String key, BuildContext? context) async {
    //Verifica se a lista existe na sessão
    bool containActivities =
        await SessionManager().containsKey("UserActivities");
    if (containActivities) {
      //limpa a lista da tela
      activities = [];
      dynamic res = await SessionManager().get("UserActivities");

      //verifica se há resultado
      if (res != null && res != '') {
        //preenche a lista da tela com o elemento da memória
        for (var element in res) {
          activities.add(UserActivity.fromJson(element));
        }
      }
    } else {
      //Caso a lista não exista em memória consulta o banco de dados
      var listActivities = await GetActivitiesFromDataBase(context);
      String jsonEncodeWords = jsonEncode(listActivities);

      //adiciona a lista em memória
      var sessionManager = SessionManager();
      await sessionManager.set('UserActivities', jsonEncodeWords);
      activities = listActivities;
    }

    //Lista temporária que preenchera a tela
    List<UserActivity> results = [];

    // Se o Campo de texto está em branco ou com apenas espaços exibe todos os registros
    if (key.isEmpty) {
      results = activities;
    } else {
      results = activities;
      // Preenche a nova lista de resultados apenas com os nomes que possuem o texto procurado
      results = results
          .where((userActivity) =>
              userActivity.activity.title!.toLowerCase().contains(key.toLowerCase()))
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
        Padding(
          padding: EdgeInsets.only(top: 10, left: 25, right: 25),
          child: TextField(
            onChanged: (value) => GetActivitiesFromMemory(value, context),
            decoration: InputDecoration(
                hintText: "Search...",
                hintStyle: TextStyle(color: Colors.grey.shade600),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey.shade600,
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
                contentPadding: EdgeInsets.all(8),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.grey.shade100))),
          ),
        ),

        SizedBox(
          width: 16,
        ),

        Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                controller: ScrollController(),
                itemCount: activities.length,
                itemBuilder: (context, index) => UserActivityList(
                      userActivity: activities[index],
                    ))),
      ],
    );
  }
}
