import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failure_messages.dart';
import '../../../domain/entities/create_request_entity.dart';
import '../../../domain/usecases/create_request_usecase.dart';

part 'create_request_event.dart';
part 'create_request_state.dart';

class CreateRequestBloc extends Bloc<CreateRequestEvent, CreateRequestState> {
  final CreateRequestUseCase createRequestUseCase;

  CreateRequestBloc({required this.createRequestUseCase}) : super(CreateRequestInitial()) {
    on<CreateNewRequestEvent>((event, emit) async {
      emit(CreateRequestLoading());
      final result = await createRequestUseCase(
        userId: event.userId,
        request: event.request,
      );
      result.fold(
            (failure) => emit(CreateRequestError(
          message: FailuresMessage().mapFailureToMessage(failure),
        )),
            (createdRequest) => emit(CreateRequestSuccess(createdRequest)),
      );
    });
  }
}
