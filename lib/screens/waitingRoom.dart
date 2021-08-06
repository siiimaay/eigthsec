import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eight_seconds/screens/questionPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/auth_service.dart';

class WaitingRoom extends StatefulWidget {
  String roomID;
  WaitingRoom(this.roomID, {Key key}) : super(key: key);
  @override
  _WaitingRoomState createState() => _WaitingRoomState();
}

class _WaitingRoomState extends State<WaitingRoom> {
  TextEditingController _groupNameController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;
  int skor = 0;
  @override
  Widget build(BuildContext context) {
    final _Auth = Provider.of<AuthServices>(context);
    int count = 0;
    bool isClicked = false;
    return ChangeNotifierProvider(
        create: (_) => AuthServices(),
        child: Scaffold(
            body: StreamBuilder(
                stream: firestoreInstance
                    .collection('GameRooms')
                    .doc("2pDzpmLy7nMX4LzTN6Tr")
                    .snapshots(),
                builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasData == false) {
                    return Text("Loading");
                  }
                  var userDocument = snapshot.data;
                  return userDocument['members'].length==8 ? 
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => questionPage()
                        ),
                      ) : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 150,
                        width: 200,
                        decoration: BoxDecoration(
                          color: Color(0xff009683),
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: Center(
                            child: Text(widget.roomID.toString().toString())),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      RaisedButton(
                          onPressed: () async {
                            skor++;
                            debugPrint(skor.toString());
                            var nestedkey =_auth.currentUser.uid;
var setAda = firestoreInstance.collection('GameRooms').doc('2pDzpmLy7nMX4LzTN6Tr').update({
  "members.$nestedkey": 1
});
           //firestoreInstance.collection("GameRooms").doc("1m4uuqaN0Vt5XJra7kb4").update({"members":  FirebaseFirestore.fieldValue.arrayUnion("greater_virginia")});

                            // DocumentReference _docRef = await firestoreInstance.collection("GameRooms").add({

                            //     'leader': _auth.currentUser.uid,
                            //     'roomName': groupName,
                            //     'groupCreated': Timestamp.now(),

                            //   });
                            //  }catch(e){
                            //    print(e);

                            //  }
                            //  userDocument["members"].length ==3 ? debugPrint("oldu"): debugPrint("Olmadı");
                          },

                          //       onPressed: isClicked==true ? null : () { setState(() {
                          //   isClicked = true;

                          // });
                          // debugPrint("bastı mı");
                          // debugPrint(isClicked.toString());
                          //       } ,
                          //disabledColor: Colors.yellow,

                          child: Center(child: Text("READY")))
                    ],
                  );
                  /*userDocument["members"].length==3 ?  Center(child: Text(widget.roomID.toString().toString()))  : SimpleDialog(
      children: [
         Text( "Diğerlerinin gelmesini bekliyoruz!")
       ],
     );*/
                })));
  }
}
