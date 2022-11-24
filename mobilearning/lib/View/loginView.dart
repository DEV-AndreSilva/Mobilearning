// ignore_for_file: prefer_const_constructors, file_names, use_build_context_synchronously

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobilearning/Models/userModel.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passowordController = TextEditingController();

  void login(BuildContext context, String email, String password) async {
    try {
      var response = await Dio().post(
          'https://mobilearning-api.herokuapp.com/user/Login',
          data: {'email': email, 'password': password});
      List<dynamic> body = jsonDecode(response.data);

      int id = body[0]['id'];
      String userName = body[0]['name'];
      String userEmail = body[0]['email'];
      String userAddress = body[0]['address'];
      String usercpf = body[0]['cpf'];
      String userPhone = body[0]['phone'];
      String userPassword = body[0]['password'];
      String userType = body[0]['type'];

      User user = User(id: id, name: userName, email: userEmail, address: userAddress, cpf: usercpf, phone: userPhone, password: userPassword, type: userType);
      String token = body[1];

      String jsonEncodeUser = jsonEncode(user);
      var sessionManager = SessionManager();

      await sessionManager.set('UserLogin', jsonEncodeUser);
      await sessionManager.set('UserLoginID', id);
      await sessionManager.set('BearerToken', token);

      Navigator.pushNamed(context, '/home', arguments: user);
    } catch (e) {
      print('Erro ao realizar login');
     // print(e);
      emailController.clear();
      passowordController.clear();

      Fluttertoast.showToast(
          msg: 'Usuario e senha invalidos!',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
          webPosition: 'center');

      //  ToastContext toast = ToastContext();
      //  toast.init(context);

      // showToast("Usuário não cadastrado no sistema", duration: Toast.lengthLong);

    }
    //https://mobilearning-api.herokuapp.com/user/Login
  }

  @override
  Widget build(BuildContext context) {
    emailController.text ="maura@gmail.com";
    passowordController.text ="123456";

    return Scaffold(
        backgroundColor: Colors.grey[250],
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //hello
                Image.asset('assets/images/logo2.png',width: 180, height: 180,),

                Text(
                  "Bem vindo",
                  style: GoogleFonts.arvo(
                      fontSize: 25, color: Color.fromARGB(255, 104, 104, 104)),
                ),
                SizedBox(
                  height: 10,
                ),

                //email textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: "E-mail"),
                        style: GoogleFonts.arvo(fontSize: 18),
                      ),
                    ),
                  ),
                ),
                //password textfield
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        controller: passowordController,
                        obscureText: true,
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: "Senha"),
                        style: GoogleFonts.arvo(fontSize: 18),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                // sign in button
                GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(21, 93, 177, 1),
                        border: Border.all(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                          child: Text(
                        "Entrar",
                        style: GoogleFonts.arvo(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      )),
                    ),
                  ),
                  onTap: () => {
                    login(context, emailController.text,
                        passowordController.text),
                  },
                ),

                SizedBox(
                  height: 5,
                ),
                Column(
                  children: [
                    Text("Esqueceu a senha",
                        style: GoogleFonts.arvo(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.blue,
                        )),
                  ],
                )
                //Recover Password button
              ],
            ),
          ),
        ));
  }
}
