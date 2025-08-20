part of 'create_request_bloc.dart';

sealed class CreateRequestEvent extends Equatable {
  const CreateRequestEvent();
}

class CreateNewRequestEvent extends CreateRequestEvent {
  final int userId;
  final CreateRequestEntity request;

  const CreateNewRequestEvent({
    required this.userId,
    required this.request,
  });

  @override
  List<Object?> get props => [userId, request];
}
