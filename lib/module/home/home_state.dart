part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeLoading extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeLoaded extends HomeState {

  PlaceModel placeModel;
  HomeLoaded(this.placeModel);

  @override
  List<Object> get props => [placeModel];
}

class HomeNotLoaded extends HomeState {

  String message;
  HomeNotLoaded(this.message);

  @override
  List<Object> get props => [];
}

class HomeNoInternet extends HomeState {
  @override
  List<Object> get props => [];
}

// class FavoriteAdded extends HomeState {
//
//   String message;
//   FavoriteAdded(this.message);
//
//   @override
//   List<Object> get props => [message];
// }
