part of 'register_cubit.dart';

@immutable
sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}

final class RegisterLoding extends RegisterState {}

final class RegisterSuccess extends RegisterState {}

final class RegisterFauiler extends RegisterState {
  final String eMessage;

  RegisterFauiler({required this.eMessage});
}
