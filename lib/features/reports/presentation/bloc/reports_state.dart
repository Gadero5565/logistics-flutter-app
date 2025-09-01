// features/reports/presentation/bloc/reports_state.dart
part of 'reports_bloc.dart';

sealed class ReportsState extends Equatable {
  const ReportsState();
}

final class ReportsInitial extends ReportsState {
  @override
  List<Object> get props => [];
}

class LoadingReportsState extends ReportsState {
  @override
  List<Object?> get props => [];
}

class LoadedReportsState extends ReportsState {
  final DashboardEntity dashboardData;

  const LoadedReportsState({required this.dashboardData});

  @override
  List<Object?> get props => [dashboardData];
}

class ErrorReportsState extends ReportsState {
  final String message;

  const ErrorReportsState({required this.message});

  @override
  List<Object> get props => [message];
}