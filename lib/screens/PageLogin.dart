import 'package:eight_seconds/models/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PageLogin extends StatefulWidget {
  @override
  _PageLoginState createState() => _PageLoginState();
}

class _PageLoginState extends State<PageLogin> {
  @override
  Widget build(BuildContext context) {
    final myAuth = Provider.of<AuthServices>(context);
    return ChangeNotifierProvider(
      create: (_) => new AuthServices(),
      child: Scaffold(
          body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Container(
                height: 350,
                width: 400,
                child: Image(
                    image: AssetImage("assets/images/kumsaati_logo.png"))),
          ),
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
              bottomLeft: Radius.circular(10.0),
            ),
            child: Container(
              height: 40,
              width: 200,
              decoration: BoxDecoration(
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
                color: Colors.red,
                child: Text(
                  "Google ile bağlan",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: myAuth.giris,
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 1,
                width: 100,
                color: Colors.black,
              ),
              SizedBox(
                width: 5,
              ),
              Text("veya"),
              SizedBox(
                width: 5,
              ),
              Container(
                height: 1,
                width: 100,
                color: Colors.black,
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
              bottomLeft: Radius.circular(10.0),
            ),
            child: Container(
              height: 40,
              width: 200,
              decoration: BoxDecoration(
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
                color: Colors.blue.shade700,
                child: Text(
                  "Facebook ile bağlan",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: myAuth.giris,
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
                bottomLeft: Radius.circular(10.0),
              ),
              child: Container(
                height: 40,
                width: 200,
                decoration: BoxDecoration(
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
                  child: Row(
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            "Misafir olarak gir",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.group, color: Colors.black)
                    ],
                  ),
                  onPressed: myAuth.misafirgiris,
                ),
              ))
        ],
      )),
    );
  }
}
