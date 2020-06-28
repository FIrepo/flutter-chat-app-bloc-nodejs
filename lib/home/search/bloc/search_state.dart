part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();
}

class SearchInitial extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchLoading extends SearchState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class SearchLoaded extends SearchState {
  final List<SearchUser> searchUser;
  const SearchLoaded(this.searchUser);
  @override
  List<Object> get props => [searchUser];
}
