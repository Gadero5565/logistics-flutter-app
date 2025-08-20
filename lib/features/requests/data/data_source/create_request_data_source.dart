import 'dart:convert';

import '../../../../core/error/exceptions.dart';
import '../../../../core/storage/app_storage.dart';
import '../../domain/entities/create_request_entity.dart';
import '../models/create_request_model.dart';
import 'package:http/http.dart' as http;

abstract class CreateRequestDataSource {
  Future<CreatedRequest> createRequest({
    required int userId,
    required CreateRequestModel request,
  });
}

class CreateRequestDataSourceImpl extends CreateRequestDataSource {
  final http.Client client;

  CreateRequestDataSourceImpl({required this.client});

  @override
  Future<CreatedRequest> createRequest({
    required int userId,
    required CreateRequestModel request,
  }) async {
    final body = json.encode({
      "jsonrpc": "2.0",
      "params": {
        "user_id": userId,
        "sec_token": AppStorage().getSecToken(),
        ...request.toJson(),
      },
    });

    final response = await client.post(
      Uri.parse(ApiConstants.baseUrl + ApiConstants.postCreateRequest),
      headers: {"Content-Type": "application/json"},
      body: body,
    );

    if (response.statusCode == 200) {
      final decodedJson = json.decode(response.body);
      final result = decodedJson['result'];

      // Check if the request was successful
      if (result['status'] == 'success') {
        final data = result['data'];
        return CreatedRequestModel.fromJson(data);
      } else {
        throw ServerException();
      }
    } else {
      throw ServerException();
    }
  }
}
