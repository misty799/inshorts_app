import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_app/models/user.dart';

class UserProvider {
  static SharedPreferences _prefs;
  User user;
  Future<SharedPreferences> get database async {
    if (_prefs != null) {
      return _prefs;
    } else {
      _prefs = await SharedPreferences.getInstance();
      return _prefs;
    }
  }

  fetchUser() async {
    final db = await database;
    user = User(email: db.getString('email'), loggedIn: db.getBool('loggedIn'));
    return user;
  }

  void logout() {}
}
