part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationSuccess extends AuthenticationState {
  final user;
  AuthenticationSuccess(this.user);
  @override
  List<Object> get props => [user];

  @override
  String toString() {
    return 'AuthenticationSuccess {User: ${user.toString()}';
  }
}

class AuthenticationFailure extends AuthenticationState {}
