// features/reports/presentation/bloc/reports_event.dart
part of 'reports_bloc.dart';

sealed class ReportsEvent extends Equatable {
  const ReportsEvent();

  @override
  List<Object?> get props => [];
}

class GetReportsDataEvent extends ReportsEvent {
  final int userId;

  const GetReportsDataEvent({required this.userId});

  @override
  List<Object?> get props => [userId];
}