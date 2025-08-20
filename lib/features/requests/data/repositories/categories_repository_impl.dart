import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/category_with_types.dart';
import '../../domain/repositories/categories_repository.dart';
import '../data_source/categories_data_source.dart';

class CategoriesRepositoryImpl implements CategoriesRepository {
  final NetworkInfo networkInfo;
  final CategoriesDataSource dataSource;

  CategoriesRepositoryImpl({
    required this.networkInfo,
    required this.dataSource,
  });

  @override
  Future<Either<Failure, List<CategoryWithTypesEntity>>> getCategoriesWithTypes() async {
    if (await networkInfo.isConnected) {
      try {
        final response = await dataSource.getCategoriesWithTypes();
        return Right(response);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}