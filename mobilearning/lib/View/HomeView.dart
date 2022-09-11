// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobilearning/View/ActivityPage.dart';
import 'package:mobilearning/View/ChatPage.dart';
import 'package:mobilearning/View/loginView.dart';

import 'GlossaryPage.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {

    //páginas do bottomNavbar
    final tabPages = <Widget>[
       Center(child: ChatPage()),
       Center(child: ActivityPage()),
       Center(child: GlossaryPage())
    ];

    //Icones do bottomNavbar
    final bottomNavBarItems = <BottomNavigationBarItem>[
      const BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Chat'),
      const BottomNavigationBarItem(icon: Icon(Icons.task), label: 'Activities'),
      const BottomNavigationBarItem(icon: Icon(Icons.window), label: 'Glossary'),
    ];

    assert(tabPages.length ==bottomNavBarItems.length);

    final bottomNavBar = BottomNavigationBar(
      elevation: 0,
      backgroundColor:  Color.fromRGBO(21,93,177,1),
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
      onTap: (int index){
        setState(() {
          currentTabIndex = index;
        });
      },);

   return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Color.fromRGBO(21,93,177,1)),
              accountName: Text('André',style: GoogleFonts.arvo(fontSize: 18),),
              accountEmail: Text('andreluis2608@gmail.com',style: GoogleFonts.arvo(fontSize: 18),),
              currentAccountPicture: CircleAvatar(child: Text("SZ"),),
              ),
              ListTile(leading: Icon(Icons.person),
              title: Text("My account", style: GoogleFonts.arvo(fontSize: 16),),
              onTap: ()=>{
                  Navigator.pushNamed(context, '/login'),
              },),
              ListTile(leading: Icon(Icons.logout),
              title: Text('Logout', style: GoogleFonts.arvo(fontSize: 16)),
               onTap: ()=>{
                  Navigator.pushNamed(context, '/login'),
                  })
              
          ],
        ),
      ) ,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(21,93,177,1),
        title:  Text('English Mobilearning',style: GoogleFonts.arvo(fontSize: 22),),
        centerTitle: true,
        
        shape: const RoundedRectangleBorder(
    	borderRadius: BorderRadius.vertical(
    	bottom: Radius.circular(20),
    ),
  ),
      ),
      body: SafeArea(
      child:  IndexedStack( //manter as informações na pilha ao mudar de página
              index: currentTabIndex,
              children: tabPages,
            ),
      ),
    bottomNavigationBar: bottomNavBar, 
    );
  
  }
}
