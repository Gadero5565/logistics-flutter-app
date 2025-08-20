import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logistics_app/features/requests/data/models/request_model.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/storage/app_storage.dart';

abstract class UserRequestsDataSource {
  Future<List<RequestModel>> getUserRequests({required int userId});
}

class UserRequestsDataSourceImpl extends UserRequestsDataSource {
  final http.Client client;

  UserRequestsDataSourceImpl({required this.client});

  @override
  Future<List<RequestModel>> getUserRequests({required int userId}) async {
    final body = json.encode({
      "jsonrpc": "2.0",
      "params": {"user_id": userId, "sec_token": AppStorage().getSecToken()},
    });
    final response = await client.post(
      Uri.parse(ApiConstants.baseUrl + ApiConstants.postGetUserRequests),
      headers: {"Content-Type": "application/json"},
      body: body,
    );

    if (response.statusCode == 200) {
      final decodedJson = json.decode(response.body);
      final listData = decodedJson['result']['data'] as List;
      final List<RequestModel> userRequests =
          listData
              .map<RequestModel>(
                (jsonRequestsModel) => RequestModel.fromJson(jsonRequestsModel),
              )
              .toList();
      return userRequests;
    } else {
      throw ServerException();
    }
  }
}
