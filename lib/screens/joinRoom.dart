import 'package:eight_seconds/screens/questionPage.dart';
import 'package:eight_seconds/screens/waitingRoom.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'GameRoom.dart';
import '../models/auth_service.dart';

class JoinRoom extends StatefulWidget {
  @override
  _JoinRoomState createState() => _JoinRoomState();
}

class _JoinRoomState extends State<JoinRoom> {
  TextEditingController _groupIDController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final _Auth = Provider.of<AuthServices>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                TextFormField(
                  cursorColor: Colors.white,
                  controller: _groupIDController,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    hoverColor: Colors.white,
                    prefixIcon: Icon(
                      Icons.group,
                      color: Colors.white,
                    ),
                    hintText: "Davet Kodu",
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                // ignore: deprecated_member_use
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(45.0),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0.0, 0.75),
                        blurRadius: 10.0,
                        spreadRadius: 3.0,
                      )
                    ],
                  ),
                  child: RaisedButton(
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 80),
                        child: Text(
                          "KATIL",
                          style: TextStyle(
                            color: Color(0xff009683),
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                      onPressed: () async {
                      bool c = await _Auth.joinGroup(_groupIDController.text);
                      debugPrint(c.toString());
                     if( c ==true){debugPrint("buraya niye girdi ki");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChangeNotifierProvider(
                                create: (_) => AuthServices(),
                                child:WaitingRoom(_groupIDController.text)),
                          ),
                        );}
                        else{
                          debugPrint("yanlış kod");
                          SimpleDialog(children: [
                            Text("YANLIŞ")
                          ],);
                        }
                        

                      
                      
                     
                        

                        
                      }

                      //_Auth.createGroup(_groupNameController.text)

                      //createGroup(context, _groupNameController.text)
                      ),
                ),
              ],
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
