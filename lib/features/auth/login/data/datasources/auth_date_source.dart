import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../../core/error/exceptions.dart';
import '../../../../../core/storage/app_storage.dart';
import '../models/login_model.dart';

abstract class AuthDataSource {
  Future<LoginResModel> postLogin(LoginModel loginModel);
}

class AuthDataSourceImpl extends AuthDataSource {
  final http.Client client;

  AuthDataSourceImpl({required this.client});

  @override
  Future<LoginResModel> postLogin(LoginModel loginModel) async {
    final body = json.encode(loginModel.toJson());

    final response = await client.post(
      Uri.parse(ApiConstants.baseUrl + ApiConstants.postLogin),
      headers: {"Content-Type": "application/json"},
      body: body,
    );

    if (response.statusCode == 200) {
      final decodedJson = json.decode(response.body);
      if (decodedJson['result']['status'] == 'success') {
        final data = decodedJson['result']['data'];
        final loginResModel = LoginResModel.fromJson(data);

        return loginResModel;
      } else {
        throw ServerException();
      }
    } else {
      throw ServerException();
    }
  }
}
