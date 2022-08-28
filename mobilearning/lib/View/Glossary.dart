// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class Glossary extends StatefulWidget {
  const Glossary({
    Key? key,
  }) : super(key: key);

  @override
  State<Glossary> createState() => _GlossaryState();
}

class _GlossaryState extends State<Glossary> {

  //lista de dados completa
 final List<Map<String, dynamic>> users = [
    {"id": 1, "englishWord": "Book", "portugueseWord": "Livro", "englishDefinition":"Texts grouped into pages texts grouped into pages", "portugueseDefinition":"Textos agrupados em paginas"},
    {"id": 2, "englishWord": "Time ", "portugueseWord": "Tempo", "englishDefinition":"Texts grouped into pages", "portugueseDefinition":"Textos agrupados em paginas"},
    {"id": 3, "englishWord": "People", "portugueseWord": "Pessoas", "englishDefinition":"Texts grouped into pages", "portugueseDefinition":"Textos agrupados em paginas"},
    {"id": 4, "englishWord": "Way ", "portugueseWord": "Modo", "englishDefinition":"Texts grouped into pages", "portugueseDefinition":"Textos agrupados em paginas"},
    {"id": 5, "englishWord": "Water ", "portugueseWord": "Água", "englishDefinition":"Texts grouped into pages", "portugueseDefinition":"Textos agrupados em paginas"},
    {"id": 6, "englishWord": "Words ", "portugueseWord": "Palavras", "englishDefinition":"Texts grouped into pages", "portugueseDefinition":"Textos agrupados em paginas"},
    {"id": 7, "englishWord": "Man ", "portugueseWord": "Homem", "englishDefinition":"Texts grouped into pages", "portugueseDefinition":"Textos agrupados em paginas"},
    {"id": 8, "englishWord": "Work", "portugueseWord": "Trabalho", "englishDefinition":"Texts grouped into pages", "portugueseDefinition":"Textos agrupados em paginas"},
    {"id": 9, "englishWord": "Part  ", "portugueseWord": "Parte", "englishDefinition":"Texts grouped into pages", "portugueseDefinition":"Textos agrupados em paginas"},
    {"id": 10, "englishWord": "Place ", "portugueseWord": "Lugar", "englishDefinition":"Texts grouped into pages", "portugueseDefinition":"Textos agrupados em paginas"},
  ];

  // lista de dados que sera exibida
  List<Map<String, dynamic>> foundUsers = [];

  @override
  initState() {
    //No começo todos os dados serão exibidos
    foundUsers = users;
    super.initState();
  }


  // Função que é chamada quando o campo de texto muda
  void runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];

     // Se o Campo de texto está em branco ou com apenas espaços exibe todos os registros
    if (enteredKeyword.isEmpty) {
      results = users;
    }
     else {
      // Preenche a nova lista de resultados apenas com os nomes que possuem o texto procurado
      results = users.where((user) => user["englishWord"].toLowerCase().contains(enteredKeyword.toLowerCase())).toList();
    }

    // Refresh the UI
    setState(() {
      foundUsers = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(20),
    child: Column(
      children: [const SizedBox(
        height: 20,
      ),
      TextField(onChanged: (value) => runFilter(value),
        decoration: const InputDecoration(
        labelText: 'Search a word', suffixIcon: Icon(Icons.search) ),
      ),
      const SizedBox(height: 20,),
      Expanded(child: foundUsers.isNotEmpty?
              ListView.builder(
                itemCount: foundUsers.length,
                itemBuilder: (context,index)=> Card(
                  key: ValueKey(foundUsers[index]["id"]),
                  color: Color.fromRGBO(129,201,250,1),
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: ExpansionTile(
                    textColor: Colors.amberAccent,
                    title : Text('${foundUsers[index]["englishWord"]}',style: GoogleFonts.arvo(fontSize: 17,fontWeight: FontWeight.bold)),
                    subtitle: Text('${foundUsers[index]["portugueseWord"]}', style: GoogleFonts.arvo(fontSize: 17)),
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20,bottom: 10),
                        child: Column(
                          children: [

                            Padding(
                                    padding: const EdgeInsets.only(top: 10,bottom: 10),
                                    child: Column(
                                      children: [
                                        Text("English Definition:",
                                            style: GoogleFonts.arvo(fontSize: 17,fontWeight: FontWeight.bold)),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Flexible(child: Text(foundUsers[index]["englishDefinition"], style: GoogleFonts.arvo(fontSize: 16))),
                                          ],
                                          ),],
                                    ),
                              ),

                              Padding(
                                    padding: const EdgeInsets.only(top: 10,bottom: 10),
                                    child: Column(
                                      children: [
                                        Text("Portuguese Definition:",
                                            style: GoogleFonts.arvo(fontSize: 17,fontWeight: FontWeight.bold)),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Flexible(child: Text(foundUsers[index]["portugueseDefinition"], style: GoogleFonts.arvo(fontSize: 16))),
                                          ],
                                          ),],
                                    ),
                              ),
                            
                         
                          ],
                        ),
                      ),
                      
                    ],
                  )
                  ),
                  )
                :
      const Text("No words found")
      )
      ],
    
    ),
    );
  }
}