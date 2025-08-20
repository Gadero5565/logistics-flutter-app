import '../../domain/entities/employee_profile_entity.dart';

class EmployeeProfileModel extends EmployeeProfile {
  const EmployeeProfileModel({
    required int employeeId,
    required String name,
    required String jobTitle,
    required String department,
    required String workPhone,
    required String workEmail,
    required String marital,
    required String country,
    required String identificationId,
    required String passportId,
    required String gender,
    required String birthday,
    required String visaNo,
    required String certificate,
    required String studyField,
    required String imageUrl,
    required String manager,
  }) : super(
    employeeId: employeeId,
    name: name,
    jobTitle: jobTitle,
    department: department,
    workPhone: workPhone,
    workEmail: workEmail,
    marital: marital,
    country: country,
    identificationId: identificationId,
    passportId: passportId,
    gender: gender,
    birthday: birthday,
    visaNo: visaNo,
    certificate: certificate,
    studyField: studyField,
    imageUrl: imageUrl,
    manager: manager,
  );

  factory EmployeeProfileModel.fromJson(Map<String, dynamic> json) {
    return EmployeeProfileModel(
      employeeId: json['employee_id'] as int, // ← Ensure correct type
      name: json['name'] as String,
      jobTitle: json['job_title'] as String,
      department: json['department'] as String,
      workPhone: json['work_phone'] as String,
      workEmail: json['work_email'] as String,
      marital: json['marital'] as String,
      country: json['country'] as String,
      identificationId: json['identification_id'] as String,
      passportId: json['passport_id'] as String,
      gender: json['gender'] as String,
      birthday: json['birthday'] as String,
      visaNo: json['visa_no'] as String,
      certificate: json['certificate'] as String,
      studyField: json['study_field'] as String,
      imageUrl: json['image_url'] as String,
      manager: json['manager'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'employee_id': employeeId,
    'name': name,
    'job_title': jobTitle,
    'department': department,
    'work_phone': workPhone,
    'work_email': workEmail,
    'marital': marital,
    'country': country,
    'identification_id': identificationId,
    'passport_id': passportId,
    'gender': gender,
    'birthday': birthday,
    'visa_no': visaNo,
    'certificate': certificate,
    'study_field': studyField,
    'image_url': imageUrl,
    'manager': manager,
  };
}