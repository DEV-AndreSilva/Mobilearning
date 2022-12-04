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
import 'package:mobilearning/Models/userModel.dart';
import 'package:mobilearning/Widgets/DrawerMobilearning.dart';

class Perfil extends StatefulWidget {
  const Perfil({Key? key}) : super(key: key);

  @override
  State<Perfil> createState() {
    return _PerfilState();
  }
}

class _PerfilState extends State<Perfil> {
  final nomeController = TextEditingController();
  final emailController = TextEditingController();
  final cpfController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void getUserDataBase() async {
    bool containUserLogin = await SessionManager().containsKey("UserLogin");
    if (containUserLogin) {
      var userJson = await SessionManager().get("UserLogin");
      User user = User.fromJson(userJson);

      nomeController.text = user.name;
      emailController.text = user.email;
      cpfController.text = user.cpf;
      addressController.text = user.address;
      phoneController.text = user.phone;
      passwordController.text = user.password;
    }
  }

  void update() async {
    bool containUserLoginID = await SessionManager().containsKey("UserLoginID");
    bool containToken = await SessionManager().containsKey("BearerToken");
    bool containUserType = await SessionManager().containsKey("UserType");

    if (containToken && containUserLoginID && containUserType) {
      Options opt = Options();
      var token = await SessionManager().get("BearerToken");
      var userLoginID = await SessionManager().get("UserLoginID");
      var userType = await SessionManager().get("UserType");

      try {
        opt.headers = {"authorization": "bearer $token"};
        var response = await Dio()
            .put('https://mobilearning-api.herokuapp.com/user/UpdateUser',
                data: {
                  "id": userLoginID,
                  "name": nomeController.text,
                  "email": emailController.text,
                  "address": addressController.text,
                  "cpf": cpfController.text,
                  "phone": phoneController.text,
                  "password": passwordController.text,
                  "type": userType.toString()
                },
                options: opt);

        if (response.statusCode == 200) {
          Fluttertoast.showToast(
              msg: 'User updated with success!',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0,
              webPosition: 'center');

          //atualiza o nome do usuário no Firestore
          final docUser = FirebaseFirestore.instance
              .collection("Users")
              .doc(userLoginID.toString());
          docUser.update({'name': nomeController.text});

          //atualiza o registro em memória do usuário
          User user = User(
              id: userLoginID,
              name: nomeController.text,
              email: emailController.text,
              address: addressController.text,
              cpf: cpfController.text,
              phone: phoneController.text,
              password: passwordController.text,
              type: userType.toString());

          String jsonEncodeUser = jsonEncode(user);
          var sessionManager = SessionManager();
          sessionManager.remove('UserLogin');
          await sessionManager.set('UserLogin', jsonEncodeUser);

          setState(() {});
        }
      } catch (ex) {
        Fluttertoast.showToast(
            msg: 'Error updating user',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
            webPosition: 'center');
      }
    }
  }

  @override
  void initState() {
    getUserDataBase();

    // ignore: todo
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                    child: Text('My account',
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
                            update();
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
