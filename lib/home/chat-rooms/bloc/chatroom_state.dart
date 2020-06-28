part of 'chatroom_bloc.dart';

abstract class ChatroomState extends Equatable {
  const ChatroomState();
}

class ChatroomInitial extends ChatroomState {
  @override
  List<Object> get props => [];
}

class ChatroomLoadedState extends ChatroomState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
