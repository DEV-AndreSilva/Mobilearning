// ignore_for_file: file_names, import_of_legacy_library_into_null_safe, avoid_function_literals_in_foreach_calls


import 'package:mobilearning/Models/userModel.dart';

class Aluno {
  int id;
  String nivel;
  User user;


  Aluno(
      {
      required this.id,
      required this.user,
      required this.nivel
      });

  factory Aluno.fromJson(dynamic json) {
     print(json['id']);
     print(json['user']);

    return Aluno(
      id: json['id'],
      nivel: json['nivel'],
      user: User.fromJson(json['user'])
    );
  }

  Map toJson() => {
        'id': id,
        'user': user,
        'nivel':nivel
      };
}
