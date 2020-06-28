import 'package:chat_app/home/search/bloc/search_bloc.dart';
import 'package:chat_app/home/search/search_items_screen.dart';
import 'package:chat_app/models/user.dart';
import 'package:chat_app/repository/search_user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  final User user;

  SearchScreen(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Search Screen'),
        ),
        body: BlocProvider(
          create: (context) => SearchBloc(SearchUserRepository(user))
            ..add(SearchStartedFindingAll()),
          child: SearchItemsScreen(),
        ));
  }
}
