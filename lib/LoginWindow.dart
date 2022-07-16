// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, unnecessary_new, prefer_final_fields, use_key_in_widget_constructors, must_be_immutable, sort_child_properties_last, unnecessary_const, file_names

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:live_chat_2_0/NavigatorBar.dart';
import 'package:live_chat_2_0/Services/auth.dart';
import 'package:live_chat_2_0/local_auth_api.dart';
import 'package:live_chat_2_0/user.dart';

class LoginWindow extends StatelessWidget {
  late String email;
  late String password;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown,
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 80.0, bottom: 90.0),
              child: Text(
                "LIVE:CHAT",
                style: TextStyle(
                    color: Colors.white,
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
                    borderSide:
                        const BorderSide(color: Colors.brown, width: 2.0),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    borderSide:
                        const BorderSide(color: Colors.black, width: 2.0),
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
                // onChanged: (loginText) {
                //     email = loginText;
                // },
                controller: _emailController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0, bottom: 15.0, left: 1.0),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    borderSide:
                        const BorderSide(color: Colors.brown, width: 2.0),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    borderSide:
                        const BorderSide(color: Colors.black, width: 2.0),
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
                // onChanged: (passwordText) {
                //   password = passwordText;
                // },
                controller: _passwordController,
              ),
            ),
            IconButton(onPressed: () async {
              final isAuthenticated = await LocalAuthApi.authenticate();
              if(isAuthenticated) {

                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NavigationClass(
                          email: "test@test.kg",
                        )));
              }
            },
                icon: Icon(Icons.fingerprint)),

            ElevatedButton(
              onPressed: () async {
                email = _emailController.text;
                password = _passwordController.text;

                if (email.isEmpty || password.isEmpty) return;

                Users? user = await _authService.signInWithEmailEndPassword(
                    email.trim(), password.trim());

                if (user == null) {
                  Fluttertoast.showToast(
                      msg: "Ошибка! Неправильно введен email/password",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                } else {
                  _emailController.clear();
                  _passwordController.clear();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NavigationClass(
                                email: email,
                              )));
                }
              },
              child: Text(
                "Войти",
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
            Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: TextButton(
                  child: Text("Не зарегистрированы? Зарегайтесь сейчас :) "),
                  onPressed: () {
                    Navigator.pushNamed(context, '/RegistrationWindow');
                  },
                )),
          ],
        ),
      ),
    );
  }
}
