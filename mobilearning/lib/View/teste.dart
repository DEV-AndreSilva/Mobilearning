import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mobilearning/Models/glossaryWordModel.dart';


 Future<void> main()
 async {


try{
  
Options opt = Options();
opt.headers = {"authorization":"bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiMDcyM2U5NDQtYjk1ZC00OGFjLTkxZTEtYzJlODgxODA2MDgyIiwibmJmIjoxNjYzODczNjgzLCJleHAiOjE2NjM4OTE2ODMsImlhdCI6MTY2Mzg3MzY4M30.ngMXg7RQpBsB1FL-CVxqQZVf8Is0-MLvtD_uI90FxC0"};
var response = await Dio().get('https://mobilearning-api.herokuapp.com/word',options: opt);
List<GlossaryWord> words = [];

  if (response.statusCode == 200) {
    List<dynamic> body = jsonDecode(response.data);
   // print(body[0]['ID']);
    body.forEach((element) {
      

      words.add(GlossaryWord.fromJson(element));

      
      // print(element['ID']);
      // print(element['UserId']);
      // print(element['PortugueseWord']);
      // print(element['EnglishWord']);
      // print(element['PortugueseDefinition']);
      // print(element['EnglishDefinition']);
    });

    print(words.length);
  } 
 
}
catch( e)
{
  print(e);
}
  
 }