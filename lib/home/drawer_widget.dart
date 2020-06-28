import 'package:chat_app/authentication/bloc/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
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
    );
  }
}
