import 'failures.dart';

class FailuresMessage {
  String mapFailureToMessage(
      failure,
      ) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server error occurred, please try again later.';
      case CacheFailure:
        return 'Cache error occurred, please try again.';
      case NetworkFailure:
        return 'Please check your internet connection';
      case AuthFailure:
        return 'Authentication error occurred, Please try again .';
      case ValidationFailure:
        return 'Validation error occurred, Please try again .';
      case LocationFailure:
        return 'Location error occurred, Please try again .';
      case PermissionFailure:
        return 'Permission error occurred, Please try again .';
      default:
        return " Unexpected error,Please try again later.";
    }
  }
}
