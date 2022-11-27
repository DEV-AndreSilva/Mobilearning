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
import 'package:mobilearning/Widgets/DrawerMobilearning.dart';

class CAlunos extends StatefulWidget {
  const CAlunos({Key? key}) : super(key: key);

  @override
  State<CAlunos> createState() {
    return _CAlunosState();
  }
}

class _CAlunosState extends State<CAlunos> {
  final nomeController = TextEditingController();
  final emailController = TextEditingController();
  final cpfController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final nivelController = TextEditingController();

  // Initial Selected Value
  String dropdownvalue = 'Basic';

  // List of items in our dropdown menu
  var items = ['Basic', 'Intermediate', 'Advanced'];

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    void CadastrarAluno(String nome, String email, String cpf, String address,
        String phone, String password, String nivel) async {
      try {
        Options opt = Options();
        String token = await SessionManager().get("BearerToken");

        if (token != '') {
          opt.headers = {"authorization": "bearer $token"};
          var response = await Dio().post(
              'https://mobilearning-api.herokuapp.com/student/create',
              data: {
                'nivel': nivel.toString() == "" ? "basic" : nivel.toString(),
                'user': {
                  "name": nome,
                  "email": email,
                  "address": address,
                  "cpf": cpf,
                  "phone": phone,
                  "password": password,
                  "type": "1"
                }
              },
              options: opt);

          if (response.statusCode == 200) {
            var responseId = jsonDecode(response.data);
            var userID = responseId['idUser'];

            ChatUsers usuario = ChatUsers(
                imageURL:
                    "https://th.bing.com/th/id/OIP.NIjCKgHbDTjdTPDD6oLuRgHaHa?pid=ImgDet&rs=1",
                name: nomeController.text,
                createTime: DateTime.now(),
                userUid: userID,
                lastLogin: DateTime.now(),
                status: "Offline"
                );

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
            nivelController.clear();

            Fluttertoast.showToast(
                msg: 'Successful registered student!',
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
            msg: 'Student already registered in the system',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
            webPosition: 'center');
      }
    }

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
                    child: Text('Create Student',
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
                          "Nivel",
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
                                  nivelController.text = newValue;
                                });
                              }),
                        ),
                      ],
                    )),
                //

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
                      hintText: 'Address',
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
                      TelefoneInputFormatter()
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
                            CadastrarAluno(
                                nomeController.text,
                                emailController.text,
                                cpfController.text,
                                addressController.text,
                                phoneController.text,
                                passwordController.text,
                                nivelController.text);
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
