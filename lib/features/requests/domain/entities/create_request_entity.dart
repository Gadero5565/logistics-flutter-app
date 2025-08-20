import 'package:equatable/equatable.dart';

class CreateRequestEntity extends Equatable {
  final int categoryId;
  final int typeId;
  final String requestText;
  final String priority;

  const CreateRequestEntity({
    required this.categoryId,
    required this.typeId,
    required this.requestText,
    required this.priority,
  });

  @override
  List<Object?> get props => [categoryId, typeId, requestText, priority];
}

class CreatedRequest extends Equatable {
  final int requestId;
  final String requestCode;

  const CreatedRequest({required this.requestId, required this.requestCode});

  @override
  List<Object?> get props => [requestId, requestCode];
}
