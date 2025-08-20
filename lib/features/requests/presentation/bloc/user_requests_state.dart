part of 'user_requests_bloc.dart';

sealed class UserRequestsState extends Equatable {
  const UserRequestsState();
}

final class UserRequestsInitial extends UserRequestsState {
  @override
  List<Object> get props => [];
}

class LoadingUserRequestsState extends UserRequestsState {
  @override
  List<Object?> get props => [];
}

class LoadedUserRequestsState extends UserRequestsState {
  final List<RequestEntity> requests;

  const LoadedUserRequestsState({required this.requests});

  @override
  List<Object?> get props => [requests];
}

class ErrorUserRequestsState extends UserRequestsState {
  final String message;

  const ErrorUserRequestsState({required this.message});

  @override
  List<Object> get props => [message];
}
