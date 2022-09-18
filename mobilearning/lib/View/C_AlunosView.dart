// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CAlunos extends StatefulWidget {
  const CAlunos({Key? key}) : super(key: key);

  @override
  State<CAlunos> createState() => _CAlunosState();
}

class _CAlunosState extends State<CAlunos> {
  @override
  Widget build(BuildContext context) {
    var alturaTela = MediaQuery.of(context).size.height;

    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: Color.fromRGBO(21, 93, 177, 1)),
              accountName: Text(
                'André',
                style: GoogleFonts.arvo(fontSize: 18),
              ),
              accountEmail: Text(
                'andreluis2608@gmail.com',
                style: GoogleFonts.arvo(fontSize: 18),
              ),
              currentAccountPicture: const CircleAvatar(
                child: Text("SZ"),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: Text(
                "My account",
                style: GoogleFonts.arvo(fontSize: 16),
              ),
              onTap: () => {
                Navigator.pushNamed(context, '/login'),
              },
            ),
            ListTile(
                leading: const Icon(Icons.logout),
                title: Text('Logout', style: GoogleFonts.arvo(fontSize: 16)),
                onTap: () => {
                      Navigator.pushNamed(context, '/login'),
                    })
          ],
        ),
      ),
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
            child: Column(
              children: <Widget>[
                Container(
                
                  margin:  EdgeInsets.only(top: alturaTela*0.2,right: 20,left: 20),
                  height: 50,
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
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Digite seu nome";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.name,
                    cursorColor: Colors.blue,
                    decoration: const InputDecoration(
                      hintText: 'Nome Completo',
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
                  height: 50,
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
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Digite um E-mail";
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
                  height: 50,
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
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Digite seu endereço: ";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.phone,
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
                  height: 50,
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
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Digite seu telefone";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.phone,
                    cursorColor: Colors.blue,
                    decoration: const InputDecoration(
                      hintText: 'Telefone Ex: (17) 98888-8888',
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
                  height: 50,
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
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Digite sua senha";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    cursorColor: Colors.blue,
                    decoration: const InputDecoration(
                      hintText: 'Senha',
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
                Container(
                  margin: const EdgeInsets.only(
                    top: 10,
                    right: 20,
                    left: 20,
                  ),
                  height: 50,
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
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Digite seu CPF: ";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.phone,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 50,
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
                          'Voltar',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),

                  Container(
                  height: 50,
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
                    onPressed: () {},
                    child: const Text(
                      'Confirmar',
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
