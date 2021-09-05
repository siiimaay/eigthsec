import 'package:eight_seconds/models/GameRooms.dart';
import 'package:eight_seconds/models/auth_service.dart';
import 'package:eight_seconds/screens/questionPage.dart';
import 'package:eight_seconds/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => AuthServices(),
        child:MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(scaffoldBackgroundColor: Color(0xff009683)),
      home: App(),
    ));
  }
}

class App extends StatelessWidget {
  // Create the initialization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Scaffold(
              body: Center(child: Text("Hata" + snapshot.error.toString())));
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return ChangeNotifierProvider(
              create: (_) => AuthServices(), child: SPage());
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Scaffold(
            body: Center(child: Image.network('https://www.hareketligifler.net/data/media/1261/kum-saati-hareketli-resim-0007.gif')));
      },
    );
  }
}
