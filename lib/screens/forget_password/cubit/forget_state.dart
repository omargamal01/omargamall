part of 'forget_cubit.dart';

@immutable
abstract class ForgetState {}

class ForgetInitial extends ForgetState {}


class ResetPasswordLoading extends ForgetState {}
class ResetPasswordSuccess extends ForgetState {}
class ResetPasswordError extends ForgetState {
  final String error;
  ResetPasswordError(this.error);
}
