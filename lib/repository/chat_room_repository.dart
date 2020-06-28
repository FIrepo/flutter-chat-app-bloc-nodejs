import 'dart:io';

import 'package:chat_app/local_storage_service.dart';
import 'package:chat_app/models/chat_room.dart';
import 'package:http/http.dart' as http;

class ChatRoomRepository {
  static String url = 'http://10.0.2.2:3000';

  Future<List<ChatRoom>> getChatRooms() async {
    //TODO
    final response = await http.get(url + '/getChatRooms', headers: {
      HttpHeaders.authorizationHeader:
          await TokenStorage.getTokenSharedPreference()
    }); //TODO
  }
}
