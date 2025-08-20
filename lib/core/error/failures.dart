import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class ServerFailure extends Failure {

  @override
  List<Object?> get props => [];
}

class CacheFailure extends Failure {

  @override
  List<Object?> get props => [];
}

class NetworkFailure extends Failure {

  @override
  List<Object?> get props => [];
}

class AuthFailure extends Failure {

  @override
  List<Object?> get props => [];
}

class ValidationFailure extends Failure {

  @override
  List<Object?> get props => [];
}

class LocationFailure extends Failure {

  @override
  List<Object?> get props => [];
}

class PermissionFailure extends Failure {

  @override
  List<Object?> get props => [];
}
