import '../../domain/entities/login_entity.dart';

class LoginModel extends LoginEntity {
  const LoginModel({required super.email, required super.password});

  Map<String, dynamic> toJson() {
    return {
      "jsonrpc": "2.0",
      "params": {"username": email, "password": password}
    };
  }
}

class LoginResModel extends LoginResEntity {
  const LoginResModel({required super.userId, required super.secToken});

  factory LoginResModel.fromJson(Map<String, dynamic> json) {
    final userId = json['user_id'];
    final secToken = json['sec_token_for_online_requests'];
    return LoginResModel(userId: userId, secToken: secToken);
  }
}
