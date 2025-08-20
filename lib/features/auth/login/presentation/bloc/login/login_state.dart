part of 'login_bloc.dart';

sealed class LoginState extends Equatable {
  const LoginState();
  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class LoadingLoginState extends LoginState {}

class LoadedLoginState extends LoginState {}

class ErrorLoginState extends LoginState {
  final String error;

  const ErrorLoginState({required this.error});
  @override
  List<Object> get props => [error];
}
