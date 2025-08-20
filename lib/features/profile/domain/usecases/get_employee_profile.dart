import 'package:dartz/dartz.dart';
import 'package:logistics_app/features/profile/domain/repositories/employee_repository.dart';

import '../../../../core/error/failures.dart';
import '../entities/employee_profile_entity.dart';

class GetEmployeeProfileUseCase {
  final EmployeeRepository repository;

  GetEmployeeProfileUseCase({required this.repository});

  Future<Either<Failure, EmployeeProfile>> call({required int userId}) async {
    return await repository.getEmployeeProfile(userId: userId);
  }

}