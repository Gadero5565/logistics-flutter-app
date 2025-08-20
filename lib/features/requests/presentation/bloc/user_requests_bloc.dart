import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failure_messages.dart';
import '../../domain/entities/request_entity.dart';
import '../../domain/usecases/get_user_requests.dart';

part 'user_requests_event.dart';

part 'user_requests_state.dart';

class UserRequestsBloc extends Bloc<UserRequestsEvent, UserRequestsState> {
  final GetUserRequestsUseCase getUserRequestsUseCase;

  static UserRequestsBloc get(context) => BlocProvider.of(context);

  UserRequestsBloc({required this.getUserRequestsUseCase}) : super(UserRequestsInitial()) {
    on<GetUserRequestsEvent>(_handleGetUserRequests);
    on<RefreshUserRequestsEvent>(_handleRefreshUserRequests);
  }

  Future<void> _handleGetUserRequests(
      GetUserRequestsEvent event,
      Emitter<UserRequestsState> emit,
      ) async {
    await _loadRequests(event.userId, emit);
  }

  Future<void> _handleRefreshUserRequests(
      RefreshUserRequestsEvent event,
      Emitter<UserRequestsState> emit,
      ) async {
    await _loadRequests(event.userId, emit);
  }

  Future<void> _loadRequests(
      int userId,
      Emitter<UserRequestsState> emit,
      ) async {
    emit(LoadingUserRequestsState());

    final failureOrResponse = await getUserRequestsUseCase.call(
      userId: userId,
    );

    failureOrResponse.fold(
          (failure) {
        emit(ErrorUserRequestsState(
          message: FailuresMessage().mapFailureToMessage(failure),
        ));
      },
          (requests) {
        emit(LoadedUserRequestsState(requests: requests));
      },
    );
  }
}
