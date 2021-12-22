import 'package:shared_preferences/shared_preferences.dart';

class Services {
  static Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = (prefs.getString('token') ?? '0');
    print(token);
    return token;
    // await prefs.setInt('counter', counter);
  }
  static setToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }
}
