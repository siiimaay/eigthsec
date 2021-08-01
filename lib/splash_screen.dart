import 'package:eight_seconds/screens/PageLogin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/auth_service.dart';
import 'screens/lobi.dart';

class SPage extends StatefulWidget {
  @override
  _SPageState createState() => _SPageState();
}

class _SPageState extends State<SPage> {
  @override
  Widget build(BuildContext context) {
    final _Auth = Provider.of<AuthServices>(context);

    switch (_Auth.durum) {
      case UserStat.signedUser:
        return LobiPage();
      case UserStat.NotSignedUser:
        return PageLogin();

      case UserStat.SignedProccess:
        return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      body: Center(
          child: RaisedButton(
        child: Text("Burasi landing ekranı ",
            style: TextStyle(fontWeight: FontWeight.bold)),
        onPressed: () {},
      )),
    );
  }
}
