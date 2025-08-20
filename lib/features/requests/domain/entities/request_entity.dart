import 'package:equatable/equatable.dart';
import 'package:logistics_app/features/dashboard/domain/entities/dashboard_entity.dart';

class RequestPriority extends Equatable {
  final int priorityNum;
  final String priorityType;

  const RequestPriority({
    required this.priorityNum,
    required this.priorityType,
  });

  @override
  List<Object?> get props => [priorityNum, priorityType];
}

class RequestEntity extends Equatable {
  final int requestId;
  final String requestSequence;
  final RequestsTypes requestsType;
  final CategoryEntity categoryEntity;
  final String status;
  final String requestText;
  final DateTime dateTime;
  final RequestPriority requestPriority;

  const RequestEntity({
    required this.requestId,
    required this.requestSequence,
    required this.requestText,
    required this.requestsType,
    required this.categoryEntity,
    required this.status,
    required this.dateTime,
    required this.requestPriority,
  });

  @override
  List<Object?> get props => [
    requestId,
    requestSequence,
    requestsType,
    requestText,
    status,
    categoryEntity,
    dateTime,
    requestPriority,
  ];
}
