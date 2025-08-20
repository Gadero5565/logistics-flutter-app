part of 'employee_profile_bloc.dart';

sealed class EmployeeProfileEvent extends Equatable {
  const EmployeeProfileEvent();
}

class FetchEmployeeProfile extends EmployeeProfileEvent {
  final int userId;

  const FetchEmployeeProfile({required this.userId});

  @override
  List<Object> get props => [userId];
}