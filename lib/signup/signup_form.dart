import 'package:chat_app/authentication/bloc/authentication_bloc.dart';
import 'package:chat_app/login/login_screen.dart';
import 'package:chat_app/signup/bloc/signup_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupForm extends StatefulWidget {
  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  // ! 1 first create controller to have controll over text of fronted
  // ! from the bloc(backend)
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  //* define bloc so that we can hold the instance of bloc in it
  SignupBloc _signupBloc;

  // ! 2 overide init funciton and add provide bloc listner
  @override
  void initState() {
    super.initState();
    _signupBloc = BlocProvider.of<SignupBloc>(context);
    _usernameController.addListener(_onSignUpUsernameChanged);
    _emailController.addListener(_onSignUpEmailChanged);
    _passwordController.addListener(_onSignUpPasswordChanged);
  }
  //? All the function are defining outside the build to keep
  //? buissness logic outside the UI

  //* i am defining get to provide me bool (true) when all
  //* the field is not empty
  bool get isPopulated =>
      _usernameController.text.isNotEmpty &&
      _emailController.text.isNotEmpty &&
      _passwordController.text.isNotEmpty;

  //* define a function to get information about enabling button
  bool isSignupButtonEnabled(SignupState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  Widget build(BuildContext context) {
    //! 3 first define bloc builder so that we can get the feeling
    //! what we are trying to do and have a basic design
    return BlocListener<SignupBloc, SignupState>(
      listener: (context, state) {
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Sign Up Failure'),
                  Icon(Icons.error),
                ],
              ),
              backgroundColor: Colors.red,
            ));
        }
        if (state.isSubmitting) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Registering...'),
                  CircularProgressIndicator(),
                ],
              ),
            ));
        }
        if (state.isSuccess) {
          print('frontend succes');

          BlocProvider.of<AuthenticationBloc>(context)
              .add(AuthenticationLoggedIn());
          Navigator.of(context).pop();
          print('still in frontend succ');
        }
      },
      child: BlocBuilder<SignupBloc, SignupState>(
        builder: (context, state) {
          return Container(
            child: Form(
              child: ListView(
                children: <Widget>[
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                        icon: Icon(Icons.person), labelText: 'Username'),
                    autovalidate: true,
                    autocorrect: false,
                    validator: (_) {
                      return !state.isUsernameValid ? 'Enter Username' : null;
                    },
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                        icon: Icon(Icons.email), labelText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                    autovalidate: true,
                    autocorrect: false,
                    validator: (_) {
                      return !state.isEmailValid ? 'Enter Email' : null;
                    },
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                        icon: Icon(Icons.lock), labelText: 'password'),
                    obscureText: true,
                    autovalidate: true,
                    autocorrect: false,
                    validator: (_) {
                      return !state.isPasswordValid ? 'Enter Password' : null;
                    },
                  ),
                  FlatButton(
                    child: Text('Sign Up'),
                    onPressed: () {
                      print('Email: ${_usernameController.text}');
                      //* the button will enable when all the field are valid
                      isSignupButtonEnabled(state) ? _onFormSubmitted() : null;
                    },
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: <Widget>[
                      Text('Already have an account? '),
                      GestureDetector(
                        child: Text('Sign in'),
                        onTap: () {
                          !state.isSubmitting || !isPopulated
                              ? _moveToLoginScreen()
                              : null;
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    print('dispose signup');
    super.dispose();
  }

  //! 4 after completing bloc
  //! completing pipeline to connect to backend
  //! and flow of data is completed

  void _onSignUpUsernameChanged() {
    _signupBloc.add(SignupUsernameChanged(username: _usernameController.text));
  }

  void _onSignUpEmailChanged() {
    _signupBloc.add(SignupEmailChanged(email: _emailController.text));
  }

  void _onSignUpPasswordChanged() {
    _signupBloc.add(SignupPasswordChanged(password: _passwordController.text));
  }

  void _onFormSubmitted() {
    _signupBloc.add(SignupWithCredentialsPressed(
      username: _usernameController.text,
      email: _emailController.text,
      password: _passwordController.text,
    ));
  }

  //? Function to Navigate to Login Screen
  void _moveToLoginScreen() {
    Navigator.of(context).pop();
  }
}
