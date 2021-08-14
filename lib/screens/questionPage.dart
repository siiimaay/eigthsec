import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../models/auth_service.dart';

class questionPage extends StatefulWidget {
  String roomID;
  questionPage(this.roomID, {Key key}) : super(key: key);
  @override
  _questionPageState createState() => _questionPageState();
}

int cntt = 0;
FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;
TextEditingController _answerController = TextEditingController();
final FirebaseAuth _auth = FirebaseAuth.instance;

class _questionPageState extends State<questionPage> {
  int sim = 0;
  Timer _timer;
  Timer _timer2;
  int _start = 8;
  var nestedkey = _auth.currentUser.uid;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);

    _timer2 = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 1) {
          setState(() {
            _start = 8;
            startTimer();
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

  // void checkAnswer(){
  //   //Textcontrollerdan geleni check et. varsa arttır
  //   if(_answerController.text ==3.toString())
  //   cnt++;
  //   setState(() {

  //   });

  // }

  int count = 0;
  List<String> memberList = new List<String>();
  CollectionReference questions =
      FirebaseFirestore.instance.collection('questions');
  Map<String, dynamic> membersID = new Map<String, dynamic>();
  Map<String, dynamic> membersActive = new Map<String, dynamic>();

 

  void questionsReturn() {
    const oneSec = const Duration(seconds: 8);
    _timer = new Timer.periodic(
      oneSec,
      (Timer _timer) => setState(
        () {
          //var rng = new Random();

          // sim = rng.nextInt(3);
          sim = sim + 1;
          //checkAnswer();

          if (sim == 3) {
            _timer.cancel();
          }
        },
      ),
    );
  }

  Map<String, dynamic> questions3 = new Map<String, dynamic>();
    Map<String, dynamic> questions4 = new Map<String, dynamic>();
    List<String> han = new List<String>();
 void members() {
    FirebaseFirestore.instance
        .collection("GameRooms")
        .doc("2pDzpmLy7nMX4LzTN6Tr")
        .get()
        .then((result) => {
              debugPrint(result["members"].toString()),
              membersID.addAll(result["members"]),
              memberList.addAll(membersID.keys),
            
              memberList.remove(_auth.currentUser.uid)
            });

    //debugPrint(_auth.currentUser.uid + " bu user");
  }
void mem() {
    FirebaseFirestore.instance
        .collection('GameRooms')
        .doc('2pDzpmLy7nMX4LzTN6Tr')
        .get()
        .then((result) => {
          debugPrint(result["members"].toString()+"bu da mı yok"),
              questions4.addAll(result["members"]),
              // debugPrint(questions4.toString()+"bbb"),
               questions4.remove(_auth.currentUser.uid)
                 
               
            });
           
    //   checkAnswer();
    // debugPrint(questions3.toString()+"as");
   setState(() {
     
   });
 //   debugPrint(questions4.toString()+"bbb");
//debugPrint(han.toString()+"sjadklsaş");

  }
  void oku() {
    FirebaseFirestore.instance
        .collection('questions')
        .doc('1')
        .get()
        .then((result) => {
              result.data().forEach((key, value) {
                questions3.addAll(value);
                
               
              })
            });
    //   checkAnswer();
                 //  debugPrint(_auth.currentUser.uid+"bu current");

    // debugPrint(questions3.toString()+"as");
    setState(() {});
  }

  @override
  void initState() {
    questionsReturn();
    // addListener(_answerController);

    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _Auth = Provider.of<AuthServices>(context);
    // ignore: deprecated_member_use
    List<int> rndm = List<int>(5);
    rndm[0] = 5;
    rndm[1] = 7;
    rndm[2] = 4;
    rndm[3] = 2;
    rndm[4] = 6;
    int skor = 1;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final Stream<QuerySnapshot> _usersStream =
        FirebaseFirestore.instance.collection('questions').snapshots();

    oku();
    members();
    mem();
    return ChangeNotifierProvider(
        create: (_) => AuthServices(),
        child: Scaffold(
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
                                    border: Border.all(
                                        color: Colors.white, width: 2),
                                  ),
                                  child: Center(
                                      child: Padding(
                                    padding: const EdgeInsets.all(28.0),
                                    child: StreamBuilder(
                                        stream: firestoreInstance
                                            .collection('GameRooms')
                                            .doc("2pDzpmLy7nMX4LzTN6Tr")
                                            .snapshots(),
                                        builder: (context,
                                            AsyncSnapshot<DocumentSnapshot>
                                                snapshot) {
                                          if (!snapshot.hasData) {
                                            return Text("Loading");
                                          }
                                          var userDocument = snapshot.data;
                                          //debugPrint( userDocument["members"][0]);
                                          debugPrint(userDocument["members"][
                                                  _auth.currentUser.uid
                                                      .toString()]
                                              .toString());

                                          return userDocument["members"][
                                                          questions4.keys
                                                              .elementAt(0)] ==
                                                      4 ||
                                                  userDocument["members"][
                                                          questions4.keys
                                                              .elementAt(1)] ==
                                                      4 ||   userDocument["members"][_auth.currentUser.uid] ==4
                                                          
                                                          
                                              ? Text("oyun bitti ")
                                              : SimpleDialog(
                                                  children: [
                                                    Text(
                                                        questions3.keys.elementAt(sim))
                                                  ],
                                                );
                                        }),
                                  ))))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 260.0),
                    child: Center(
                      child: Container(
                        width: 200,
                        height: 75,
                        child: new TextFormField(
                          controller: _answerController,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          onChanged: (val) {
                            val = _answerController.text.toString();
                            // debugPrint(val);
                          },
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
                  FloatingActionButton(onPressed: () {
                    var isim = _answerController.text;
                    debugPrint(isim.toString() + "bu mu");
                    _answerController.clear();
                    debugPrint(isim.toString());
                    debugPrint(_answerController.text.toString());
                    debugPrint(questions3.values.elementAt(sim).toString() +
                        "kontrol edilen");
                    if (isim.toString() ==
                        questions3.values.elementAt(sim).toString()) {
                      cntt++;

                      var setAda = firestoreInstance
                          .collection('GameRooms')
                          .doc('2pDzpmLy7nMX4LzTN6Tr')
                          .update({"members.$nestedkey": cntt});
                    }

                    debugPrint(cntt.toString());
                  })
                ])
              ]),
            )));
  }

  // main() async {
  //   Duration interval = Duration(seconds: 2);
  //   Stream<String> stream = Stream<String>.periodic(interval, callback);
  //   await for (String i in stream) {
  //     print(i);
  //   }

  // }

}
