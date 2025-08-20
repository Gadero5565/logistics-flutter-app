import 'package:equatable/equatable.dart';

class EmployeeProfile extends Equatable {
  final int employeeId;
  final String name;
  final String jobTitle;
  final String department;
  final String workPhone;
  final String workEmail;
  final String marital;
  final String country;
  final String identificationId;
  final String passportId;
  final String gender;
  final String birthday;
  final String visaNo;
  final String certificate;
  final String studyField;
  final String imageUrl;
  final String manager;

  const EmployeeProfile({
    required this.employeeId,
    required this.name,
    required this.jobTitle,
    required this.department,
    required this.workPhone,
    required this.workEmail,
    required this.marital,
    required this.country,
    required this.identificationId,
    required this.passportId,
    required this.gender,
    required this.birthday,
    required this.visaNo,
    required this.certificate,
    required this.studyField,
    required this.imageUrl,
    required this.manager,
  });

  @override
  List<Object?> get props => [
    employeeId,
    name,
    jobTitle,
    department,
    workPhone,
    workEmail,
    marital,
    country,
    identificationId,
    passportId,
    gender,
    birthday,
    visaNo,
    certificate,
    studyField,
    manager,
    imageUrl,
  ];
}
