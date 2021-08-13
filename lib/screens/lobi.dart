import 'package:eight_seconds/screens/createGroup.dart';
import 'package:eight_seconds/screens/joinRoom.dart';
import 'package:eight_seconds/models/auth_service.dart';
import 'package:eight_seconds/screens/questionPage.dart';
import 'package:eight_seconds/screens/waitingRoom.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


final databaseReference = FirebaseDatabase.instance.reference();

class LobiPage extends StatefulWidget {
  @override
  _LobiPageState createState() => _LobiPageState();
}

class _LobiPageState extends State<LobiPage> {
  @override
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Widget build(BuildContext context) {
    final Auth = Provider.of<AuthServices>(context);
    return ChangeNotifierProvider(
        create: (_) => AuthServices(),
        child: Scaffold(
            resizeToAvoidBottomInset: false, //new line
            body: Column(
              children: [
                /*RaisedButton(
                  onPressed: () {
                    Auth.signOut();
                  },
                  child: Text("Çıkış "),
                  shape:
                      CircleBorder(side: BorderSide(color: Colors.transparent)),
                ),*/
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        child: Container(
                          width: 50,
                          height: 60,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 2),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.bar_chart, color: Colors.white),
                        ),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                  backgroundColor:
                                      Colors.black.withOpacity(0.07),
                                  elevation: 3.0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                  //   title: Text('İstatistikler'),
                                  content: Container(
                                      height: 300,
                                      width: 150,
                                      child: Text(
                                        'İstatistikler',
                                        style: TextStyle(color: Colors.white),
                                      )));
                              /* AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                                title: Text("Loading..."),
                                content: CircularProgressIndicator(),
                              );*/
                            },
                          );
                        },
                      ),
                      Center(
                        child: Container(
                          alignment: Alignment.center,
                          width: 100,
                          height: 120,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.amber, width: 2),
                            shape: BoxShape.circle,
                          ),
                          child: (() {
                            //  - - - > dart kodunun başladığı yer
                            if (Auth.misafir) {
                              return AspectRatio(
                                aspectRatio: 16 / 9,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100.0),
                                  child: Image(
                                    image: AssetImage('images/user_guest.png'),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              );
                            } else {
                              return InkWell(
                                // onTap: () {
                                //   Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //       builder: (context) =>
                                //           ChangeNotifierProvider(
                                //               create: (_) => AuthServices(),
                                //               child: questionPage()),
                                //     ),
                                //   );
                                // },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ClipOval(
                                    child: Image.network(
                                      _auth.currentUser.photoURL,
                                    ),
                                  ),
                                ),
                              );
                            }
                          }()),
                        ),
                      ),
                      InkWell(
                        child: Container(
                          width: 50,
                          height: 60,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 2),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.settings, color: Colors.white),
                        ),
                        onTap: () {
                          {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  elevation: 3.0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                  title: Text('Ayarlar'),
                                  content: Container(
                                    height: 30,
                                    width: 30,
                                    child: InkWell(
                                      child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            color: const Color(0xff009683),
                                          ),
                                          child: Center(
                                            child: Text("Çıkış yap",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          )),
                                      onTap: () {
                                        Auth.signOut();
                                      },
                                    ),
                                  ),
                                );
                                /* AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                                title: Text("Loading..."),
                                content: CircularProgressIndicator(),
                              );*/
                              },
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                    height: 300,
                    width: 300,
                    child: Image(
                        image: AssetImage("assets/images/kumsaati_logo.png"))),
                SizedBox(height: 20),
                // ignore: deprecated_member_use
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50.0),
                    bottomRight: Radius.circular(50.0),
                    topRight: Radius.circular(50.0),
                    bottomLeft: Radius.circular(50.0),
                  ),
                  child: Container(
                    height: 50,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.0),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0.0, 0.75),
                          blurRadius: 10.0,
                          spreadRadius: 10.0,
                        )
                      ],
                    ),
                    child: RaisedButton(
                      color: Colors.white,
                      child: Text(
                        "ODA OLUŞTUR  ",
                        style: TextStyle(
                            color: const Color(0xff009683), fontSize: 16.0),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChangeNotifierProvider(
                                create: (_) => AuthServices(),
                                child: CreateGroup()),
                          ),
                        );
                      },
                    ),
                  
                  )),
                SizedBox(height: 10),
                // ignore: deprecated_member_use
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50.0),
                    bottomRight: Radius.circular(50.0),
                    topRight: Radius.circular(50.0),
                    bottomLeft: Radius.circular(50.0),
                  ),
                  child: Container(
                    height: 50,
                    width: 130,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(45.0),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0.0, 0.25),
                          blurRadius: 10.0,
                        )
                      ],
                    ),
                    child: RaisedButton(
                      color: Colors.white,
                      child: Text(
                        "ODAYA KATIL",
                        style:
                            TextStyle(color: Color(0xff009683), fontSize: 15.0),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChangeNotifierProvider(
                                create: (_) => AuthServices(),
                                child: JoinRoom()),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            )));
  }
}
