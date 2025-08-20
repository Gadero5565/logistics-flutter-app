import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/create_request_entity.dart';
import '../repositories/request_repository.dart';

class CreateRequestUseCase {
  final RequestRepository repository;

  CreateRequestUseCase({required this.repository});

  Future<Either<Failure, CreatedRequest>> call({
    required int userId,
    required CreateRequestEntity request,
  }) async {
    return await repository.createRequest(userId: userId, request: request);
  }
}
