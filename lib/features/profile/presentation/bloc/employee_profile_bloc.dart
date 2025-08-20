import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logistics_app/features/profile/domain/usecases/get_employee_profile.dart';

import '../../../../core/error/failure_messages.dart';
import '../../domain/entities/employee_profile_entity.dart';

part 'employee_profile_event.dart';

part 'employee_profile_state.dart';

class EmployeeProfileBloc
    extends Bloc<EmployeeProfileEvent, EmployeeProfileState> {
  final GetEmployeeProfileUseCase getEmployeeProfileUseCase;

  EmployeeProfileBloc({required this.getEmployeeProfileUseCase})
    : super(EmployeeProfileInitial()) {
    on<EmployeeProfileEvent>((event, emit) async {
      if (event is FetchEmployeeProfile) {
        emit(LoadingEmployeeProfileState());
        final failureOrResponse = await getEmployeeProfileUseCase.call(
          userId: event.userId,
        );
        failureOrResponse.fold(
          (failure) {
            emit(
              ErrorEmployeeProfileState(
                message: FailuresMessage().mapFailureToMessage(failure),
              ),
            );
          },
          (response) {
            emit(LoadedEmployeeProfileState(profile: response));
          },
        );
      }
    });
  }
}
