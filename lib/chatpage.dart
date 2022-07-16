// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables, prefer_const_literals_to_create_immutables, unnecessary_new, unnecessary_const, prefer_final_fields, camel_case_types, prefer_interpolation_to_compose_strings, unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:live_chat_2_0/SettingsWindow.dart';

class chatPage extends StatelessWidget {
  final email;

  const chatPage({Key? key, this.email}) : super(key: key);

  static TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection(email)
                .orderBy('date', descending: false)
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
                    leading: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SettingWindow()));
                      },
                    ),
                  ),
                  body: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection(email)
                          .orderBy('date', descending: true)
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return Center(child: CircularProgressIndicator());
                        }
                        return SingleChildScrollView(
                            child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5.0),
                              child: SizedBox(
                                height: (MediaQuery.of(context).size.height -
                                    MediaQuery.of(context).size.height / 3.5),
                                child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    reverse: true,
                                    itemCount: snapshot.data!.size,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      QueryDocumentSnapshot qs =
                                          snapshot.data!.docs[index];
                                      Timestamp t = qs['date'];
                                      DateTime d = t.toDate();

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
                                            subtitle: Column(
                                              children: [
                                                Center(
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        bottom: 10),
                                                    // Количество лайков

                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          snapshot
                                                              .data!.docs[index]
                                                              .get('message')
                                                              .toString(),
                                                          overflow:
                                                              TextOverflow.clip,
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 22,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            trailing: Text(
                                              d.hour.toString() +
                                                  ":" +
                                                  d.minute.toString(),
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 15,
                                  width: MediaQuery.of(context).size.width - 50,
                                  child: TextField(
                                    decoration: InputDecoration(
                                      focusedBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15.0)),
                                        borderSide: const BorderSide(
                                            color: Colors.brown, width: 2.0),
                                      ),
                                      enabledBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15.0)),
                                        borderSide: const BorderSide(
                                            color: Colors.black, width: 2.0),
                                      ),
                                      border: OutlineInputBorder(),
                                      labelText: "Message",
                                      labelStyle: new TextStyle(
                                          color: Colors.blueGrey,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold),
                                      fillColor: Colors.white,
                                      filled: true,
                                    ),
                                    controller: _messageController,
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      if (_messageController.text == null ||
                                          _messageController.text == "") {
                                      } else {
                                        FirebaseFirestore.instance
                                            .collection(email)
                                            .add({
                                          'date': DateTime.now(),
                                          'email': "BOT",
                                          'message': _messageController.text,
                                        });
                                      }
                                      _messageController.clear();
                                    },
                                    icon: Icon(Icons.send)),
                              ],
                            ),
                          ],
                        ));
                      }));
            }));
  }
}
