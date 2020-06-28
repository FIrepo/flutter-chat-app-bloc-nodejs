import 'dart:convert';
import 'dart:io';

import 'package:chat_app/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:chat_app/models/search_user.dart';

class SearchUserRepository {
  final User user;
  SearchUserRepository(this.user);
  static String url = 'http://10.0.2.2:3000';

  Future<List<SearchUser>> getAllUser() async {
    //TODO return
    print('Start getting user');
    final response = await http.get(url + '/users/getAllUsers', headers: {
      HttpHeaders.authorizationHeader: user.token,
    });
    final decode = json.decode(response.body);
    print(decode.toString());
    List<SearchUser> searchUser = [];
    decode.forEach((user) {
      searchUser.add(
        SearchUser(
          username: user['username'].toString(),
          email: user['email'].toString(),
        ),
      );
    });
    return searchUser;
  }
}
