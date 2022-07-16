// ignore_for_file: prefer_const_constructors, unnecessary_new, unnecessary_const, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:live_chat_2_0/LoginWindow.dart';
import 'package:live_chat_2_0/user.dart';

import 'Services/auth.dart';

class RegistrationWindow extends StatelessWidget {
  String? email;
  String? password;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  AuthService _authService = AuthService();

  bool obsureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Зарегистрироваться",
            style: TextStyle(color: Colors.blueGrey),
          ),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.blueGrey),
        ),
        body: Center(
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(top: 30.0, bottom: 90.0),
                child: Text(
                  "Добро пожаловать! \n Создайте аккаунт)",
                  style: TextStyle(
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 15.0, left: 1.0),
                child: TextField(
                  decoration: InputDecoration(
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      borderSide: const BorderSide(color: Colors.brown, width: 2.0),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      borderSide: const BorderSide(color: Colors.black, width: 2.0),
                    ),
                    border: OutlineInputBorder(),
                    labelText: "Email",
                    labelStyle: new TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                    fillColor: Colors.white,
                    filled: true,
                    icon: Icon(
                      Icons.login,
                      color: Colors.white,
                    ),
                    helperText: "Email используется для входа в систему",
                  ),
                  controller: _emailController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 15.0, left: 1.0),
                child: TextField(
                  obscureText: obsureText,
                  decoration: InputDecoration(
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      borderSide: const BorderSide(color: Colors.brown, width: 2.0),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      borderSide: const BorderSide(color: Colors.black, width: 2.0),
                    ),
                    border: OutlineInputBorder(),
                    labelText: "Пароль",
                    labelStyle: new TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                    fillColor: Colors.white,
                    filled: true,
                    icon: Icon(
                      Icons.password,
                      color: Colors.white,
                    ),
                    helperText: "Пароль используется для входа в систему",
                  ),
                  controller: _passwordController,
                ),
              ),
              IconButton(onPressed: ()   {
                obsureText = false;
              }, icon: Icon(Icons.remove_red_eye_sharp)),

              ElevatedButton(
                onPressed: () async {
                  email = _emailController.text;
                  password = _passwordController.text;

                  if (email!.isEmpty || password!.isEmpty) return;

                  Users? user = await _authService.registerWithEmailEndPassword(
                      email!.trim(), password!.trim());

                  if (user == null) {
                    Fluttertoast.showToast(
                        msg: "Ошибка! Неправильно введен email/password!",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  } else {

                    FirebaseFirestore.instance.collection('Users').add({'email': _emailController.text });

                    _emailController.clear();
                    _passwordController.clear();

                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (context) => LoginWindow()));
                  }
                },
                child: Text(
                  "Зарегистрироваться",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0),
                ),
                style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: Colors.brown,
                    side: BorderSide(color: Colors.brown, width: 3.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(15.0))),
              ),
            ])));
  }
}
