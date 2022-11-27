// ignore_for_file: file_names

import 'dart:convert';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobilearning/Models/chatUsersModel.dart';

import '../Widgets/DrawerMobilearning.dart';

class CProfessores extends StatefulWidget {
  const CProfessores({Key? key}) : super(key: key);

  @override
  State<CProfessores> createState() => _CProfessoresState();
}

class _CProfessoresState extends State<CProfessores> {
  final nomeController = TextEditingController();
  final emailController = TextEditingController();
  final cpfController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final graduationController = TextEditingController();

  // Initial Selected Value
  String dropdownvalue = 'Graduate student';

  // List of items in our dropdown menu
  var items = ['Graduate student', 'Master’s program', 'PHD'];

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    void CadastrarProfessor(
        String nome,
        String email,
        String cpf,
        String address,
        String phone,
        String password,
        String graduation) async {
      try {
        Options opt = Options();
        String token = await SessionManager().get("BearerToken");

        if (graduation == "") graduation = "Graduate student";

        if (token != null && token != '') {
          opt.headers = {"authorization": "bearer $token"};
          var response = await Dio()
              .post('https://mobilearning-api.herokuapp.com/teacher/create',
                  data: {
                    'graduation': graduation.toString(),
                    'user': {
                      "name": nome,
                      "email": email,
                      "address": address,
                      "cpf": cpf,
                      "phone": phone,
                      "password": password,
                      "type": "2"
                    }
                  },
                  options: opt);

          if (response.statusCode == 200) {
            var responseId = jsonDecode(response.data);
            var userID = responseId['idUser'];

            ChatUsers usuario = ChatUsers(
                imageURL:
                    "https://th.bing.com/th/id/OIP.NIjCKgHbDTjdTPDD6oLuRgHaHa?pid=ImgDet&rs=1",
                messageText: "hello",
                name: nomeController.text,
                time: DateTime.now(),
                userUid: userID);

            var docUser = FirebaseFirestore.instance
                .collection("Users")
                .doc(userID.toString());
            await docUser.set(usuario.toJson());

            nomeController.clear();
            emailController.clear();
            cpfController.clear();
            addressController.clear();
            phoneController.clear();
            passwordController.clear();
            graduationController.clear();

            Fluttertoast.showToast(
                msg: 'Professor successfully registered!',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 3,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0,
                webPosition: 'center');
          }
        } else {
          await SessionManager().destroy();
          Navigator.pushNamed(context, '/login');
        }
      } catch (e) {
        print(e);
        Fluttertoast.showToast(
            msg: 'Teacher already registered in the system',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
            webPosition: 'center');
      }
    }

    var alturaTela = MediaQuery.of(context).size.height;

    return Scaffold(
      drawer: DrawerMobilearning(),
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
            key: _formKey,
            child: Column(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(top: 20, bottom: 20),
                    child: Text('Create Teacher',
                        style: GoogleFonts.arvo(
                            fontSize: 22,
                            color: Color.fromARGB(255, 0, 0, 0)))),
                Container(
                  margin: EdgeInsets.only(right: 20, left: 20),
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
                    controller: nomeController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Write your name";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.name,
                    cursorColor: Colors.blue,
                    decoration: const InputDecoration(
                      hintText: 'Full name',
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
                    controller: emailController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Write an E-mail";
                      }
                      final validaEmail = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                      if (!validaEmail.hasMatch(value)) {
                        return "Write a valid e-mail ";
                      }

                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: Colors.blue,
                    decoration: const InputDecoration(
                      hintText: 'E-mail',
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
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(10, 0, 15, 0),
                          child: Icon(
                            Icons.featured_play_list_outlined,
                            color: Colors.blue,
                          ),
                        ),
                        Text(
                          "Graduation",
                          style:
                              TextStyle(color: Color.fromARGB(200, 53, 50, 50)),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                          child: DropdownButton(

                              // Initial Value
                              value: dropdownvalue,

                              // Down Arrow Icon
                              icon: const Icon(Icons.keyboard_arrow_down),

                              // Array list of items
                              items: items.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              // After selecting the desired option,it will
                              // change button value to selected value
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownvalue = newValue!;
                                  graduationController.text = newValue;
                                });
                              }),
                        ),
                      ],
                    )),
                Container(
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
                  child: TextFormField(
                    controller: cpfController,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CpfInputFormatter()
                    ],
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Write your CPF: ";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    cursorColor: Colors.blue,
                    decoration: const InputDecoration(
                      hintText: 'CPF',
                      prefixIcon: Icon(
                        Icons.featured_play_list_outlined,
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
                    controller: addressController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Write your address";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.streetAddress,
                    cursorColor: Colors.blue,
                    decoration: const InputDecoration(
                      hintText: 'Rua Machado de Assis 999',
                      prefixIcon: Icon(
                        Icons.home,
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
                    controller: phoneController,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      TelefoneInputFormatter(),
                    ],
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Write your phone";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.phone,
                    cursorColor: Colors.blue,
                    decoration: const InputDecoration(
                      hintText: 'Phone Ex: (17) 98888-8888',
                      prefixIcon: Icon(
                        Icons.phone,
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
                    controller: passwordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Write your password";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    cursorColor: Colors.blue,
                    decoration: const InputDecoration(
                      hintText: 'Password',
                      prefixIcon: Icon(
                        Icons.vpn_key,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 100,
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
                          'Return',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Container(
                      width: 100,
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
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            CadastrarProfessor(
                                nomeController.text,
                                emailController.text,
                                cpfController.text,
                                addressController.text,
                                phoneController.text,
                                passwordController.text,
                                graduationController.text);
                          }
                        },
                        child: const Text(
                          'Confirm',
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
