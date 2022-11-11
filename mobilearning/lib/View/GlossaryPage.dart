// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, file_names, import_of_legacy_library_into_null_safe, unused_import

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobilearning/Models/glossaryWordModel.dart';
import 'package:mobilearning/Widgets/GlossaryList.dart';
import 'package:http/http.dart';
import 'dart:async';

class GlossaryPage extends StatefulWidget {
  const GlossaryPage({
    Key? key,
  }) : super(key: key);

  @override
  State<GlossaryPage> createState() => _GlossaryPageState();
}
 
Future<List<GlossaryWord>> getWords(BuildContext? context) async {
  try {
    Options opt = Options();

    String token= await SessionManager().get("BearerToken");

    if(token != '')
    {
      opt.headers = {"authorization": "bearer $token"};
    var response = await Dio().get('https://mobilearning-api.herokuapp.com/word', options: opt);
    List<GlossaryWord> words = [];

    if (response.statusCode == 200) 
      {
        List<dynamic> body = jsonDecode(response.data);

        for (var element in body) 
        {
          words.add(GlossaryWord.fromJson(element));
        }

        return words;
      }
      else
      {
         await SessionManager().destroy();
          Navigator.pushNamed(context!, '/login');
      }
    }
  } catch (e) {
    print(e);
    List<GlossaryWord> words = [];
    return words;
  }
  
    List<GlossaryWord> words = [];
    return words;
  

}


class _GlossaryPageState extends State<GlossaryPage> {
  
 //Lista de palavras que aparece na tela 
 List<GlossaryWord> words  = [];

_GlossaryPageState()
{
  getWordsList('', null);
}


//Método que busca a lista de palavras da memória, caso não exista busca do banco
void getWordsList (String key, BuildContext? context )async
{
  //Verifica se a lista existe na sessão
  bool containWords = await SessionManager().containsKey("Words");
  if(containWords)
  {
    //limpa a lista da tela
    words = [];
    dynamic res = await SessionManager().get("Words");
    
    //verifica se há resultado
    if(res != null && res != '')
    {
      //preenche a lista da tela com o elemento da memória
      for (var element in res) 
      {
        words.add(GlossaryWord.fromJson(element));
      }
    }
    
  }
  else
  {
    //Caso a lista não exista em memória consulta o banco de dados
    var listwords = await getWords(context);
    String jsonEncodeWords = jsonEncode(listwords);

    //adiciona a lista em memória
    var sessionManager = SessionManager();
    await sessionManager.set('Words', jsonEncodeWords);
    words = listwords;
  }

  //Lista temporária que preenchera a tela
  List<GlossaryWord>  results = [];

  // Se o Campo de texto está em branco ou com apenas espaços exibe todos os registros
  if (key.isEmpty) {
    results = words;
  }
  else {
  results = words;
  // Preenche a nova lista de resultados apenas com os nomes que possuem o texto procurado
  results = results.where((word) => word.englishWord.toLowerCase().contains(key.toLowerCase())).toList();
  }
    //atualiza a interface gráfica
    if(mounted)
    setState(() {
      words = results;
    });
 
}


  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(20),
    child: Column(
      children: [const SizedBox(
        height: 20,
      ),
      
      TextField(onChanged: (value) => getWordsList(value,context),
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
                      // Icon(Icons.add,color: Colors.white,) 
                    ],)
                    ),
                  ),
                ),
                onTap: (){
                 
                  Navigator.of(context).pushNamed('/cword');
                }

                  
                  // setState((){
                  //   Navigator.pushNamed(context, "/cword");
                  // })

                
                ),

      const SizedBox(height: 20,),

      Expanded(
          child:  ListView.builder(
                itemCount: words.length,
                itemBuilder: (context,index)=>
                  words.isNotEmpty?

                    GlossaryList(
                      id: words[index].id,
                      userId: words[index].userId,
                      englishWord: words[index].englishWord,
                      englishDefinition: words[index].englishDefinition,
                      portugueseWord: words[index].portugueseWord,
                      portugueseDefinition: words[index].portugueseDefinition, 
                      
                    )

                  
                :
      const Text("No words found")
    ),
    )
      ]
        )
        );

    
  
  }
}