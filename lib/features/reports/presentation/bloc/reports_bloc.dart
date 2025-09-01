// features/reports/presentation/bloc/reports_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logistics_app/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:logistics_app/features/dashboard/domain/usecases/get_dashboard_data_use_case.dart';
import 'package:logistics_app/core/error/failure_messages.dart';

part 'reports_event.dart';
part 'reports_state.dart';

class ReportsBloc extends Bloc<ReportsEvent, ReportsState> {
  final GetDashboardDataUseCase getDashboardDataUseCase;

  ReportsBloc({required this.getDashboardDataUseCase}) : super(ReportsInitial()) {
    on<GetReportsDataEvent>((event, emit) async {
      emit(LoadingReportsState());
      final failureOrResponse = await getDashboardDataUseCase.call(userId: event.userId);
      failureOrResponse.fold(
            (failure) {
          emit(ErrorReportsState(
            message: FailuresMessage().mapFailureToMessage(failure),
          ));
        },
            (response) {
          emit(LoadedReportsState(dashboardData: response));
        },
      );
    });
  }
}