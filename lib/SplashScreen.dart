import 'package:live_chat_2_0/LoginWindow.dart';

import 'main.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _navigatetohome();
  }

  _navigatetohome() async {
    await Future.delayed(Duration(milliseconds: 1900), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginWindow()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
              child: Image.asset('assets/picture/logo.png',width: 200,height: 200,),
            )
        )
    );
  }
}