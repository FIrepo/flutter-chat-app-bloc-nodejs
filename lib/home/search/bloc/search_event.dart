part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
}

class SearchStartedFindingAll extends SearchEvent {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

// class SearchFindAllCompleted extends SearchEvent {
//   @override
//   // TODO: implement props
//   List<Object> get props => throw UnimplementedError();
// }
