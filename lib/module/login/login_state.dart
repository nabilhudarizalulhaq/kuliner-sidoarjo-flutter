part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginLoaded extends LoginState {

  LoginModel loginModel;
  LoginLoaded(this.loginModel);

  @override
  List<Object> get props => [loginModel];
}

class LoginNotLoaded extends LoginState {

  String message;
  LoginNotLoaded(this.message);

  @override
  List<Object> get props => [message];
}
