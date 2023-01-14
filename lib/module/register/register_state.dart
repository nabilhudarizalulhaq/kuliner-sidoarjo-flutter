part of 'register_bloc.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {
  @override
  List<Object> get props => [];
}

class RegisterLoaded extends RegisterState {

  RegisterModel registerModel;
  RegisterLoaded(this.registerModel);

  @override
  List<Object> get props => [registerModel];
}

class RegisterNotLoaded extends RegisterState {

  String message;
  RegisterNotLoaded(this.message);

  @override
  List<Object> get props => [message];
}
