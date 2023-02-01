import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todolist/forms/register.dart';
import 'package:todolist/todoApp.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool isLoading = false;
  bool isLogged = false;

  login() async {
    try {
      isLoading = true;
      setState(() {});
      var result = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text, password: password.text);

      isLogged = true;
      setState(() {});
    } catch (e) {
      log(e.toString());
    }
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Login'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 25,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: email,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter E-mail",
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: password,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter Password",
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              width: double.infinity,
              height: 65,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 175, 76, 116)),
                onPressed: () {
                  login();

                  if (isLogged != true) {
                    AlertDialog alert = AlertDialog(
                      title: Text("Wrong email or password"),
                      content: Text(
                          "please try again with correct email and password."),
                    );

                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return alert;
                      },
                    );
                  } else {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => ToDoApp()));
                    // set up the AlertDialog

                  }
                },
                child: isLoading
                    ? CircularProgressIndicator(
                        backgroundColor: Colors.white,
                      )
                    : const Text('Login'),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              width: double.infinity,
              height: 65,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => Register()));
                },
                child: const Text('Register'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
