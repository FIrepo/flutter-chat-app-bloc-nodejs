import 'package:chat_app/authentication/bloc/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                BlocProvider.of<AuthenticationBloc>(context)
                    .add(AuthenticationLoggedOut());
              },
            )
          ],
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              ListTile(
                title: Text(
                  'Signout',
                  softWrap: true,
                ),
                onTap: () {
                  BlocProvider.of<AuthenticationBloc>(context)
                      .add(AuthenticationLoggedOut());
                },
              ),
              ListTile(
                title: Text(
                  'Signout from all device',
                  softWrap: true,
                ),
                onTap: () {
                  BlocProvider.of<AuthenticationBloc>(context)
                      .add(AuthenticationLoggedOutAll());
                },
              ),
            ],
          ),
        ),
        body: ListView(
          children: <Widget>[],
        ));
  }
}

//*                                home screen
//*                            /              \
//*                     friend user       search user
//*                      /                      \
//*          User conversation Screen      Search Screen
//*
//*   How to impletment bloc in this
//*
//*
