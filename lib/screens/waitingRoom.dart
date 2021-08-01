
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eight_seconds/screens/questionPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/auth_service.dart';

class WaitingRoom extends StatefulWidget {
   String roomID;
   WaitingRoom(this.roomID, {Key key}): super(key: key);
  @override
  _WaitingRoomState createState() => _WaitingRoomState();
}

class _WaitingRoomState extends State<WaitingRoom> {
  TextEditingController _groupNameController = TextEditingController();
   
  @override
  Widget build(BuildContext context) {
    final _Auth = Provider.of<AuthServices>(context);
    int count = 0;
    return ChangeNotifierProvider(
        create: (_) => AuthServices(),
        child:Scaffold(
       
      body: StreamBuilder(
      stream: firestoreInstance.collection('GameRooms').doc("5q3YWF7BmSis6SWGDLMy").snapshots(),
       builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
     if (snapshot.hasData==false) {
      return Text("Loading");
    }
    var userDocument = snapshot.data;
     return userDocument["members"].length==3 ?  Center(child: Text(widget.roomID.toString().toString()))  : SimpleDialog(
      children: [
         Text( "Diğerlerinin gelmesini bekliyoruz!")
       ],
     );
       }
   )
));
  }
}
