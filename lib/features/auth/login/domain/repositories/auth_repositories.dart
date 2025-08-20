import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../entities/login_entity.dart';

abstract class AuthRepositories {
  Future<Either<Failure, LoginResEntity>> postLogin(LoginEntity loginEntity);
}
