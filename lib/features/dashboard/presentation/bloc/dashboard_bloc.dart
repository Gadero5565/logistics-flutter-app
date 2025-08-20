import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logistics_app/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:logistics_app/features/dashboard/domain/usecases/get_dashboard_data_use_case.dart';

import '../../../../core/error/failure_messages.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final GetDashboardDataUseCase getDashboardDataUseCase;

  static DashboardBloc get(context) => BlocProvider.of(context);

  List<DashboardCardsEntity> dashboardCardsList = [];
  List<RequestsTypes> requestsTypesList = [];
  List<CategoryEntity> categoryCountsList = []; // Add new field

  DashboardBloc({required this.getDashboardDataUseCase})
      : super(DashboardInitial()) {
    on<DashboardEvent>((event, emit) async {
      if (event is GetDashboardDataEvent) {
        emit(LoadingDashboardState());

        final failureOrResponse = await getDashboardDataUseCase.call(userId: event.userId);
        failureOrResponse.fold(
              (failure) {
            emit(
              ErrorDashboardState(
                message: FailuresMessage().mapFailureToMessage(failure),
              ),
            );
          },
              (response) {
            dashboardCardsList = response.dashboardCards;
            requestsTypesList = response.requestsTypes;
            categoryCountsList = response.categoryCounts; // Store category counts
            emit(LoadedDashboardState());
          },
        );
      }
    });
  }
}