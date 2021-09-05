import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eight_seconds/main.dart';
import 'package:eight_seconds/screens/questionPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/auth_service.dart';
import 'package:flutter/services.dart';
import 'package:progress_indicators/progress_indicators.dart';
class WaitingRoom extends StatefulWidget {
  String roomID; 

  WaitingRoom(this.roomID,  {Key key}) : super(key: key);
  @override
  _WaitingRoomState createState() => _WaitingRoomState();
}

class _WaitingRoomState extends State<WaitingRoom> {
  final SnackBar _snackBar = SnackBar(
    content: const Text('Panoya kopyalandı!'),
    duration: const Duration(seconds: 2),
  );
    bool isReady = true;
    String ready = "HAZIR ";

   String findUserName(String ID) {
  FirebaseFirestore.instance
        .collection('users')
        .doc(ID)

        .get()
        .then((result) => {
          isim = result["name"].toString(),  
          debugPrint(isim+"bu isim"),
       
          debugPrint(result.data().toString(),
             
           
        )}
        
        );
    return isim;
  }
List<String> players=[];

  // Widget sendName(Map<String,dynamic> eklenen){
  // debugPrint(findUserName(eklenen.keys.toString())+"SDA");
    

  // }
  TextEditingController _groupNameController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;
  int skor = 0;
  @override
  Widget build(BuildContext context) {
    final _Auth = Provider.of<AuthServices>(context);
    int count = 0;
    bool isClicked = false;
    Map<String,dynamic> eklenen;
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
                  eklenen = userDocument["members"];
                  debugPrint(eklenen.toString()+"bu olmalı");
                  

                  return userDocument['members'].length==3 ? 
                
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => questionPage(widget.roomID,eklenen)
                        ),
                       ) 
                  : Column(
                    
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left:38.0),
                        child: Image.network('https://lern.link/2020/wp-content/uploads/2019/11/hourglass_sand_pour_business_woman_300_clr_22814.gif'),
                      ),

                      Container(
                        height: 150,
                        width: 275,
                        decoration: BoxDecoration(
                          color: Color(0xff009683),
                          borderRadius:BorderRadius.circular(30),
                          border: Border.all(color: Colors.white, width: 3),
                        ),
                        child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SelectableText(
                                  
                                  widget.roomID.toString().toString(),
                                style: TextStyle( color: Colors.white, fontSize: 16.0),cursorColor: Colors.white,),
                              IconButton( 
                              icon: Icon(Icons.copy_all,color: Colors.white,),
                             onPressed: () =>
  Clipboard.setData(ClipboardData(text:widget.roomID.toString().toString() ))
    .then((value) { //only if ->
       ScaffoldMessenger.of(context).showSnackBar(_snackBar); // -> show a notification

    }))],
                            )
                            ,)),
                      
                      SizedBox(
                        height: 16,
                      ),
                  Center(
                    
                    child: Container(
                       height: 50,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.0),
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                isReady ? "HAZIR" : "HAZIRLANIYOR",
                                style: TextStyle(
                                    color: const Color(0xff009683), fontSize: 16.0),
                              ),
                               ],
                          ),
                         onPressed: () async {
                          setState(() {
                            isReady = false;
                          });
                                skor++;
                                var nestedkey =_auth.currentUser.uid;
var setAda = firestoreInstance.collection('GameRooms').doc('2pDzpmLy7nMX4LzTN6Tr').update({
   "members.$nestedkey":0
 });
                          },
                        ),
                    ),
                  ),
                          
                    ],
                  );
                  
                })));
  }

}
