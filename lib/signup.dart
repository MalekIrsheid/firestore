import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'crud.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: Column(
        children: [
          Padding(padding: EdgeInsets.all(20)),
          Text("Email"),
          TextField(
            controller: email,
          ),
          Divider(
            height: 10,
          ),
          Text("Password"),
          TextField(
            controller: password,
          ),
          ElevatedButton.icon(
              onPressed: () async {
                try {
                  var auth = FirebaseAuth.instance;
                  UserCredential myUser =
                      await auth.createUserWithEmailAndPassword(
                          email: email.text, password: password.text);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("email already used")));
                }
              },
              icon: Icon(Icons.app_registration),
              label: Text("Signup")),
          ElevatedButton.icon(
              onPressed: () async {
                try {
                  var auth = FirebaseAuth.instance;
                  UserCredential myUser = await auth.signInWithEmailAndPassword(
                      email: email.text, password: password.text);
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return CrudPage();
                    },
                  ));
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("You email/password incorret")));
                }
              },
              icon: Icon(Icons.login),
              label: Text("Login"))
        ],
      )),
    );
  }
}
