part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {}

class CheckLoginEvent extends ProfileEvent {

  @override
  List<Object?> get props => [];
}

class GetProfileEvent extends ProfileEvent {

  String token;
  GetProfileEvent(this.token);

  @override
  List<Object?> get props => [token];
}

class UserLogoutEvent extends ProfileEvent {

  @override
  List<Object?> get props => [];
}
