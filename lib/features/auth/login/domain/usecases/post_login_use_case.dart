import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../entities/login_entity.dart';
import '../repositories/auth_repositories.dart';

class PostLoginUseCase {
  final AuthRepositories authRepositories;

  PostLoginUseCase({required this.authRepositories});
  Future<Either<Failure, LoginResEntity>> call(LoginEntity loginEntity) async {
    return await authRepositories.postLogin(loginEntity);
  }
}
