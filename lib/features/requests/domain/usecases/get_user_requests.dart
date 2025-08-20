import 'package:dartz/dartz.dart';
import 'package:logistics_app/features/requests/domain/repositories/request_repository.dart';

import '../../../../core/error/failures.dart';
import '../entities/request_entity.dart';

class GetUserRequestsUseCase {
  final RequestRepository repository;

  GetUserRequestsUseCase({required this.repository});

  Future<Either<Failure, List<RequestEntity>>> call({required int userId}) async {
    return await repository.getUserRequests(userId: userId);
  }
}
