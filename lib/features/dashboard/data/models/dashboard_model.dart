import 'package:logistics_app/features/dashboard/domain/entities/dashboard_entity.dart';

class DashboardCardsModel extends DashboardCardsEntity {
  const DashboardCardsModel({
    required super.cardIntValue,
    required super.cardName,
  });

  factory DashboardCardsModel.fromJson(Map<String, dynamic> json) {
    final cardIntValue = json['card_int_val'];
    final cardName = json['card_name'].toString();

    return DashboardCardsModel(cardIntValue: cardIntValue, cardName: cardName);
  }
}

class RequestsTypesModel extends RequestsTypes {
  const RequestsTypesModel({required super.id, required super.typeName});

  factory RequestsTypesModel.fromJson(Map<String, dynamic> json) {
    final id = json['id'];
    final typeName = json['name'];

    return RequestsTypesModel(id: id, typeName: typeName);
  }
}

class CategoryCountModel extends CategoryEntity {
  const CategoryCountModel({
    required super.categoryId,
    required super.categoryName,
    required super.requestCount,
  });

  factory CategoryCountModel.fromJson(Map<String, dynamic> json) {
    return CategoryCountModel(
      categoryId: json['category_id'] as int,
      categoryName: json['category_name'] as String,
      requestCount: json['request_count'] as int,
    );
  }
}

class DashboardModel extends DashboardEntity {
  const DashboardModel({
    required super.dashboardCards,
    required super.requestsTypes,
    required super.categoryCounts,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    final dashboardCardsListData = json['dashboard_cards_details'] as List;
    final dashboardCardsList = dashboardCardsListData
        .map((e) => DashboardCardsModel.fromJson(e))
        .toList();
    final requestsTypesListData = json['requests_types'] as List;
    final requestsTypesList = requestsTypesListData
        .map((e) => RequestsTypesModel.fromJson(e))
        .toList();
    final categoryCountsListData = json['category_counts'] as List;
    final categoryCountsList = categoryCountsListData
        .map((e) => CategoryCountModel.fromJson(e))
        .toList();

    return DashboardModel(
      dashboardCards: dashboardCardsList,
      requestsTypes: requestsTypesList,
      categoryCounts: categoryCountsList, // Add new field
    );
  }
}
