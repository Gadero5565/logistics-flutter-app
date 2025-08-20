import 'package:dartz/dartz.dart';
import 'package:logistics_app/core/error/failures.dart';
import 'package:logistics_app/features/requests/domain/entities/create_request_entity.dart';
import 'package:logistics_app/features/requests/domain/entities/request_entity.dart';
import 'package:logistics_app/features/requests/domain/repositories/request_repository.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../data_source/create_request_data_source.dart';
import '../data_source/user_requests_data_source.dart';
import '../models/create_request_model.dart';

class UserRequestsRepositoryImpl implements RequestRepository {
  final NetworkInfo networkInfo;
  final UserRequestsDataSource userRequestsDataSource;
  final CreateRequestDataSource createRequestDataSource;

  UserRequestsRepositoryImpl({
    required this.networkInfo,
    required this.createRequestDataSource,
    required this.userRequestsDataSource,
  });

  @override
  Future<Either<Failure, List<RequestEntity>>> getUserRequests({
    required int userId,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await userRequestsDataSource.getUserRequests(
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

  @override
  Future<Either<Failure, CreatedRequest>> createRequest({
    required int userId,
    required CreateRequestEntity request,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final requestModel = CreateRequestModel(
          categoryId: request.categoryId,
          typeId: request.typeId,
          requestText: request.requestText,
          priority: request.priority,
        );

        final response = await createRequestDataSource.createRequest(
          userId: userId,
          request: requestModel,
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
