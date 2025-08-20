import 'package:logistics_app/features/requests/domain/entities/request_entity.dart';

import '../../../dashboard/domain/entities/dashboard_entity.dart';

class RequestModel extends RequestEntity {
  const RequestModel({
    required super.requestId,
    required super.requestSequence,
    required super.requestsType,
    required super.categoryEntity,
    required super.requestText,
    required super.status,
    required super.dateTime,
    required super.requestPriority,
  });

  factory RequestModel.fromJson(Map<String, dynamic> json) {
    // Map API status to your status values
    String mapStatus(String stageType) {
      switch (stageType) {
        case 'draft':
          return 'Pending';
        case 'assigned':
          return 'In Progress';
        case 'done':
          return 'Completed';
        default:
          return stageType;
      }
    }

    // Map priority
    final priority = json['priority']?.toString() ?? 'Not Set';

    return RequestModel(
      requestId: json['id'] as int? ?? 0,
      requestSequence: json['name'] as String? ?? "",
      requestsType: RequestsTypes(
        id: 0, // Not in API - use dummy value
        typeName: json['type'] as String? ?? '',
      ),
      categoryEntity: CategoryEntity(
        categoryId: 0, // Not in API - use dummy value
        categoryName: json['category'] as String? ?? '',
        requestCount: 0, // Not in API
      ),
      status: mapStatus(json['stage_type'] as String? ?? ''),
      requestText: mapStatus(json['request_text'] as String? ?? ''),
      dateTime: DateTime.parse(json['date_request'] as String? ?? DateTime.now().toString()),
      requestPriority: RequestPriority(
        priorityNum: priority == 'Very High' ? 4 : priority == 'High' ? 3 : 0,
        priorityType: priority,
      ),
    );
  }
}
