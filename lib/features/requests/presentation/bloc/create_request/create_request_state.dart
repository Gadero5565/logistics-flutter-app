part of 'create_request_bloc.dart';

sealed class CreateRequestState extends Equatable {
  const CreateRequestState();
}

final class CreateRequestInitial extends CreateRequestState {
  @override
  List<Object> get props => [];
}

class CreateRequestLoading extends CreateRequestState {
  @override
  List<Object> get props => [];
}

class CreateRequestSuccess extends CreateRequestState {
  final CreatedRequest createdRequest;

  const CreateRequestSuccess(this.createdRequest);

  @override
  List<Object> get props => [createdRequest];
}

class CreateRequestError extends CreateRequestState {
  final String message;

  const CreateRequestError({required this.message});

  @override
  List<Object> get props => [message];
}
