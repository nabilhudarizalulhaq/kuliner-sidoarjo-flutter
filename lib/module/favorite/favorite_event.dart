part of 'favorite_bloc.dart';

@immutable
abstract class FavoriteEvent {}

class CheckLoginEvent extends FavoriteEvent {

  @override
  List<Object?> get props => [];
}

class GetFavoriteEvent extends FavoriteEvent {

  String token;
  GetFavoriteEvent(this.token);

  @override
  List<Object?> get props => [token];
}

class DeleteFavoriteEvent extends FavoriteEvent {

  int placeId;
  DeleteFavoriteEvent(this.placeId);

  @override
  List<Object> get props => [placeId];
}
