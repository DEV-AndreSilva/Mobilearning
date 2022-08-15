// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'loginView.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    debugShowCheckedModeBanner: false,
     initialRoute: '/login' ,
     routes: {
      '/login' :(context)=> Login(),
     },
    );
    
  }
}