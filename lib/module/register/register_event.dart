part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent {}

class UserRegisterEvent extends RegisterEvent {
  String name;
  String email;
  String password;
  String passwordConfirmation;

  UserRegisterEvent(this.name, this.email, this.password, this.passwordConfirmation);

  @override
  List<Object?> get props => [name, email, password, passwordConfirmation];
}
