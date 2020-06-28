import 'package:bloc/bloc.dart';
import 'package:chat_app/models/search_user.dart';
import 'package:chat_app/models/user.dart';
import 'package:chat_app/repository/search_user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchUserRepository _searchUserRepository;
  SearchBloc(this._searchUserRepository);
  @override
  SearchState get initialState => SearchInitial();

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is SearchStartedFindingAll) {
      yield* _mapSearchStartedFindingAllToState();
    }
  }

  Stream<SearchState> _mapSearchStartedFindingAllToState() async* {
    yield SearchLoading();
    final searchUser = await _searchUserRepository.getAllUser();
    yield SearchLoaded(searchUser);
  }

  Stream<SearchState> _mapSearchFindAllCompletedToState() async* {}
}
