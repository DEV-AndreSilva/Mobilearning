import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:google_fonts/google_fonts.dart';

class DrawerMobilearning extends StatefulWidget {
  DrawerMobilearning({
    Key? key,
  }) : super(key: key);

  @override
  State<DrawerMobilearning> createState() => _DrawerMobilearningState();
}

class _DrawerMobilearningState extends State<DrawerMobilearning> {
  final nameUserController = TextEditingController();
  final emailUserController = TextEditingController();
  int? idUserLogin;

  void recuperaUsuarioLogado() async {
    bool containUser = await SessionManager().containsKey("UserLogin");
    if (containUser) {
      Map<String, dynamic> user = await SessionManager().get("UserLogin");

      setState(() {
        nameUserController.text = user['name'];
        emailUserController.text = user['email'];
      });
    }

    bool containUserLogin = await SessionManager().containsKey("UserLoginID");
    if (containUserLogin) {
      dynamic id = await SessionManager().get("UserLoginID");
      idUserLogin = int.parse(id.toString());
    }

  }

  @override
  Widget build(BuildContext context) {
    recuperaUsuarioLogado();

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Color.fromRGBO(21, 93, 177, 1)),
            accountName: Text(
              nameUserController.text,
              style: GoogleFonts.arvo(fontSize: 18),
            ),
            accountEmail: Text(
              emailUserController.text,
              style: GoogleFonts.arvo(fontSize: 18),
            ),
            currentAccountPicture: CircleAvatar(
              child: Text("SZ"),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text(
              "My account",
              style: GoogleFonts.arvo(fontSize: 16),
            ),
            onTap: () => {
              Navigator.pushNamed(context, '/login'),
            },
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text(
              "Home",
              style: GoogleFonts.arvo(fontSize: 16),
            ),
            onTap: () =>
                {Navigator.of(context).popUntil(ModalRoute.withName('/home'))},
          ),
          ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout', style: GoogleFonts.arvo(fontSize: 16)),
              onTap: () async {
                final docUser = FirebaseFirestore.instance
                    .collection("Users")
                    .doc(idUserLogin.toString());

                docUser.update({'status': 'Offline'});

                Navigator.of(context).popUntil(ModalRoute.withName('/login'));
                await SessionManager().destroy();
              }),
        ],
      ),
    );
  }
}
