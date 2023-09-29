import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  static Future<void> addUserCredential(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('emailAdress', email);
    await prefs.setString('securePassword', password);
  }

  static Future<Map<String, String>> getUserCredential() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final mapCrendential = <String, String>{};
    mapCrendential["emailAdress"] = await prefs.getString("emailAdress")!;
    mapCrendential["securePassword"] = await prefs.getString("securePassword")!;
    return mapCrendential;
  }

  static Future<void> enableFirstRecord(bool key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isFirstTimeInApp", key);
  }

  static Future<bool> getIsFirstRecord() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final status = await prefs.getBool("isFirstTimeInApp") ?? true;
    return status;
  }
}
