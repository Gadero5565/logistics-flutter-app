import 'dart:convert';

import '../../../../core/error/exceptions.dart';
import '../../../../core/storage/app_storage.dart';
import '../models/categories_with_types_model.dart';
import 'package:http/http.dart' as http;

abstract class CategoriesDataSource {
  Future<List<CategoryWithTypesModel>> getCategoriesWithTypes();
}

class CategoriesDataSourceImpl extends CategoriesDataSource {
  final http.Client client;

  CategoriesDataSourceImpl({required this.client});

  @override
  Future<List<CategoryWithTypesModel>> getCategoriesWithTypes() async {
    final body = json.encode({
      "jsonrpc": "2.0",
      "params": {"sec_token": AppStorage().getSecToken()},
    });

    final response = await client.post(
      Uri.parse(ApiConstants.baseUrl + ApiConstants.postGetCategoriesWithTypes),
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    print("response $response");
    if (response.statusCode == 200) {
      final decodedJson = json.decode(response.body);
      final listData = decodedJson['result']['data']['categories'] as List;
      return listData
          .map<CategoryWithTypesModel>(
            (json) => CategoryWithTypesModel.fromJson(json),
          )
          .toList();
    } else {
      throw ServerException();
    }
  }
}
