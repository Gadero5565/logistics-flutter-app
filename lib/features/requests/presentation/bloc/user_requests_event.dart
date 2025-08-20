part of 'user_requests_bloc.dart';

sealed class UserRequestsEvent extends Equatable {
  const UserRequestsEvent();
}

class GetUserRequestsEvent extends UserRequestsEvent {
  final int userId;
  const GetUserRequestsEvent({required this.userId});

  @override
  List<Object?> get props => [userId];
}

class RefreshUserRequestsEvent extends UserRequestsEvent {
  final int userId;
  const RefreshUserRequestsEvent({required this.userId});

  @override
  List<Object?> get props => [userId];
}