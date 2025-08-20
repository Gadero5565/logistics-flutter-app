import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/category_with_types.dart';
import '../repositories/categories_repository.dart';

class GetCategoriesWithTypes {
  final CategoriesRepository repository;

  GetCategoriesWithTypes({required this.repository});

  Future<Either<Failure, List<CategoryWithTypesEntity>>> call() async {
    return await repository.getCategoriesWithTypes();
  }
}