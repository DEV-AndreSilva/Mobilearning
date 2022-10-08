// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mobilearning/View/WordPage.dart';
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
     },
    );
    
  }
}