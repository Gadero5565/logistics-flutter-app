import 'package:equatable/equatable.dart';

class DashboardCardsEntity extends Equatable {
  final String cardName;
  final int cardIntValue;

  const DashboardCardsEntity({
    required this.cardName,
    required this.cardIntValue,
  });

  @override
  List<Object?> get props => [cardName, cardIntValue];
}

class RequestsTypes extends Equatable {
  final int id;
  final String typeName;

  const RequestsTypes({required this.id, required this.typeName});

  @override
  List<Object?> get props => [id, typeName];
}

class CategoryEntity extends Equatable {
  final int categoryId;
  final String categoryName;
  final int requestCount;

  const CategoryEntity({
    required this.categoryId,
    required this.categoryName,
    required this.requestCount,
  });

  @override
  List<Object> get props => [categoryId, categoryName, requestCount];
}

class DashboardEntity extends Equatable {
  final List<DashboardCardsEntity> dashboardCards;
  final List<RequestsTypes> requestsTypes;
  final List<CategoryEntity> categoryCounts;

  const DashboardEntity({
    required this.requestsTypes,
    required this.dashboardCards,
    required this.categoryCounts,
  });

  @override
  List<Object?> get props => [dashboardCards, requestsTypes, categoryCounts];
}
