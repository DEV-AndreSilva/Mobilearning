// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, file_names

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobilearning/View/UserActivityPage.dart';
import 'package:mobilearning/View/ActivityPage.dart';
import 'package:mobilearning/View/ChatPage.dart';
import 'package:mobilearning/View/ManagementPage.dart';
import 'package:mobilearning/Widgets/DrawerMobilearning.dart';

import 'GlossaryPage.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentTabIndex = 0;
  int userType = 1;
  int idUserLogin = 0;

  void returnTypeUser() async {
    var sessionManager = SessionManager();
    final dynamic args = ModalRoute.of(context)?.settings.arguments;

    try {
      if (args != null) {
        if (args.type != null) {
          userType = int.parse(args.type);
          await sessionManager.set('UserType', userType);
        }
      } else {
        bool containUserType = await SessionManager().containsKey("UserType");
        if (containUserType) {
          dynamic Type = await SessionManager().get("UserType");
          userType = int.parse(Type.toString());
        } else {
          await SessionManager().destroy();
          setState(() {
            Navigator.pushNamed(context, '/login');
          });
        }
      }
    } catch (ex) {}

    setState(() {
      
    });
  }

  void returnIDuser ()async
  {
     bool containUserLogin = await SessionManager().containsKey("UserLoginID");
        if (containUserLogin) 
        {
           dynamic id = await SessionManager().get("UserLoginID");
            idUserLogin = int.parse(id.toString());
        }
    setState(() {
      
    });
  }

 

  @override
  Widget build(BuildContext context) {
    returnTypeUser();
    returnIDuser();

    var tabPages = <Widget>[];
    var bottomNavBarItems = <BottomNavigationBarItem>[];

    //usuário aluno
    if (userType == 1) {
      //páginas do bottomNavbar
      tabPages = <Widget>[
        Center(child: ChatPage(idUserLogin: idUserLogin,)),
        Center(child: UserActivityPage()),
        Center(child: GlossaryPage()),
      ];

      //Icones do bottomNavbar
      bottomNavBarItems = <BottomNavigationBarItem>[
        const BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Chat'),
        const BottomNavigationBarItem(
            icon: Icon(Icons.task), label: 'Activities'),
        const BottomNavigationBarItem(
            icon: Icon(Icons.window), label: 'Glossary'),
      ];
    }
    //professor
    else if (userType == 2) {
      //páginas do bottomNavbar
      tabPages = <Widget>[
        Center(child: ManagmentPage()),
        Center(child: ChatPage(idUserLogin: idUserLogin,)),
        Center(child: ActivityPage()),
      ];

      //Icones do bottomNavbar
      bottomNavBarItems = <BottomNavigationBarItem>[
        const BottomNavigationBarItem(
            icon: Icon(Icons.settings_applications), label: 'Management'),
        const BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Chat'),
        const BottomNavigationBarItem(
            icon: Icon(Icons.task), label: 'Activities'),
      ];
    }

    assert(tabPages.length == bottomNavBarItems.length);

    final bottomNavBar = BottomNavigationBar(
      elevation: 0,
      backgroundColor: Color.fromRGBO(21, 93, 177, 1),
      unselectedItemColor: Colors.white,
      selectedItemColor: Colors.amberAccent,
      selectedFontSize: 17,
      unselectedFontSize: 15,
      selectedLabelStyle: GoogleFonts.arvo(),
      selectedIconTheme: IconThemeData(color: Colors.amberAccent, size: 30),
      unselectedIconTheme: IconThemeData(color: Colors.white, size: 25),
      showSelectedLabels: true,
      showUnselectedLabels: true,
      items: bottomNavBarItems,
      currentIndex: currentTabIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (int index) {
        setState(() {
          currentTabIndex = index;
        });
      },
    );

    return Scaffold(
      drawer: DrawerMobilearning(),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(21, 93, 177, 1),
        title: Text(
          'English Mobilearning',
          style: GoogleFonts.arvo(fontSize: 22),
        ),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      body: SafeArea(
        child: IndexedStack(
          //manter as informações na pilha ao mudar de página
          index: currentTabIndex,
          children: tabPages,
        ),
      ),
      bottomNavigationBar: bottomNavBar,
    );
  }
}
