import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../models/auth_service.dart';

class questionPage extends StatefulWidget {
  @override
  _questionPageState createState() => _questionPageState();
}

FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;
Map map = Map<int, String>();
String textHolder = "deniyoruz";

class _questionPageState extends State<questionPage> {
  int sim = 0;
  Timer _timer;

  Timer _timer2;
  int _start = 10;

  void startTimer() {
    const oneSec = const Duration(seconds: 3);
    _timer2 = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  int count = 0;
  TextEditingController _groupNameController = TextEditingController();
  CollectionReference questions =
      FirebaseFirestore.instance.collection('questions');
  Map<String, int> qu = {"Simay": 2, "Ekici": 4};

  void questionsReturn() {
    const oneSec = const Duration(seconds:1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer _timer) => setState(
        () {
          //var rng = new Random();

          // sim = rng.nextInt(3);
          sim = sim + 1;

          if (sim ==9) {
            _timer.cancel();
          }
        },
      ),
    );
  }

  /* int counter = 0;
  Timer incrementCounterTimer;
  void increamentCounter() {
    Timer.periodic(Duration(seconds: 2), (timer) async {
      await setState(() {
        counter++;
      });
    });
  }*/

  @override
  void initState() {
    questionsReturn();
    startTimer();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _Auth = Provider.of<AuthServices>(context);
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final Stream<QuerySnapshot> _usersStream =
        FirebaseFirestore.instance.collection('questions').snapshots();
    List<String> myList = List<String>(10);
    myList[0] = "İç Anadolu Bölgesi’nde toplam kaç şehir vardır?";
    myList[1] = 'Dünyaya her gün ortalama kaç kere yıldırım düşmektedir?';
    myList[2] = "Ankara'da bulunan Gazi Üniversitesi kaç yılında kurulmuştur?";
    myList[3] = "CS:GO’da Negev kaç dolardır?";
    myList[4] = "Sakız çiğnemek kaç kalori yakar?";
    myList[5] = '5';
    myList[6] = '6';
    myList[7] = '7';
    myList[8] = '8';
    myList[9] = '9';

    List<String> list = List<String>();

    Map<String, dynamic> questions = new Map<String, dynamic>();

    Future<String> oku() async {
      debugPrint("giriyo mu");
      debugPrint(sim.toString());
      var val = await FirebaseFirestore.instance
          .collection('questions')
          .doc('1')
          .get()
          .then((result) => {
                result.data().forEach((key, value) {
                  debugPrint(key + "nerdesinnnnnnnn");
                  questions.addAll(value);
                })
              });
      // debugPrint(val.data().keys.first);
      debugPrint(questions.toString());

      //LinkedHashMap<String, dynamic> data = val['3'];

      /* List<dynamic> values = data.values.toList();
        List<dynamic> keys = data.keys.toList();
        debugPrint(values.toString());
        debugPrint(keys.toString());

        for (int i = 0; i < values.length; i++) {
          list.add(deneme);

        }*/
      return "success";
    }

    oku();

    return ChangeNotifierProvider(
        create: (_) => AuthServices(),
        child:Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          reverse: true,
          child: Column(children: [
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50.0),
                        topRight: Radius.circular(50.0),
                      ),
                      child: Container(
                        color: Colors.blueGrey.shade300,
                        height: 80,
                        width: 150,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: ClipOval(
                                child: Image.network(
                                  _auth.currentUser.photoURL,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 3.0,
                            ),
                            Expanded(
                                child: Text(
                              _auth.currentUser.displayName,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ))
                          ],
                        ),
                      )),
                  SizedBox(
                    width: 10.0,
                  ),
                  ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5.0),
                        topRight: Radius.circular(5.0),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blueGrey.shade300,
                        ),
                        height: 80,
                        width: 150,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(_start.toString(),
                                  style: TextStyle(
                                      fontSize: 36,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                              VerticalDivider(
                                color: Colors.white60,
                              ),
                              /*  TimeCircularCountdown(
                                diameter: 3,
                                unit: CountdownUnit.second,
                                countdownTotal: 30,
                                onUpdated: (unit, remainingTime) =>
                                    print('Updated'),
                                onFinished: () => print('Countdown finished'),
                              )*/
                            ],
                          ),
                        ),
                      ))
                ],
              ),
            ),
            Stack(children: [
              Center(
                  child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0),
                      ),
                      child: Container(
                        height: 300,
                        width: 300,
                        color: Colors.blueGrey.shade200,
                        child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10.0),
                              bottomRight: Radius.circular(10.0),
                            ),
                            child: Container(
                                height: 125,
                                width: 200,
                                decoration: BoxDecoration(
                                  color: Color(0xff009683),
                                  border:
                                      Border.all(color: Colors.white, width: 2),
                                ),
                                child: Center(
                                    child: Padding(
                                  padding: const EdgeInsets.all(28.0),
                                  child: StreamBuilder(
      stream: firestoreInstance.collection('GameRooms').doc("5q3YWF7BmSis6SWGDLMy").snapshots(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Text("Loading");
        }
        var userDocument = snapshot.data;
        return userDocument["members"].length<2 ? Text(myList[sim]) : SimpleDialog(
          children: [
            Text( "Diğerlerinin gelmesini bekliyoruz!")
          ],
        );
      }
  )
,)))
            )),
              /*  Padding(
                padding: const EdgeInsets.all(40.0),
                child: FloatingActionButton(

                  onPressed: (){
                    _timer.cancel();
                  },
                ),
              ),*/),),
              Padding(
                padding: const EdgeInsets.only(top: 260.0),
                child: Center(
                  child: Container(
                    width: 200,
                    height: 75,
                    child: new TextFormField(
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: new InputDecoration(
                        filled: true,
                        hoverColor: Colors.black,
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(),
                        ),
                      ),
                      style: new TextStyle(
                        fontFamily: "Poppins",
                      ),
                    ),
                  ),
                ),
              ),
            ])
          ]),
        )));
  }

  main() async {
    Duration interval = Duration(seconds: 2);
    Stream<String> stream = Stream<String>.periodic(interval, callback);
    await for (String i in stream) {
      print(i);
    }
  }

// This callback modify the given value to even number.
  String callback(int value) {
    List<String> myList = List<String>(3);
    myList[0] = 'simay';
    myList[1] = 'ekici';
    myList[2] = 'aa';
    for (String value in myList) {
      return value;
    }
    return "success";
  }
}
