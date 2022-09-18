import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:mobilearning/Models/glossaryWordModel.dart';
import '../webclient.dart';

class TransactionWebClient {
  final uri = Uri.parse('https://mobilearning-api.herokuapp.com/user/listUsers');
  String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiMzIxMTUwNmYtZmNmNi00ZDg5LTk3ZmYtMTE5YzM5YjUyNzIzIiwibmJmIjoxNjYzNTM5MTI4LCJleHAiOjE2NjM1NTcxMjgsImlhdCI6MTY2MzUzOTEyOH0.8RizX3vac9J8rAY7CCpulQ214dIvCJMhNHUZd9K-m9c";

  Future<List<GlossaryWord>> findAll() async {
    final Response response = await client.get(uri,
     headers: {
    HttpHeaders.authorizationHeader: 'Bearer $token',
  },
    );
    
    print(response);
    final List<dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson.map((dynamic item) => GlossaryWord.fromJson(item)).toList();
  }
}