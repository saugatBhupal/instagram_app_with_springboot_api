abstract class Exception {}

class NoInternetConnectionException extends Exception {}

class ServerException implements Exception {
  final String message;
  ServerException({
    this.message = "Server error occured",
  });
}
