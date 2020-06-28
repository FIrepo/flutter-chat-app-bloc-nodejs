import 'package:chat_app/authentication/bloc/authentication_bloc.dart';
import 'package:chat_app/home/home_screen.dart';
import 'package:chat_app/login/login_screen.dart';
import 'package:chat_app/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    BlocProvider(
      create: (context) => AuthenticationBloc()..add(AuthenticationStarted()),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        accentColor: Colors.tealAccent,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationInitial) {
            print('splash screen');

            return SplashScreen();
          }
          if (state is AuthenticationFailure) {
            print('login screen');
            return LoginScreen();
          }
          if (state is AuthenticationSuccess) {
            print('authsucc: main.dart');
            return HomeScreen(state.user);
          }
        },
      ),
    );
  }
}
