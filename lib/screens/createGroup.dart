
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eight_seconds/screens/joinRoom.dart';
import 'package:eight_seconds/screens/questionPage.dart';
import 'package:eight_seconds/screens/waitingRoom.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/auth_service.dart';

class CreateGroup extends StatefulWidget {
  @override
  _CreateGroupState createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  TextEditingController _groupNameController = TextEditingController();
  FirebaseAuth authUser = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final _Auth = Provider.of<AuthServices>(context);
    int count = 0;
    return ChangeNotifierProvider(
        create: (_) => AuthServices(),
        child:Scaffold(
      resizeToAvoidBottomInset: false, //new line
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: <Widget>[BackButton()],
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                Theme(
                  data: new ThemeData(
                    hintColor: Colors.white,
                    primaryColor: Colors.white,
                    primaryColorDark: Colors.white,
                  ),
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    controller: _groupNameController,
                    decoration: InputDecoration(
                      hintText: "Odana bir ad ver!",
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                RaisedButton(
                  
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 80),
                      child: Text(
                        "Oyuna basla!",
                        style: TextStyle(
                          color: const Color(0xff009683),
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    onPressed: () async{
                    
                      String id = await createGroup(_groupNameController.text);
                      debugPrint(id+"budur");
                      _Auth.addUser(authUser.currentUser.uid);
                      //debugPrint("bu dimi");                     
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WaitingRoom(id)
                        ),
                      );
                    }

                    //_Auth.createGroup(_groupNameController.text)

                    //createGroup(context, _groupNameController.text)
                    ),
              ],
            ),
          ),
          Spacer(),
        ],
      ),
    ));
  }
  final FirebaseAuth _auth = FirebaseAuth.instance;

   Future<String> createGroup(String groupName) async {
    String retVal = "";
    List<String> members = List();

    try {
     // members.add(_auth.currentUser.uid);

     // _docRef =  firestoreInstance.collection("GameRooms").doc(_docRef.id);

     DocumentReference _docRef = await firestoreInstance.collection("GameRooms").add({
        
        'leader': _auth.currentUser.uid,
        'roomName': groupName,
        'groupCreated': Timestamp.now(),
        
        
      });
       debugPrint(_docRef.id+" aslında olması gereken");
    //return retVall=_docRef.id.toString().toString();
      //    debugPrint(_docRef.id.toString()+"aslında olması gereken");

      //_gameR.id = _docRef.id;
      retVal = _docRef.id.toString();
    } catch (e) {
      print(e);
    }
    return retVal;

  }
}
