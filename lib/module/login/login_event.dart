part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class UserLoginEvent extends LoginEvent {
  String email;
  String password;

  UserLoginEvent(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}
