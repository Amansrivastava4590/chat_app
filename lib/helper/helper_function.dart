import 'package:shared_preferences/shared_preferences.dart';

class HelperFunction{
  /// KEYS
  static String userLoggedInKey = "LOGGEDINKEY";
  static String userNamedKey = "USERNAMEDKEY";
  static String userEmailKey = "USEREMAILKEY";

  /// SAVING THE DATA TO SF
static Future<bool> saveUserLoggedInStatus(bool isUserLoggedIn) async {
  SharedPreferences sf = await SharedPreferences.getInstance();
  return await sf.setBool(userLoggedInKey,isUserLoggedIn);
}
  static Future<bool> saveUsernameSF(String userName) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userNamedKey,userName);
  }

  static Future<bool> saveUserEmailSF(String userEmail) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userEmailKey,userEmail);
  }

  /// GETTING THE DATA FROM SF
static Future<bool?> getUserLoggedInStatus() async {
  SharedPreferences sf = await SharedPreferences.getInstance();
  return sf.getBool(userLoggedInKey);
}
static Future<String?> getUsernameFromSF() async {
  SharedPreferences sf = await SharedPreferences.getInstance();
  return sf.getString(userNamedKey);
}
static Future<String?> getUserEmailFromSF() async {
  SharedPreferences sf = await SharedPreferences.getInstance();
  return sf.getString(userEmailKey);
}

}