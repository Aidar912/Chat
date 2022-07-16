import 'package:flutter/material.dart';
import 'package:live_chat_2_0/chatpage.dart';
import 'package:live_chat_2_0/SplashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'RegistrationWindow.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "SkyNet",
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => Splash(),
        // '/ChatWindow' : (context) => chatpage(email: email),
        '/RegistrationWindow' : (context) => RegistrationWindow(),
      },
    );
  }
}