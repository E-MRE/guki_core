class ApiConstants {
  static String baseUrl = _isTestMode ? _testUrl : _baseUrl;

  static const bool _isTestMode = true;

  static const String _baseUrl = 'https://jsonplaceholder.typicode.com/';
  static const String _testUrl = 'https://jsonplaceholder.typicode.com/';
}

class ApiMessages {
  static const String sendDataError = 'An error occured while sending data';
  static const String getDataError = 'An error occured while getting data';
  static const String networkError = 'There is no internet connection';
  static const String timeoutError = 'The process has timed out';
  static const String unexpectedError =
      'Unexpected error occured while running process';

  static const String badRequest =
      'The server could not understand the request due to invalid syntax.';

  static const String unauthorized = 'Unauthorized operation.';

  static const String forbidden =
      'You do not have access rights to the content';
  static const String notFound =
      'The server can not find the requested resource. ';
  static const String internalServerError =
      'The server has encountered a situation it does not know how to handle.';
}
