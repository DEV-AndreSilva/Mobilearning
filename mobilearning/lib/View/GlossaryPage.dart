// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobilearning/Models/glossaryWordModel.dart';
import 'package:mobilearning/Widgets/GlossaryList.dart';


class GlossaryPage extends StatefulWidget {
  const GlossaryPage({
    Key? key,
  }) : super(key: key);

  @override
  State<GlossaryPage> createState() => _GlossaryPageState();
}

class _GlossaryPageState extends State<GlossaryPage> {

  //lista de dados completa
 List<GlossaryWord> words = [
   GlossaryWord (id: 1, englishWord: "Book", portugueseWord: "Livro", englishDefinition:"Texts grouped into pages texts grouped into pages", portugueseDefinition:"Textos agrupados em paginas"),
    GlossaryWord (id: 2, englishWord: "Time ", portugueseWord: "Tempo", englishDefinition:"Texts grouped into pages", portugueseDefinition:"Textos agrupados em paginas"),
    GlossaryWord (id: 3, englishWord: "People", portugueseWord: "Pessoas", englishDefinition:"Texts grouped into pages", portugueseDefinition:"Textos agrupados em paginas"),
    GlossaryWord (id: 4, englishWord: "Way ", portugueseWord: "Modo", englishDefinition:"Texts grouped into pages", portugueseDefinition:"Textos agrupados em paginas"),
    GlossaryWord (id: 5, englishWord: "Water ", portugueseWord: "Água", englishDefinition:"Texts grouped into pages", portugueseDefinition:"Textos agrupados em paginas"),
    GlossaryWord (id: 6, englishWord: "Words ", portugueseWord: "Palavras", englishDefinition:"Texts grouped into pages", portugueseDefinition:"Textos agrupados em paginas"),
    GlossaryWord (id: 7, englishWord: "Man ", portugueseWord: "Homem", englishDefinition:"Texts grouped into pages", portugueseDefinition:"Textos agrupados em paginas"),
    GlossaryWord (id: 8, englishWord: "Work", portugueseWord: "Trabalho", englishDefinition:"Texts grouped into pages", portugueseDefinition:"Textos agrupados em paginas"),
    GlossaryWord (id: 9, englishWord: "Part  ", portugueseWord: "Parte", englishDefinition:"Texts grouped into pages", portugueseDefinition:"Textos agrupados em paginas"),
    GlossaryWord (id: 10, englishWord: "Place ", portugueseWord: "Lugar", englishDefinition:"Texts grouped into pages", portugueseDefinition:"Textos agrupados em paginas"),
  ];

  // lista de dados que sera exibida
  List<GlossaryWord> foundWords = [];

  @override
  initState() {
    //No começo todos os dados serão exibidos
    foundWords = words;
    super.initState();
  }


  // Função que é chamada quando o campo de texto muda
  void runFilter(String enteredKeyword) {
    List<GlossaryWord>  results = [];

     // Se o Campo de texto está em branco ou com apenas espaços exibe todos os registros
    if (enteredKeyword.isEmpty) {
      results = words;
    }
     else {
      // Preenche a nova lista de resultados apenas com os nomes que possuem o texto procurado
      results = words.where((word) => word.englishWord.toLowerCase().contains(enteredKeyword.toLowerCase())).toList();
    }

    // Refresh the UI
    setState(() {
      foundWords = results;
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

        GestureDetector(child: Padding(
                  padding: const EdgeInsets.only( left: 75.0, right: 75.0, top: 10.0, bottom: 0.0),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(21,93,177,1),
                      border: Border.all(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      Text("Add new Word",style: GoogleFonts.arvo(fontSize: 18, fontWeight: FontWeight.w400,color: Colors.white),),
                      Icon(Icons.add,color: Colors.white,) 
                    ],)
                    ),
                  ),
                ),
                onTap: ()=>{
                  setState((){
                    Navigator.pushNamed(context, "/home");
                  })
                },
                ),

      const SizedBox(height: 20,),

      Expanded(child: foundWords.isNotEmpty?
              ListView.builder(
                itemCount: foundWords.length,
                itemBuilder: (context,index)=>

                    GlossaryList(
                      id: foundWords[index].id,
                      englishWord: foundWords[index].englishWord,
                      englishDefinition: foundWords[index].englishDefinition,
                      portugueseWord: foundWords[index].portugueseWord,
                      portugueseDefinition: foundWords[index].portugueseDefinition,
                    )

                  )
                :
      const Text("No words found")
      )
      ],
    
    ),
    );
  }
}