part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();
  @override
  List<Object> get props => [];
}

class PostLoginEvent extends LoginEvent {
  final String password;
  final String email;

  const PostLoginEvent({required this.email, required this.password});
  @override
  List<Object> get props => [email, password];
}
