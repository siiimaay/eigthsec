import 'package:flutter/cupertino.dart';

class GameRooms with ChangeNotifier {
  String _id;

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  String _name;
  String _leader;
  Map<int, int> _members; //holds members and scores
  var _roomCreatedAt;

  GameRooms(
      [this._id, this._name, this._leader, this._members, this._roomCreatedAt]);

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get leader => _leader;

  set leader(String value) {
    _leader = value;
  }

  Map<int, int> get members => _members;

  set members(Map<int, int> value) {
    _members = value;
  }

  get roomCreatedAt => _roomCreatedAt;

  set roomCreatedAt(value) {
    _roomCreatedAt = value;
  }

  void method() {
    debugPrint("bakalım oldu mu");
  }
}
