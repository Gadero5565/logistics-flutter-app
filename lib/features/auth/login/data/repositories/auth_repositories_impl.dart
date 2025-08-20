import 'package:dartz/dartz.dart';
import '../../../../../core/error/exceptions.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/network/network_info.dart';
import '../../domain/entities/login_entity.dart';
import '../../domain/repositories/auth_repositories.dart';
import '../datasources/auth_date_source.dart';
import '../models/login_model.dart';

class AuthRepositoriesImpl implements AuthRepositories {
  final NetworkInfo networkInfo;
  final AuthDataSource authDataSource;

  AuthRepositoriesImpl(
      {required this.networkInfo, required this.authDataSource});

  @override
  Future<Either<Failure, LoginResEntity>> postLogin(
      LoginEntity loginEntity) async {
    final loginModel =
        LoginModel(email: loginEntity.email, password: loginEntity.password);
    try {
      final postLogin = await authDataSource.postLogin(loginModel);

      return Right(postLogin);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
