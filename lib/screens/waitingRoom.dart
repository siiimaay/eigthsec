import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eight_seconds/models/auth_service.dart';
import 'package:eight_seconds/screens/questionPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WaitingRoom extends StatefulWidget {
  const WaitingRoom({ key }) : super(key: key);

  @override
  _WaitingRoomState createState() => _WaitingRoomState();
}

class _WaitingRoomState extends State<WaitingRoom> {
  FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;
    final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return  ChangeNotifierProvider(
        create: (_) => AuthServices(),
        child:Scaffold(
      body: StreamBuilder(
      stream: firestoreInstance.collection('GameRooms').doc("5q3YWF7BmSis6SWGDLMy").snapshots(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
    if (!snapshot.hasData) {
      return Text("Loading");
    }
    var userDocument = snapshot.data;
    return userDocument["members"].length==3 ?   Future.delayed(const Duration(milliseconds: 500), () {
 Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => questionPage()),
          (route) => false); })  : SimpleDialog(
      children: [
        Text( "Diğerlerinin gelmesini bekliyoruz!")
      ],
    );
      }
  )/*Column(
    mainAxisAlignment: MainAxisAlignment.center,
      children: [
    Center(
      child: ClipRRect(
        child: Container(
          height: 100,
          width: 100,
          color:Colors.lime,child:Text("buraya odanın kodu gelecek!") ,),
      ),
    ),

    Container(child:
      ElevatedButton(
        onPressed: (){
          firestoreInstance.collection("GameRooms").doc("BQ82zpG29Ecg8rmdOzCx").set({
            _auth.currentUser.uid: true,
  },SetOptions(merge:true)).then((_) {
    print("success!");
  });
        },
        child: Text("READY"),
      )
    ),
      ],
    ),*/
    ));
  }
}