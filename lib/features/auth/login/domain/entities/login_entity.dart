import 'package:equatable/equatable.dart';

class LoginEntity extends Equatable {
  final String email;
  final String password;

  const LoginEntity({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class LoginResEntity extends Equatable {
  final int userId;
  final String secToken;

  const LoginResEntity({required this.userId, required this.secToken});

  @override
  List<Object?> get props => [userId, secToken];
}
