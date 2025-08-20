import '../../domain/entities/create_request_entity.dart';

class CreateRequestModel extends CreateRequestEntity {
  const CreateRequestModel({
    required super.categoryId,
    required super.typeId,
    required super.requestText,
    super.priority = "0",
  });

  Map<String, dynamic> toJson() => {
    "category_id": categoryId,
    "type_id": typeId,
    "request_text": requestText,
    "priority": priority,
  };
}

class CreatedRequestModel extends CreatedRequest {
  const CreatedRequestModel({
    required super.requestId,
    required super.requestCode,
  });

  factory CreatedRequestModel.fromJson(Map<String, dynamic> json) {
    return CreatedRequestModel(
      requestId: (json['request_id'] ?? 0) as int,
      requestCode: (json['request_code'] ?? '') as String,
    );
  }
}