
import 'package:eight_seconds/screens/questionPage.dart';
import 'package:eight_seconds/screens/waitingRoom.dart';
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
                    onPressed: () {
                    
                      _Auth.createGroup(_groupNameController.text);
                        


                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChangeNotifierProvider(
        create: (_) => AuthServices(),
        child: WaitingRoom(),
                        ),
                      ));
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
}
