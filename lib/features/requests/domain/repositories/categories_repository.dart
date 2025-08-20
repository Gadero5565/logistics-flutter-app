import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/category_with_types.dart';

abstract class CategoriesRepository {
  Future<Either<Failure, List<CategoryWithTypesEntity>>> getCategoriesWithTypes();
}