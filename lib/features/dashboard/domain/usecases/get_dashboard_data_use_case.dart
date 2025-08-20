import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/dashboard_entity.dart';
import '../repositories/dashboard_repository.dart';

class GetDashboardDataUseCase {
  final DashboardRepository repository;

  GetDashboardDataUseCase({required this.repository});

  Future<Either<Failure, DashboardEntity>> call({required int userId}) async {
    return await repository.getDashboardData(userId: userId);
  }
}
