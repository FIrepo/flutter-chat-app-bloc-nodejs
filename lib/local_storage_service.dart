import 'package:chat_app/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

//! we are going to save token we get from server to mobile storage using
//! shared preference i know that flutter_secure_storage is better choice
//! but i dont know how to use it

class TokenStorage {
  //* For shared preference class we have to define static
  //* key and static get and set function
  static String sharedPreferenceUserLoginTokenKey = 'TOKEN';
  static String sharedPreferenceEmailKey = 'USEREMAIL';
  static String sharedPreferenceUsernameKey = 'USERNAME';

  //! Function to save token
  static Future<void> saveTokenSharedPreference(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceUserLoginTokenKey, token);
  }

  static Future<void> saveUserSharedPreference(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(sharedPreferenceUserLoginTokenKey, user.token);
    await prefs.setString(sharedPreferenceEmailKey, user.email);
    await prefs.setString(sharedPreferenceUsernameKey, user.username);
    return;
  }

  //! Function to read token
  static Future<String> getTokenSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharedPreferenceUserLoginTokenKey);
  }

  //! Function to get User Info from local storage
  static Future<User> getUserSharedPreference() async {
    print('from Local storage');
    User user = User();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('working till herre');

    user.token = prefs.getString(sharedPreferenceUserLoginTokenKey);
    user.email = prefs.getString(sharedPreferenceEmailKey);
    user.username = prefs.getString(sharedPreferenceUsernameKey);

    print('email@@@@@@@@@@@@: ' + user.email);
    return user;
  }
}
