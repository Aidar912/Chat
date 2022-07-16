// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables, no_logic_in_create_state, file_names

import 'package:flutter/material.dart';
import 'package:live_chat_2_0/SettingsWindow.dart';
import 'package:live_chat_2_0/chatpage.dart';
import 'package:live_chat_2_0/messagePage.dart';


class NavigationClass extends StatefulWidget {
  late String email;
  NavigationClass({Key? key ,required this.email }) : super(key: key);

  @override
  State<NavigationClass> createState() => _HomePageState(email: email);
}

class _HomePageState extends State<NavigationClass> {
  late String email;
  int _selectedIndex = 0;

  _HomePageState({ required this.email});

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    final _pages = [
      MessagePage(email: email),
      SettingWindow(email: email,)
    ];
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _navigateBottomBar,
        type: BottomNavigationBarType.fixed,
        items: const [

          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Чат'),
          BottomNavigationBarItem(icon: Icon(Icons.admin_panel_settings), label: 'Админ'),

        ],
      ),
    );
  }
}