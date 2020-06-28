import 'package:chat_app/home/search/bloc/search_bloc.dart';
import 'package:chat_app/models/search_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchItemsScreen extends StatefulWidget {
  @override
  _SearchItemsScreenState createState() => _SearchItemsScreenState();
}

class _SearchItemsScreenState extends State<SearchItemsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state is SearchInitial || state is SearchLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is SearchLoaded) {
          return _buildSearchedItems(state.searchUser);
        }
      },
    );
  }

  ListView _buildSearchedItems(List<SearchUser> searchUser) {
    print(searchUser.length);
    return ListView.builder(
      itemCount: searchUser.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            _moveToChatRoom(searchUser[index]);
          },
          child: ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(searchUser[index].username),
                Text(
                  searchUser[index].email,
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _moveToChatRoom(SearchUser searchedUser) {
    Navigator.of(context).pop();
  }
}
