import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eight_seconds/models/GameRooms.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

enum UserStat { signedUser, NotSignedUser, SignedProccess }

final FirebaseAuth _auth = FirebaseAuth.instance;

class AuthServices with ChangeNotifier {
  GameRooms _gameR = GameRooms();

  GameRooms get gameR => _gameR;

  set gameR(GameRooms value) {
    _gameR = value;
    notifyListeners();
  }

  User _user;
  bool _misafir = false;

  bool get misafir => _misafir;

  set misafir(bool value) {
    _misafir = value;
    notifyListeners();
  }

  set user(User value) {
    _user = value;
    notifyListeners();
  }

  User get user => _user;

  UserStat _durum = UserStat.NotSignedUser;

  UserStat get durum => _durum;

  set durum(UserStat value) {
    _durum = value;

    notifyListeners();
  }

  AuthServices() {
    _auth.authStateChanges().listen(_authStateChanged);
  }

  void _authStateChanged(User user) {
    if (user == null) {
      durum = UserStat.NotSignedUser;
    } else {
      durum = UserStat.signedUser;
    }
  }

  void misafirgiris() async {
    try {
      durum = UserStat.SignedProccess;
      //  notifyListeners();
      UserCredential result = await _auth.signInAnonymously();

      user = result.user;
      print("oturum açıldı " + result.user.uid);
      misafir = true;
    } catch (e) {
      durum = UserStat.NotSignedUser;
    }
  }

  void giris() async {
    durum = UserStat.SignedProccess;
    try {
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final GoogleAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential rslt = await _auth.signInWithCredential(credential);

      user = rslt.user;
      print(
          "oturum açıldı " + user.displayName + _auth.currentUser.displayName);
    } catch (e) {
      durum = UserStat.NotSignedUser;
      debugPrint("hata" + e);
      return null;
    }
  }

  void signOut() {
    _auth.signOut();
    durum = UserStat.NotSignedUser;
  }

  FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;

  /*Future<void> CreateRoom() async {
    firestoreInstance.collection("GameRooms").add({
      "name": "john",
      "age": 50,
      "createdAt": Timestamp.now(),
      "members": {_auth.currentUser.uid: 0},
      "leader": _auth.currentUser.uid,
    }).then((value) {
      print(value.id);
    });
  }*/

  Future<String> createGroup(String groupName) async {
    String retVal = "error";
    List<String> members = List();
    List<String> tokens = List();

    try {
      members.add(_auth.currentUser.uid);

      DocumentReference _docRef;
     // _docRef =  firestoreInstance.collection("GameRooms").doc(_docRef.id);

      _docRef = await firestoreInstance.collection("GameRooms").add({
        
        'leader': _auth.currentUser.uid,
        'roomName': groupName,
        'groupCreated': Timestamp.now(),
        
        
      });
            debugPrint(_docRef.id.toString());

      _gameR.id = _docRef.id;

      retVal = "success";
    } catch (e) {
      print(e);
    }

    return retVal;
  }

  Future<String> joinGroup(String groupId) async {
    String retVal = "error";
    List<String> members = List();
    List<String> tokens = List();
    try {
      DocumentReference _docRef;
      _docRef = await firestoreInstance.collection("GameRooms").doc(groupId);

      members.add(_auth.currentUser.uid);
      //tokens.add(userModel.notifToken);
      await firestoreInstance.collection("GameRooms").doc(groupId).update({
        'members': FieldValue.arrayUnion(members),
      });
      String x;
      _gameR.id = x;
      x = _docRef.id;
      print(x);

      retVal = "success";
    } on PlatformException catch (e) {
      retVal = "Lütfen doğru grup numarası girdiginizden emin olun!";
      print(e);
    } catch (e) {
      print(e);
    }

    return retVal;
  }
}
