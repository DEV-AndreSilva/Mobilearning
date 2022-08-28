// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'HomeView.dart';
import 'LoginView.dart';

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
     },
    );
    
  }
}