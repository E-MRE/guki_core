import '../../constants/api_constants.dart';

class ServerException implements Exception {
  final String message;

  ServerException({String? errorMessage})
      : message = errorMessage ?? ApiMessages.unexpectedError;
}

class ConnectionException implements Exception {
  final String message;

  ConnectionException({String? errorMessage})
      : message = errorMessage ?? ApiMessages.networkError;
}
