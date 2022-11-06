// ignore_for_file: file_names, import_of_legacy_library_into_null_safe, avoid_function_literals_in_foreach_calls

import 'package:extended_image/extended_image.dart';

class User {
  int id;
  String name;
  String email;
  String address;
  String cpf;
  String phone;
  String password;
  String type;

  User(
      {required this.id,
      required this.name,
      required this.email,
      required this.address,
      required this.cpf,
      required this.phone,
      required this.password,
      required this.type});

  factory User.fromJson(dynamic json) {
     print(json['id']);
    // print(json['Email']);
    // print(json['Name']);

    return User(
      id: json['id'],
      name: json['name'].toString(),
      email: json['email'].toString(),
      address: json['address'].toString(),
      cpf: json['cpf'].toString(),
      phone: json['phone'].toString(),
      password: json['password'].toString(),
      type: json['type'].toString(),
    );
  }

  Map toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'address':address,
        'cpf':cpf,
        'phone':phone,
        'password':password,
        'type':type,
      };
}
