part of 'signup_bloc.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();
}

class SignupUsernameChanged extends SignupEvent {
  //! Here we are linking our frontend username text to backend
  //! we are making pipe so that data from username of frontend
  //! can flow to backend whenever there is a changed in frontend

  final String username;

  const SignupUsernameChanged({@required this.username});

  @override
  List<Object> get props => [username];

  @override
  String toString() {
    return 'SignupUsernameChanged { username :$username }';
  }
}

class SignupEmailChanged extends SignupEvent {
  //! Here we are linking our frontend email text to backend
  //! we are making pipe so that data from email of frontend
  //! can flow to backend whenever there is a changed in frontend

  final String email;

  const SignupEmailChanged({@required this.email});

  @override
  List<Object> get props => [email];

  @override
  String toString() {
    return 'SignupEmailChanged { email :$email }';
  }
}

class SignupPasswordChanged extends SignupEvent {
  //! Here we are linking our frontend password text to backend
  //! we are making pipe so that data from password of frontend
  //! can flow to backend whenever there is a changed in frontend

  final String password;

  const SignupPasswordChanged({@required this.password});

  @override
  List<Object> get props => [password];

  @override
  String toString() {
    return 'SignupPasswordChanged { password :$password }';
  }
}

class SignupWithCredentialsPressed extends SignupEvent {
  final String username;
  final String email;
  final String password;

  const SignupWithCredentialsPressed({
    @required this.username,
    @required this.email,
    @required this.password,
  });
  @override
  List<Object> get props => [username, email, password];

  @override
  String toString() {
    return 'SignupWithCredentialsPressed { username :$username , email :$email, password :$password }';
  }
}
