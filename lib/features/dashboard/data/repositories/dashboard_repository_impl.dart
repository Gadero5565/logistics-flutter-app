import 'package:dartz/dartz.dart';
import 'package:logistics_app/core/error/exceptions.dart';

import 'package:logistics_app/core/error/failures.dart';
import 'package:logistics_app/core/network/network_info.dart';
import 'package:logistics_app/features/dashboard/data/data_source/dashboard_data_source.dart';

import 'package:logistics_app/features/dashboard/domain/entities/dashboard_entity.dart';

import '../../domain/repositories/dashboard_repository.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final NetworkInfo networkInfo;
  final DashboardDataSource dashboardDataSource;

  DashboardRepositoryImpl({
    required this.networkInfo,
    required this.dashboardDataSource,
  });

  @override
  Future<Either<Failure, DashboardEntity>> getDashboardData({required int userId}) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await dashboardDataSource.getDashboardData(userId: userId);
        return Right(response);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
