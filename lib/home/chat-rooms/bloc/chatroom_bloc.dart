import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_app/models/chat_room.dart';
import 'package:chat_app/models/user.dart';
import 'package:chat_app/repository/chat_room_repository.dart';
import 'package:equatable/equatable.dart';

part 'chatroom_event.dart';
part 'chatroom_state.dart';

class ChatroomBloc extends Bloc<ChatroomEvent, ChatroomState> {
  ChatRoomRepository _chatRoomRepository = ChatRoomRepository();
  @override
  ChatroomState get initialState => ChatroomInitial();

  @override
  Stream<ChatroomState> mapEventToState(
    ChatroomEvent event,
  ) async* {
    if (event is ChatroomStarted) {
      yield* _mapChatroomStartedToState(event.user);
    } else if (event is ChatroomLoaded) {
      yield* _mapChatroomLoadedToState();
    }
  }

  Stream<ChatroomState> _mapChatroomStartedToState(User user) async* {
    //TODO
    final List<ChatRoom> chatRoom = await _chatRoomRepository.getChatRooms();
  }

  Stream<ChatroomState> _mapChatroomLoadedToState() async* {
    //TODO
  }
}
