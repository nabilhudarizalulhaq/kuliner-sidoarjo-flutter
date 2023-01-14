part of 'favorite_bloc.dart';

@immutable
abstract class FavoriteState {}

class FavoriteInitial extends FavoriteState {}

class FavoriteIsLogin extends FavoriteState {

  String token;
  FavoriteIsLogin(this.token);

  @override
  List<Object> get props => [token];
}

class FavoriteIsNotLogin extends FavoriteState {

  @override
  List<Object> get props => [];
}

class FavoriteLoading extends FavoriteState {
  @override
  List<Object> get props => [];
}

class FavoriteLoaded extends FavoriteState {

  FavoriteModel favoriteModel;
  FavoriteLoaded(this.favoriteModel);

  @override
  List<Object> get props => [favoriteModel];
}

class FavoriteNotLoaded extends FavoriteState {

  String message;
  FavoriteNotLoaded(this.message);

  @override
  List<Object> get props => [message];
}

class FavoriteDeleted extends FavoriteState {

  String message;
  FavoriteDeleted(this.message);

  @override
  List<Object> get props => [message];
}
