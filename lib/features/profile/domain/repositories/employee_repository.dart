import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/employee_profile_entity.dart';

abstract class EmployeeRepository {
  Future<Either<Failure, EmployeeProfile>> getEmployeeProfile({required int userId});
}