part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class GetPlaceEvent extends HomeEvent {

  String keyword;
  GetPlaceEvent(this.keyword);

  @override
  List<Object?> get props => [keyword];
}

class NoInternetEvent extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class AddFavoriteEvent extends HomeEvent {

  int placeId;
  AddFavoriteEvent(this.placeId);

  @override
  List<Object> get props => [placeId];
}

class SearchPlaceEvent extends HomeEvent {

  String keyword;
  SearchPlaceEvent(this.keyword);

  @override
  List<Object?> get props => [keyword];
}
