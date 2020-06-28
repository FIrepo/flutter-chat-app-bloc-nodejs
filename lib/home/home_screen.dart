import 'package:chat_app/authentication/bloc/authentication_bloc.dart';
import 'package:chat_app/home/search/search_screen.dart';
import 'package:chat_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './drawer_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatelessWidget {
  final User user;
  HomeScreen(this.user);

  //* ChatsBloc -- initate here and passing user to it
  //*          \
  //*   InitialState + ChatRoomRepo
  //*            \
  //*      ChatRoomRepo will requrest for chatroom array to server
  //*              \
  //*         On getting array we will change state and all chat rooms tab start creating
  //*                \
  //*
  //*
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
      drawer: DrawerWidget(),
      body: ListView(
        children: <Widget>[],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          FontAwesomeIcons.facebookMessenger,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => SearchScreen(user)));
        },
      ),
    );
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
