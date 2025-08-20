part of 'dashboard_bloc.dart';

sealed class DashboardState extends Equatable {
  const DashboardState();
}

final class DashboardInitial extends DashboardState {
  @override
  List<Object> get props => [];
}

class LoadingDashboardState extends DashboardState {
  @override
  List<Object?> get props => [];
}

class LoadedDashboardState extends DashboardState {
  @override
  List<Object?> get props => [];
}

class ErrorDashboardState extends DashboardState {
  final String message;

  const ErrorDashboardState({required this.message});

  @override
  List<Object> get props => [message];
}
