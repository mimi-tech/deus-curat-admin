import 'package:shared_preferences/shared_preferences.dart';


class UserPreferences {
 void saveFullName(String fullName) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("fullName",fullName);
  }

  Future<String> getFullName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String fullName = prefs.getString("fullName") ?? "";
    return fullName;
  }



  void saveToken(String token)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token',token);
  }

  Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? "";
    return token;
  }
  void saveAuthId(String userId)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userId',userId);
  }

  Future<String> getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString("userId") ?? "";
    return userId;
  }

  void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    prefs.remove('userId');
    prefs.remove('fullName');

  }
}