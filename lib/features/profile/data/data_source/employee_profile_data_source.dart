import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/error/exceptions.dart';
import '../../../../core/storage/app_storage.dart';
import '../models/employee_model.dart';

abstract class EmployeeProfileDataSource {
  Future<EmployeeProfileModel> getEmployeeProfile({required int userId});
}

class EmployeeRemoteDataSourceImpl extends EmployeeProfileDataSource {
  final http.Client client;

  EmployeeRemoteDataSourceImpl({required this.client});

  @override
  Future<EmployeeProfileModel> getEmployeeProfile({required int userId}) async {
    final body = json.encode({
      "jsonrpc": "2.0",
      "params": {"user_id": userId, "sec_token": AppStorage().getSecToken()},
    });
    final response = await client.post(
      Uri.parse(ApiConstants.baseUrl + ApiConstants.postGetUserProfile),
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      final decodedJson = json.decode(response.body);
      final responseData = decodedJson['result']['data'];
      return EmployeeProfileModel.fromJson(responseData);
    } else {
      throw ServerException();
    }
  }
}
