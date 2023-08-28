part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {}

final class LoginFauiler extends LoginState {
  final String eMessage;

  LoginFauiler({required this.eMessage});
}
