// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'View/App.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async 
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}
