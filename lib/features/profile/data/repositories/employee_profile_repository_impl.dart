import 'package:dartz/dartz.dart';
import 'package:logistics_app/core/error/failures.dart';
import 'package:logistics_app/features/profile/domain/entities/employee_profile_entity.dart';
import 'package:logistics_app/features/profile/domain/repositories/employee_repository.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../data_source/employee_profile_data_source.dart';

class EmployeeRepositoryImpl implements EmployeeRepository {
  final NetworkInfo networkInfo;
  final EmployeeProfileDataSource employeeProfileDataSource;

  EmployeeRepositoryImpl({
    required this.networkInfo,
    required this.employeeProfileDataSource,
  });

  @override
  Future<Either<Failure, EmployeeProfile>> getEmployeeProfile({
    required int userId,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await employeeProfileDataSource.getEmployeeProfile(
          userId: userId,
        );
        return Right(response);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
