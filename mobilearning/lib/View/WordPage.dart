// ignore_for_file: prefer_const_constructors, file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
    
class WordPage extends StatefulWidget {
  const WordPage({Key? key}) : super(key: key);

  @override
  State<WordPage> createState() => _WordPageState();
}

class _WordPageState extends State<WordPage> {
  @override
  Widget build(BuildContext context) {
    var alturaTela = MediaQuery.of(context).size.height;

    TextEditingController englishWord = TextEditingController();
    TextEditingController portugueseWord = TextEditingController();
    TextEditingController englishDefinition = TextEditingController();
    TextEditingController portugueseDefinition = TextEditingController();

    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration:
                  const BoxDecoration(color: Color.fromRGBO(21, 93, 177, 1)),
              accountName: Text(
                'André',
                style: GoogleFonts.arvo(fontSize: 18),
              ),
              accountEmail: Text(
                'andreluis2608@gmail.com',
                style: GoogleFonts.arvo(fontSize: 18),
              ),
              currentAccountPicture: const CircleAvatar(
                child: Text("SZ"),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: Text(
                "My account",
                style: GoogleFonts.arvo(fontSize: 16),
              ),
              onTap: () => {
                Navigator.pushNamed(context, '/login'),
              },
            ),
            ListTile(
                leading: const Icon(Icons.logout),
                title: Text('Logout', style: GoogleFonts.arvo(fontSize: 16)),
                onTap: () => {
                      Navigator.pushNamed(context, '/login'),
                    })
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(21, 93, 177, 1),
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
      body: ListView(
        children: [
          Form(
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                      top: alturaTela * 0.2, right: 20, left: 20),
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 3,
                      ),
                    ],
                  ),
                  child: TextFormField(
                    controller: englishWord,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Write the new english word";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    cursorColor: Colors.blue,
                    decoration: const InputDecoration(
                      hintText: 'Write the new english word',
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.blue,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: 10,
                    right: 20,
                    left: 20,
                  ),
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 3,
                      ),
                    ],
                  ),
                  child: TextFormField(
                    controller: portugueseWord,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Write the new portuguese word";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    cursorColor: Colors.blue,
                    decoration: const InputDecoration(
                      hintText: 'Write the new portuguese word',
                      prefixIcon: Icon(
                        Icons.alternate_email,
                        color: Colors.blue,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                    ),
                  ),
                ),
                  Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(20),
                    margin: const EdgeInsets.only(
                    top: 10,
                    right: 20,
                    left: 20,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 3,
                      ),
                    ],
                  ),
                  child: Column(children: [
                    TextField(
                      controller: englishDefinition,
                      decoration: InputDecoration(
                        hintText: "Write the english Definition",
                        border: InputBorder.none,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 1, color: Colors.blue)
                         )
                      
                      ),
                      keyboardType: TextInputType.multiline,
                      maxLines: 4,
                      
                    ),
                  ]),
                ),

                 Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(20),
                    margin: const EdgeInsets.only(
                    top: 10,
                    right: 20,
                    left: 20,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 3,
                      ),
                    ],
                  ),
                  child: Column(children: [
                    TextField(
                      controller: portugueseDefinition,
                  
                      decoration: InputDecoration(
                        hintText: "Write the portuguese Definition",
                        border: InputBorder.none,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 1, color: Colors.blue)
                         )
                      
                      ),
                      keyboardType: TextInputType.multiline,
                      maxLines: 4,
                      
                    ),
                  ]),
                ),
             
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 50,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 25,
                      ),
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            Navigator.pop(context);
                          });
                        },
                        child: const Text(
                          'Voltar',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 25,
                      ),
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Confirmar',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
