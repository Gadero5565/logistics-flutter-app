import '../../../dashboard/data/models/dashboard_model.dart';
import '../../domain/entities/category_with_types.dart';

class CategoryWithTypesModel extends CategoryWithTypesEntity {
  const CategoryWithTypesModel({
    required super.categoryId,
    required super.categoryName,
    required super.types,
    required super.requestCount,
  });

  factory CategoryWithTypesModel.fromJson(Map<String, dynamic> json) {
    return CategoryWithTypesModel(
      categoryId: json['id'] as int,
      categoryName: json['name'] as String,
      requestCount: json['request_count'] as int,
      types: (json['types'] as List)
          .map((typeJson) => RequestsTypesModel.fromJson(typeJson))
          .toList(),
    );
  }
}