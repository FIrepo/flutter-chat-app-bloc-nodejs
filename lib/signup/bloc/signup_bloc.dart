import 'dart:async';

import 'package:bloc/bloc.dart';
import '../../repository/user_repository.dart';
import 'package:chat_app/validators.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  UserRepository _userRepository = new UserRepository();

  @override
  //* here we define our first constructor intial
  SignupState get initialState => SignupState.intial();

  @override
  Stream<SignupState> mapEventToState(
    SignupEvent event,
  ) async* {
    if (event is SignupUsernameChanged) {
      yield* _mapSignupUsernameChangedToState(event.username);
    } else if (event is SignupEmailChanged) {
      yield* _mapSignupEmailChangedToState(event.email);
    } else if (event is SignupPasswordChanged) {
      yield* _mapSignupPasswordChangedToState(event.password);
    } else if (event is SignupWithCredentialsPressed) {
      yield* _mapSignupWithCredentialsPressedChangedToState(
        username: event.username,
        email: event.email,
        password: event.password,
      );
    }
  }

  //! Now here we have to define many stream for email
  //! and password so that there is a flow of data
  //! whenever there is change in frontend

  Stream<SignupState> _mapSignupUsernameChangedToState(String username) async* {
    //* Here we are joining our update function in state to
    //* to frontend
    yield state.update(
      isUsernameValid: Validators.isValidUsername(username),
    );
  }

  Stream<SignupState> _mapSignupEmailChangedToState(String email) async* {
    //* Here we are joining our update function in state to
    //* to frontend
    yield state.update(
      isEmailValid: Validators.isValidEmail(email),
    );
  }

  Stream<SignupState> _mapSignupPasswordChangedToState(String password) async* {
    yield state.update(
      isPasswordValid: Validators.isValidPassword(password),
    );
  }

  Stream<SignupState> _mapSignupWithCredentialsPressedChangedToState({
    String username,
    String email,
    String password,
  }) async* {
    yield SignupState.loading();
    try {
      await _userRepository.signUpWithCredentials(username, email, password);
      print('signup: succes');
      yield SignupState.success();
    } catch (_) {
      yield SignupState.failure();
    }
  }
}
