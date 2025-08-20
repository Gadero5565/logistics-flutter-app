import 'package:equatable/equatable.dart';

import '../../../dashboard/domain/entities/dashboard_entity.dart';

class CategoryWithTypesEntity extends Equatable {
  final int categoryId;
  final String categoryName;
  final int requestCount;
  final List<RequestsTypes> types;

  const CategoryWithTypesEntity({required this.categoryId, required this.categoryName, required this.requestCount, required this.types});


  @override
  List<Object?> get props => [categoryId, categoryName, requestCount, types];

}