import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_app/models/user.dart';

class UserProvider with ChangeNotifier {
  static SharedPreferences _prefs;
  User user;
  String email;
  Future<SharedPreferences> get database async {
    if (_prefs != null) {
      return _prefs;
    } else {
      _prefs = await SharedPreferences.getInstance();
      return _prefs;
    }
  }

  void fetchUser() async {
    final db = await database;
    user = User(email: db.getString('email'), loggedIn: db.getBool('loggedIn'));
    email = user.email;
    notifyListeners();
  }

  void logout() {}
}
