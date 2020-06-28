part of 'chatroom_bloc.dart';

abstract class ChatroomEvent extends Equatable {
  const ChatroomEvent();
}

class ChatroomStarted extends ChatroomEvent {
  final User user;
  ChatroomStarted(this.user);

  @override
  List<Object> get props => [user];
}

class ChatroomLoaded extends ChatroomEvent {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
