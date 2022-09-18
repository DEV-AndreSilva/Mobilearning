// ignore_for_file: prefer_const_constructors, file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
        backgroundColor: Colors.grey[250],
        body: 
        SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //hello
                Image.asset('assets/images/IEI.png'),                
              
                Text(
                  "Bem vindo",
                  style: GoogleFonts.arvo(fontSize: 25, color: Color.fromARGB(255, 104, 104, 104)),
                  
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
                      borderRadius: BorderRadius.circular(12)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText:"E-mail"),
                          style: GoogleFonts.arvo(fontSize: 18),
                        
                      ),
                    ),
                  ),
                ),
                //password textfield
                SizedBox(height: 25,),
                                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText:"Senha"),
                          style: GoogleFonts.arvo(fontSize: 18),
                        
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                // sign in button
                GestureDetector(child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Container(
                   padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(21,93,177,1),
                      border: Border.all(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(child: Text("Entrar",
                    style: GoogleFonts.arvo(fontSize: 20, fontWeight: FontWeight.w400,color: Colors.white),) 
                    ),
                  ),
                ),
                onTap: ()=>{
                  setState((){
                    Navigator.pushNamed(context, "/home");
                  })
                },
                ),
                
              SizedBox(height: 5,),
              Column(
                children: [
                  Text("Esqueceu a senha", style: GoogleFonts.arvo(fontSize: 14, fontWeight: FontWeight.w400,color: Colors.blue,)),
                ],
              )
                //Recover Password button
              ],
            ),
          ),
        ));
  }
}
