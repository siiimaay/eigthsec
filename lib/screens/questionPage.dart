import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eight_seconds/screens/lobi.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../models/auth_service.dart';

class questionPage extends StatefulWidget {
  String roomID;
  bool bitti = false;
    Map<String,dynamic> oyuncular;
  questionPage(this.roomID, this.oyuncular, {Key key}) : super(key: key);
  @override
  _questionPageState createState() => _questionPageState();
}
var isim;
int cntt = 0;
bool isAnswered = false;
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
            isAnswered = false;
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
    void zeroDifference(){
      
    Future.delayed(Duration(seconds: 6), () {
  // 5 seconds over, navigate to Page2.
 startTimer();
});
  }
  void zeroDiff(){
      
    Future.delayed(Duration(seconds: 6), () {
  // 5 seconds over, navigate to Page2.
questionsReturn();
});
  }
  bool isLoading = true;
   void bekleme() {
    Timer.periodic(const Duration(seconds: 7), (t) {
      setState(() {
        isLoading = false; //set loading to false
      });
      t.cancel(); //stops the timer
    });
  }

  // void checkAnswer(){
  //   //Textcontrollerdan geleni check et. varsa artt??r
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

          if (sim == 4 ) {
            _timer.cancel();
          }
        },
      ),
    );
  }
     void evaluateAns() {
    Timer.periodic(const Duration(seconds: 7), (t) {
      setState(() {
        isLoading = false; //set loading to false
      });
      t.cancel(); //stops the timer
    });
  }

  Map<String, dynamic> questions3 = new Map<String, dynamic>();
    Map<String, dynamic> questions4 = new Map<String, dynamic>();
    List<String> han = new List<String>();
    Map<String, dynamic> userAnswers = new Map<String, dynamic>();
    String user1;
    String user2;
    String user3;
 void members() {
    FirebaseFirestore.instance
        .collection("GameRooms")
        .doc("2pDzpmLy7nMX4LzTN6Tr")
        .get()
        .then((result) => {
              //debugPrint(result["members"].toString()),
              membersID.addAll(result["members"]),
              memberList.addAll(membersID.keys),         
              memberList.remove(_auth.currentUser.uid),
               user1 = membersID.keys.elementAt(0),
               user2 = membersID.keys.elementAt(1),
               user3 = membersID.keys.elementAt(2),


              userAnswers ={
                user1 : 0,
                user2: 0,
                user3 : 0
              }

            });
  }
  void answerKey(){

  }
void mem()  {
    FirebaseFirestore.instance
        .collection('GameRooms')
        .doc('2pDzpmLy7nMX4LzTN6Tr')
        .get()
        .then((result) => {
          debugPrint(result["members"].toString()+"bu da m?? yok"),
              questions4.addAll(result["members"]),
              // debugPrint(questions4.toString()+"bbb"),
               questions4.remove(_auth.currentUser.uid)

               
            });
           
    //   checkAnswer();
    // debugPrint(questions3.toString()+"as");
   if(mounted){
     setState(() {
     
   });
   }
 //   debugPrint(questions4.toString()+"bbb");
//debugPrint(han.toString()+"sjadklsa??");

  }
  void oku()  {
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
  List<String> isimler;
 void findUserName(String ID) {
   
  FirebaseFirestore.instance
        .collection('users')
        .doc(ID)
        .get()
        .then((result) => {
          isim = result["name"].toString(),  
         isimler[0]=isim,
         isimler[1]=isim,
          isimler[2]=isim
           
        }
        
        );
       setState(() {
         
       });
    
  }
 

  @override
  void initState() {
    zeroDiff();
    bekleme();
    zeroDifference();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool bitti = false;
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
    debugPrint(widget.oyuncular.toString()+"aranan kan");
 
    return ChangeNotifierProvider(
        create: (_) => AuthServices(),
        child: Scaffold(
            resizeToAvoidBottomInset: true,
            body: isLoading ?
            Center(child: Column(
              mainAxisAlignment:MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left:15.0),
                  child: Image.network("https://www.hareketligifler.net/data/media/1261/kum-saati-hareketli-resim-0007.gif"),
                ),
              
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text("RAK??PLER??N SEN?? BEKL??YOR!",style:
                     TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize:24,)

                     ),
                  ),
                ),
                 SizedBox(height: 40,),
              //    Center(child: Text("Simay Ekici",style:
              //    TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize:28,)
              //    ),),
              //    SizedBox(height: 20,),
              //    Center(child: Text("USER 1",style:
              //    TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize:28,))),
              //                     SizedBox(height: 20,),

              //  Center(child: Text("USER2 ",style:
              //    TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize:28,)))

              ],
            )) : SingleChildScrollView(
              reverse: true,
              child: Column(
                crossAxisAlignment:CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: IconButton(
                          
                            icon:Text("Ayr??l ",
                              style: TextStyle(
                                           fontSize: 14,
                                           color: Colors.white,
                                           fontWeight: FontWeight.bold)),
                                          onPressed: () {
                                             Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LobiPage()
                            ),
                           ) ;
},
                          ),
                    ),
                  ),
                Row(
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
                                Text(cntt !=4 ?_start.toString() : " ",
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
                Stack(children: [
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0),
                      ),
                      child: Container(
                        
                          color: Colors.blueGrey.shade200,
                          child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10.0),
                                bottomRight: Radius.circular(10.0),
                              ),
                              child: Container(
                                height:300,
                                
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
                                  
                                       return (userDocument["members"][
                                                       questions4.keys
                                                           .elementAt(0)] ==
                                                   4 ||
                                               userDocument["members"][
                                                       questions4.keys
                                                           .elementAt(1)] ==
                                                   4 ||   userDocument["members"][_auth.currentUser.uid] ==4)
                                                       
                                                       
                                           ? 
          Dialog(
                 //this right here
            child: Container(
                 height:600,
                      decoration: BoxDecoration(
                        borderRadius:   BorderRadius.circular(20.0),
                          color:  const Color(0xff009683),
                          border: Border.all(color: Colors.white, width:5),),
             
           
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text("OYUN B??TT??",
                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(height: 10,),
                    Text("KAZANAN ",
                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                    SizedBox(height: 30,),
                     SizedBox(
                      width: 320.0,
                      child: RaisedButton(
                        onPressed: () { Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LobiPage()
                        ),
                       ) ;
},
                        child: Text(
                          "ANASAYFAYA D??N",
                          style: TextStyle(color: const Color(0xff009683)),
                        ),
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                )))
               
             
                                           : Text(
                                               questions3.keys.elementAt(sim),style:
                                               TextStyle(fontWeight: FontWeight.bold,
                                               color:Colors.white,
                                               fontSize:24));
                                     }),
                                    ))))),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                      SizedBox(width: 10,),
                       isAnswered ==false ?  Padding(
                         padding: const EdgeInsets.only(top: 250),
                         child: Container(
                           height:50,
                           width: 50,                         
                             
                           decoration:BoxDecoration(
                             borderRadius:BorderRadius.circular(20),
                             color:Colors.white,
                           ),
                           child: Center(
                             child: IconButton(
                      
                   icon:Icon(Icons.send,color:const Color(0xff009683),size: 36,),
                   onPressed: () {
                  
                    isAnswered = true;

                    var isim = _answerController.text;
                    debugPrint(isim.toString() + "bu mu");
                    _answerController.clear();
                  //  debugPrint(isim.toString());
                   // debugPrint(_answerController.text.toString());
                   // debugPrint(questions3.values.elementAt(sim).toString() +
                   //[current user:0] =>no answer o zaman value at current user will be dated
                   userAnswers[_auth.currentUser.uid] = isim;    
                   debugPrint(userAnswers[_auth.currentUser.uid].toString()+"bu kisi cevab??") ;    
                   //cevalar?? g??ncelledik simdi gerekli olan su
                    if (isim.toString() == questions3.values.elementAt(sim).toString()) {
                      cntt++;

                      var setAda = firestoreInstance
                                .collection('GameRooms')
                                .doc('2pDzpmLy7nMX4LzTN6Tr')
                                .update({"members.$nestedkey": cntt});
                    }

                 //   debugPrint(cntt.toString());
                  }),
                           ),
                         ),
                       ) :   Text("bekliyoruz",style: TextStyle(color: Colors.transparent),) 
                    ],
                    
                  ),
              
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
