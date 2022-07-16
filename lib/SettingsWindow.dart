// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables, prefer_const_literals_to_create_immutables, unnecessary_new, unnecessary_const, prefer_final_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:live_chat_2_0/chatpage.dart';

class SettingWindow extends StatelessWidget {

  final email;


  const SettingWindow({Key? key, this.email}) : super(key: key);




  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("Users")
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              return Scaffold(
                  resizeToAvoidBottomInset: false,
                  appBar: AppBar(
                    title: Text(
                      "Тех поддержка",
                      style: TextStyle(color: Colors.black),
                    ),
                    centerTitle: true,
                    backgroundColor: Colors.white,
                    iconTheme: IconThemeData(color: Colors.blueGrey),
                  ),
                  body: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("Users")
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return Center(child: CircularProgressIndicator());
                        }
                        return SingleChildScrollView(
                            child:
                            Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 490,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: snapshot.data!.size,
                                      itemBuilder:
                                          (BuildContext context, int index) {


                                        return Dismissible(
                                          key: Key(snapshot.data!.docs[index].id),
                                          child: Card(
                                            child: ListTile(
                                              title: Text(
                                                snapshot.data!.docs[index]
                                                    .get('email'),
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16),
                                              ),
                                              subtitle: Text("sub"),
                                              trailing: IconButton(
                                                icon: Icon(Icons.arrow_forward_ios_rounded),
                                                onPressed: () {
                                                  Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) => chatPage(
                                                            email: snapshot.data!.docs[index].get('email'),
                                                          )));
                                                },
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                ),

                              ],
                            ));
                      }));
            }));
  }
}
