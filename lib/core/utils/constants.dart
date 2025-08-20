class StorageConstants {
  static const String tokenBox = 'tokenBox';
  static const String userBox = 'userBox';
  static const String settingsBox = 'settingsBox';

  static const String accessToken = 'accessToken';
  static const String refreshToken = 'refreshToken';
  static const String userProfile = 'userProfile';
  static const String isFirstLaunch = 'isFirstLaunch';
  static const String theme = 'theme';
}

class TextConstants {
  /// Auth Feature Titles
  static const String loginTextTitle = 'Login';
  //Email
  static const String emailLabelText = 'Email Address';
  static const String emailHintText = 'you@gmail.com';
  static const String emailValidationCorrectFormat = 'Please insert a correct Email';
  static const String emailValidationEmptyValue = 'The field must be filled out';
  //Password
  static const String passwordLabelText = 'Password';
  static const String passwordHintText = 'write your password here';
  static const String passwordValidationCorrectFormat = 'At least 8 characters';
  static const String passwordValidationEmptyValue = 'The field must be filled out';
  static const String passwordForgetText = 'Forgot Password?';
  //Button
  static const String loginButtonText = 'Login';

  static const String centerLoginText = 'Welcome back! Please enter your credentials';

}

class NavigationConstants {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String shipments = '/shipments';
  static const String shipmentDetails = '/shipment-details';
  static const String orders = '/orders';
  static const String orderDetails = '/order-details';
  static const String inventory = '/inventory';
  static const String drivers = '/drivers';
  static const String vehicles = '/vehicles';
  static const String profile = '/profile';
  static const String settings = '/settings';
}

class ValidationConstants {
  static const String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  static const String phonePattern = r'^\+?[0-9]{10,15}$';
  static const String namePattern = r'^[a-zA-Z ]{2,30}$';
  static const int passwordMinLength = 8;
}