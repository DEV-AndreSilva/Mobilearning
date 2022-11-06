// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mobilearning/View/WordPage.dart';
import 'package:mobilearning/Widgets/WebQuestManagement/WebQuestBasicInfoManage.dart';
import 'package:mobilearning/Widgets/WebQuestView/WebQuestEvaluationView.dart';
import 'package:mobilearning/Widgets/WebQuestView/WebQuestConclusionView.dart';
import 'package:mobilearning/Widgets/WebQuestView/WebQuestInformationView.dart';
import 'package:mobilearning/Widgets/WebQuestView/WebQuestProcessView.dart';
import 'package:mobilearning/Widgets/WebQuestView/WebQuestReferencesView.dart';
import 'package:mobilearning/Widgets/WebQuestView/WebQuestTaskView.dart';
import 'package:mobilearning/Widgets/WebQuestView/WebQuestIntroductionView.dart';
import 'package:mobilearning/Widgets/WebQuestManagement/WebQuestConclusionManage.dart';
import 'package:mobilearning/Widgets/WebQuestManagement/WebQuestEvaluationManage.dart';
import 'package:mobilearning/Widgets/WebQuestManagement/WebQuestInformationManage.dart';
import 'package:mobilearning/Widgets/WebQuestManagement/WebQuestIntroductionManage.dart';
import 'package:mobilearning/Widgets/WebQuestManagement/WebQuestProcessManage.dart';
import 'package:mobilearning/Widgets/WebQuestManagement/WebQuestReferencesManage.dart';
import 'package:mobilearning/Widgets/WebQuestManagement/WebQuestTaskManage.dart';
import 'HomeView.dart';
import 'LoginView.dart';
import 'C_AlunosView.dart';
import 'C_ProfessoresView.dart';
import 'C_turma.dart';



class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    debugShowCheckedModeBanner: false,
     initialRoute: '/login' ,
     routes: {
      '/login' :(context)=> Login(),
      '/home':(context)=> Home(),
      '/calunos': (context)=> CAlunos(),
      '/cprofessores': (context)=> CProfessores(),
      '/cword': (context)=> WordPage(),
      '/cturma':(context) => Cturma(),
      '/WebQuestIntroductionView':(context) => WebQuestIntroductionView(),
      '/WebQuestTaskView':(context) => WebQuestTaskView(),
      '/WebQuestProcessView':(context) => WebQuestProcessView(),
      '/WebQuestInformationView':(context) => WebQuestInformationView(),
      '/WebQuestEvaluationView':(context) => WebQuestEvaluationView(),
      '/WebQuestConclusionView':(context) => WebQuestConclusionView(),
      '/WebQuestReferencesView':(context) => WebQuestReferencesView(),
      '/WebBasicInfoManage':(context) => WebBasicInfoManage(),
      '/WebQuestIntroductionManage':(context) => WebQuestIntroductionManage(),
      '/WebQuestTaskManage':(context) => WebQuestTaskManage(),
      '/WebQuestProcessManage':(context) => WebQuestProcessManage(),
      '/WebQuestInformationManage':(context) => WebQuestInformationManage(),
      '/WebQuestEvaluationManage':(context) => WebQuestEvaluationManage(),
      '/WebQuestConclusionManage':(context) => WebQuestConclusionManage(),
      '/WebQuestReferencesManage':(context) => WebQuestReferencesManage(),
     },
    );
    
  }
}