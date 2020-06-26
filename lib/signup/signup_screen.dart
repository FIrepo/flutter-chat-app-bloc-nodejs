import 'package:chat_app/signup/bloc/signup_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './signup_form.dart';

class SignupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Signup Screen'),
      ),
      body: BlocProvider<SignupBloc>(
        create: (context) => SignupBloc(),
        child: SignupForm(),
      ),
    );
  }
}
