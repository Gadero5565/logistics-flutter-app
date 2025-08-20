part of 'dashboard_bloc.dart';

sealed class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object?> get props => [];
}

class GetDashboardDataEvent extends DashboardEvent {
  final int userId;

  GetDashboardDataEvent({required this.userId});

  @override
  List<Object?> get props => [userId];
}
