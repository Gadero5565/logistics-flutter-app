import 'dart:convert';

import 'package:logistics_app/core/error/exceptions.dart';
import 'package:logistics_app/features/dashboard/data/models/dashboard_model.dart';
import 'package:http/http.dart' as http;

import '../../../../core/storage/app_storage.dart';

abstract class DashboardDataSource {
  Future<DashboardModel> getDashboardData({required int userId});
}

class DashboardDataSourceImpl extends DashboardDataSource {
  final http.Client client;

  DashboardDataSourceImpl({required this.client});

  @override
  Future<DashboardModel> getDashboardData({required int userId}) async {
    final body = json.encode({
      "jsonrpc": "2.0",
      "params": {"user_id": userId, "sec_token": AppStorage().getSecToken()},
    });
    final response = await client.post(
      Uri.parse(ApiConstants.baseUrl + ApiConstants.postGetDashboardData),
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      final decodedJson = json.decode(response.body);
      final formattedDecodedJson = decodedJson['result'];
      final dashboardModel = DashboardModel.fromJson(formattedDecodedJson);
      return dashboardModel;
    } else {
      throw ServerException();
    }
  }
}
