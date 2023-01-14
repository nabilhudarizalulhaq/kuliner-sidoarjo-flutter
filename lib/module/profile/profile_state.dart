part of 'profile_bloc.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileIsLogin extends ProfileState {

  String token;
  ProfileIsLogin(this.token);

  @override
  List<Object> get props => [token];
}

class ProfileIsNotLogin extends ProfileState {

  @override
  List<Object> get props => [];
}

class ProfileLoading extends ProfileState {
  @override
  List<Object> get props => [];
}

class ProfileLoaded extends ProfileState {

  ProfileModel profileModel;
  ProfileLoaded(this.profileModel);

  @override
  List<Object> get props => [profileModel];
}

class ProfileNotLoaded extends ProfileState {

  String message;
  ProfileNotLoaded(this.message);

  @override
  List<Object> get props => [message];
}
