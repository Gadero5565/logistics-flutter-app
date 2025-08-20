import 'package:shared_preferences/shared_preferences.dart';

import '../../injection.dart' as di;

class ApiConstants {
  static String baseUrl = 'https://laqush.com/';

  static String postLogin = 'api/user/login';
  static String postGetPublicKey = 'api/user/get_public_key';
  static String postGetAllProducts = 'api/products';
  static String postGetDashboardData = 'api/user/dashboard';
  static String postGetUserRequests = 'api/user/requests';
  static String postGetUserProfile = 'api/user/profile';
  static String postCreateRequest = 'api/request/create';
  static String postGetCategoriesWithTypes  = 'api/request/categories_with_types';
}
// class AppEncryptedPublicKey {
//   static String publicKey =
//       '-----BEGIN PUBLIC KEY----- MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAw1ix08k7aIoY+SYNZ4Ip53eTlZC+w7RBTW1pO64+K3YtFdrFWxl3w+RD/EesEmzT6AgWvPbW5fACPUWFh+v3SRlli9qmSLdM1jUeTWZWkeKDGimI561oNFUiu7Wdw3BqjcHxSny/GcD8Cw2Mm0XxoziSyrmJgBN24/q4jKyIAEywTC5JbiofgcV+Vd3HZpJXnBzoXmS1gVxQY3k2yT2GzvdfyZBfrOQLACj6zaPlIBrYJ81SWoWEXf4HLzNLOBXUyAUz6nlwJvPTOrkgQ3O+5tel8LWWMARduCNu1/xmIzZy1U6yQE9iEaGkRI36dWYL4sUXVyl8gc3jzt/9RIk51QIDAQAB -----END PUBLIC KEY-----';
// }
//
// Map<String, String> headerGetWithToken = {
//   "Accept": "application/json",
//   "Content-Type": "application/json",
//   // 'Authorization': 'Bearer ${AppStorage().getToken()}'
// };
// Map<String, String> headerGetWithOutToken = {
//   "Accept": "application/json",
//   "Content-Type": "application/json",
//   "api_key": AppStorage().getApiKey() ?? ''
//   // "197bc728795ebd1ea1be5e85e0815bba9cc7acf5"
//   ,
// };
// // Map<String, String> headerPostWithToken = {"Accept": "application/json", 'Authorization': 'Bearer ${AppStorage().getToken()}'};
// Map<String, String> headerPostWithOutToken = {
//   "Accept": "application/json",
// };
//
const String validationEmail = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

class AppStorage {
  SharedPreferences sh = di.sl();

  /// here for  token
  Future<bool> setRole(bool role) {
    return sh.setBool('role', role);
  }

  bool? getRole() {
    return sh.getBool('role');
  }

  Future<bool> removeRole() {
    return sh.remove('role');
  }

  Future<bool> setPemKey(String pemKey) {
    return sh.setString('pemKey', pemKey);
  }
  String? getPemKey() {
    return sh.getString('pemKey');
  }

  /// here for  userId
  Future<bool> setUserId(int userId) {
    return sh.setInt('user_id', userId);
  }

  Future<bool> setProductsLengh(int productsLengh) {
    return sh.setInt('products_lengh', productsLengh);
  }

  int? getProductsLengh() {
    return sh.getInt('products_lengh');
  }
  
  int? getUserId() {
    return sh.getInt('user_id');
  }

  Future<bool> removeUserId() {
    return sh.remove('user_id');
  }

  /// Security Token
  Future<bool> setSecToken(String secToken) {
    return sh.setString('sec_token', secToken);
  }

  String? getSecToken() {
    return sh.getString('sec_token');
  }

  /// here for  start task use it for finger print
  Future<bool> setApiKey(String apiKey) {
    return sh.setString('api_key', apiKey);
  }

  String? getApiKey() {
    return sh.getString('api_key');
  }

  Future<bool> removeApiKey() {
    return sh.remove('api_key');
  }

  /// here for  locale host base url
  Future<bool> setBaeUrl(String baseUrl) {
    return sh.setString('base_url', baseUrl);
  }

  String? getBaseUrl() {
    return sh.getString('base_url');
  }

  Future<bool> removeBaseUrl() {
    return sh.remove('base_url');
  }

  /// here for  login
  Future<bool> setIsLogin(bool isLogin) {
    return sh.setBool('is_login', isLogin);
  }

  bool getIsLogin() {
    return sh.getBool('is_login') ?? false;
  }

  Future<bool> removeIsLogin() {
    return sh.remove('is_login');
  }
}
