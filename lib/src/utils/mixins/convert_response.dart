import 'dart:convert';

import '../../models/api_response.dart';
import '../../models/api_response_model.dart';
import '../results/data_result.dart';
import '../results/error_result.dart';
import '../results/result.dart';
import '../results/success_result.dart';

///When only message and statuscode are returned without including Response model Result information from API
///It is used to convert from DataResult to Result type.
mixin ConvertResponseMixin {
  final String _unexpectedError = 'An error occurred while parse json';
  final String _emptyJson = '{}';
  final int _errorCode = -1;

  ///`statusCode` variable when given wrapped json with DataResult from API
  ///It is a method that returns `SuccessResult` or `ErrorResult' by checking.
  ///The response model to be parsed must be derived from `ApiResponse`.
  Result convertJsonToResultWithoutData(
    DataResult<String> jsonResult, {
    ApiResponse? parseResponse,
    bool checkStatusCode = false,
    int successCode = 0,
  }) {
    try {
      if (!jsonResult.success) {
        return ErrorResult(message: jsonResult.message);
      }

      var json = jsonDecode(jsonResult.data ?? _emptyJson);
      var apiModel =
          parseResponse?.fromJson(json) ?? ApiResponseModel.fromJson(json);

      if (checkStatusCode &&
          (apiModel.statusCode ?? _errorCode) != successCode) {
        return ErrorResult(
            message: apiModel.message ??
                'Status code error: ${apiModel.statusCode ?? _errorCode}');
      }

      return SuccessResult(message: apiModel.message ?? '');
    } catch (error) {
      return ErrorResult(
          message: '$_unexpectedError Error: ${error.toString()}');
    }
  }
}
