import 'package:bloc/bloc.dart';
import 'package:chat_app/local_storage_service.dart';
import 'package:chat_app/models/user.dart';
import '../../repository/user_repository.dart';
import 'package:equatable/equatable.dart';
part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository _userRepository = UserRepository();

  @override
  AuthenticationState get initialState => AuthenticationInitial();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AuthenticationStarted) {
      yield* _mapAuthenticationStartedToState();
    } else if (event is AuthenticationLoggedIn) {
      yield* _mapAuthenticationLoggedInState();
    } else if (event is AuthenticationLoggedOut) {
      yield* _mapAuthenticationLoggedOutState();
    } else if (event is AuthenticationLoggedOutAll) {
      yield* _mapAuthenticationLoggedOutAllToState();
    }
  }

  Stream<AuthenticationState> _mapAuthenticationStartedToState() async* {
    final user = await TokenStorage.getUserSharedPreference();
    print('_auth bloc down');
    print('email: ' + user.email);
    print('username: ' + user.username);
    print('token: ' + await TokenStorage.getTokenSharedPreference());
    try {
      final isSignedIn = await _userRepository.isSignedIn();
      if (isSignedIn) {
        print('is signed in: true');

        final user = await TokenStorage.getUserSharedPreference();
        print('I WANT TO SEE IT: ' + user.userId);
        yield AuthenticationSuccess(user);
      } else {
        print('token: ' + await TokenStorage.getTokenSharedPreference());
        print('auth fail');
        yield AuthenticationFailure();
      }
    } catch (e) {
      yield AuthenticationFailure();
    }
  }

  Stream<AuthenticationState> _mapAuthenticationLoggedInState() async* {
    try {
      final User user = await TokenStorage.getUserSharedPreference();
      print('working in auth logged in: ' + user.username);
      print('TO SEE: ' + user.userId);
      yield AuthenticationSuccess(user);
    } catch (e) {
      print('this is a catch!!!!!!!!!');
      yield AuthenticationInitial();
    }
  }

  Stream<AuthenticationState> _mapAuthenticationLoggedOutState() async* {
    try {
      await _userRepository.signOut(); //TODO signOut()
      yield AuthenticationFailure();
    } catch (e) {
      yield AuthenticationFailure();
    }
  }

  Stream<AuthenticationState> _mapAuthenticationLoggedOutAllToState() async* {
    try {
      await _userRepository.signOutAll();
      yield AuthenticationFailure();
    } catch (e) {
      yield AuthenticationFailure();
    }
  }
}
