import 'dart:io';
import 'error_messages.dart';
import 'exceptions.dart';
import 'failure.dart';

class ErrorHandler {
  late final Failure failure;

  ErrorHandler.handle(dynamic error) {
    if (error is SocketException) {
      failure = const Failure(message: ErrorMessages.networkConnectionFailed);
    } else if (error is NoInternetConnectionException) {
      failure = const Failure(message: ErrorMessages.networkConnectionFailed);
    } else {
      failure = const Failure(message: ErrorMessages.unexpectedError);
    }
  }
}
