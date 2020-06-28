import 'dart:async';
import 'dart:convert';
import 'package:chat_app/local_storage_service.dart';
import 'package:chat_app/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import '../local_storage_service.dart';

//! User Repo will have access to shared pref
//*                    main
//*                       \
//*              Authenticatoin Initail Event
//*                         \
//*              Authentication Bloc will call user repo
//*                           \
//*   User Repo have access to call shared pref and check for token
//*                             \
//*     token will come from shared pref (token is not null) and user repo have function to check from server that token is valid or not
//*                               \
//*   token is valid we will save infomation (email, username ) in user repo and save it to pass to home screen
//*
//? Completed this part :)
//*   UserRepo: saving token while signin and signup to share preference
//*             \
//*       Now change event managing in main and add splash screen
//*               \
//*           Create Main screen of chat app (where all contacts are shown )
//*                \
//?         Finally after so much time pass in error handling i completed login section
//?   Always define class with constructor
//!   var user = User(); => 3 hours waste in this

class UserRepository {
  static String url = 'http://10.0.2.2:3000';

  Future<void> signInWithCredentials(String email, String password) async {
    final response = await http.post(url + '/users/signin',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({'email': email, 'password': password}));

    final decode = json.decode(response.body)['user'];
    print('coming from here');
    final token = json.decode(response.body)['token'] as String;
    var user = new User();
    user.userId = decode['_id'].toString(); //!
    user.email = decode['email'].toString();
    user.username = decode['username'].toString();
    user.token = token.toString();
    print('first');
    await TokenStorage.saveUserSharedPreference(user);
  }

  Future<void> signUpWithCredentials(
      String username, String email, String password) async {
    final response = await http.post(url + '/users/signup',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(
            {'username': username, 'email': email, 'password': password}));

    final decode = json.decode(response.body)['user'];
    print('coming from here');
    final token = json.decode(response.body)['token'] as String;
    var user = new User();
    user.userId = decode['_id'].toString(); //!
    user.email = decode['email'].toString();
    user.username = decode['username'].toString();
    user.token = token.toString();
    print('first');
    await TokenStorage.saveUserSharedPreference(user);

    print('save token: ' + await TokenStorage.getTokenSharedPreference());

    print('user: ' + user.email);
    print('error: ' + json.decode(response.body)['error'].toString());
  }

  Future<void> signOut() async {
    //TODO    Error Handling
    final response = await http.get(url + '/users/signout', headers: {
      HttpHeaders.authorizationHeader:
          await TokenStorage.getTokenSharedPreference()
    });
    final decode = json.decode(response.body);
    print(decode.toString());
    print('from sign out screen');
  }

  Future<void> signOutAll() async {
    //TODO    Error Handling
    final response = await http.get(url + '/users/signoutAll', headers: {
      HttpHeaders.authorizationHeader:
          await TokenStorage.getTokenSharedPreference()
    });
    final decode = json.decode(response.body);
    print(decode.toString());
    print('from sign out screen');
  }

  Future<bool> isSignedIn() async {
    try {
      final token = await TokenStorage.getTokenSharedPreference();
      if (token != null) {
        final response = await http.get(
          url + '/users/me',
          headers: {HttpHeaders.authorizationHeader: token},
        );
        final decode = json.decode(response.body);
        print("decode: " + decode.toString());
        var user = new User();
        user.userId = decode['_id'].toString(); //!
        user.email = decode['email'].toString();
        user.username = decode['username'].toString();
        user.token = token;
        await TokenStorage.saveUserSharedPreference(user);
        final userComeFromShared = await TokenStorage.getUserSharedPreference();
        print('email: from issignedin function&&&&&&&&&& ' +
            userComeFromShared.username);
        print('userId: ' + userComeFromShared.userId);

        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<User> getUser() async {
    User user = User();
    user = await TokenStorage.getUserSharedPreference();
    print('from get User: ' + user.username);
    return user;
  }
}
