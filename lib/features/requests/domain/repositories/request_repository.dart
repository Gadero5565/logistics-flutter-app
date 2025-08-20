import 'package:dartz/dartz.dart';
import 'package:logistics_app/features/requests/domain/entities/request_entity.dart';

import '../../../../core/error/failures.dart';
import '../entities/create_request_entity.dart';

abstract class RequestRepository {
  Future<Either<Failure,List<RequestEntity>>> getUserRequests({required int userId});

  Future<Either<Failure, CreatedRequest>> createRequest({
    required int userId,
    required CreateRequestEntity request,
  });

}