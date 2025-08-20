part of 'employee_profile_bloc.dart';

sealed class EmployeeProfileState extends Equatable {
  const EmployeeProfileState();
}

final class EmployeeProfileInitial extends EmployeeProfileState {
  @override
  List<Object> get props => [];
}

class LoadingEmployeeProfileState extends EmployeeProfileState {
  @override
  List<Object?> get props => [];
}

class LoadedEmployeeProfileState extends EmployeeProfileState {
  final EmployeeProfile profile;

  const LoadedEmployeeProfileState({required this.profile});

  @override
  List<Object?> get props => [profile];
}

class ErrorEmployeeProfileState extends EmployeeProfileState {
  final String message;

  const ErrorEmployeeProfileState({required this.message});

  @override
  List<Object> get props => [message];
}
