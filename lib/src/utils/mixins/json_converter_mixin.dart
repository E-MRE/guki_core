import 'dart:convert';

import '../../models/api_response.dart';
import '../../models/api_response_model.dart';
import '../../models/entity_model.dart';
import '../results/data_result.dart';
import '../results/error_data_result.dart';
import '../results/success_data_result.dart';

mixin JsonConverterMixin {
  final _parseError = 'An error occured while parsing data.';
  final String emptyJson = '{}';

  ApiResponse<TData, TParse> convertApiResponse<TData, TParse>({
    String? jsonBody,
    ApiResponse<TData, TParse>? apiResponse,
    TParse? parseModel,
  }) {
    try {
      var json = jsonDecode(jsonBody ?? emptyJson);
      return apiResponse?.fromJson(json, parseModel: parseModel)
              as ApiResponse<TData, TParse>? ??
          ApiResponseModel.fromJson(json, parseModel: parseModel)
              as ApiResponse<TData, TParse>;
    } catch (error) {
      return apiResponse ??
          ApiResponseModel<TData, TParse>(
            success: false,
            message: error.toString(),
          );
    }
  }

  DataResult<TReturn> convertJson<TReturn, TModel>(TModel model, dynamic data) {
    try {
      if (data == null) {
        return ErrorDataResult(message: _parseError);
      }

      if (model is EntityModel) {
        if (data is Map<String, dynamic>) {
          return SuccessDataResult(data: model.fromJson(data) as TReturn);
        } else if (data is List) {
          return SuccessDataResult(
              data: data
                  .map((element) => model.fromJson(element))
                  .cast<TModel>()
                  .toList() as TReturn);
        } else if (TReturn is String) {
          return SuccessDataResult(data: data);
        } else if (data != null) {
          return SuccessDataResult(data: jsonDecode(data));
        }

        return ErrorDataResult(message: _parseError);
      } else {
        if (data is String && TReturn is num) {
          return SuccessDataResult(data: (num.tryParse(data) ?? -1) as TReturn);
        } else if (data is List && TReturn is List) {
          return SuccessDataResult(
              data: data
                  .map((element) => element as TModel)
                  .cast<TModel>()
                  .toList() as TReturn);
        } else if (data is TReturn) {
          return SuccessDataResult(data: data);
        }

        return ErrorDataResult(message: _parseError);
      }
    } catch (error) {
      return ErrorDataResult(
          message: error.toString() +
              ' | Data type: ${data.runtimeType}' +
              ' | Parse Type: ${model.runtimeType}' +
              ' | Return Type: ${TReturn.runtimeType}');
    }
  }
}
