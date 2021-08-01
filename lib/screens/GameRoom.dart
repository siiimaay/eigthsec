import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/auth_service.dart';

class GameRoom extends StatefulWidget {
  @override
  /* String roomID;
  GameRoom(this.roomID);*/
  _GameRoomState createState() => _GameRoomState(/*this.roomID*/);
}

class _GameRoomState extends State<GameRoom> {
  @override
  final FirebaseAuth _auth = FirebaseAuth.instance;
  /*String roomID;
  _GameRoomState(this.roomID);*/

  Widget build(BuildContext context) {
    final Auth = Provider.of<AuthServices>(context);

    return Scaffold(
        body: Column(children: [Center(child: Text(Auth.gameR.id))]));
  }
}
