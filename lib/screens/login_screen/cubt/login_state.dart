part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}


class LoginLoadingState extends LoginState {}
class LoginSuccessState extends LoginState {
  final bool isDataExists;
  final bool isAdmin;
  LoginSuccessState(this.isDataExists, this.isAdmin);
}
class LoginFailureState extends LoginState {
  final String error;

  LoginFailureState(this.error);
}

