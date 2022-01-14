import 'dart:io';

import 'package:guki_core/guki_core.dart';
import 'package:guki_core/src/constants/api_constants.dart';

///Http status code controller.
mixin HttpStatusCodeControllerMixin {
  ///It checks http response status code and returns error messages or success informations.
  Result checkStatusCode(int statusCode) {
    if (statusCode < HttpStatus.badRequest) {
      return SuccessResult();
    } else if (statusCode == HttpStatus.badRequest) {
      return ErrorResult(message: ApiMessages.badRequest);
    } else if (statusCode == HttpStatus.unauthorized) {
      return ErrorResult(message: ApiMessages.unauthorized);
    } else if (statusCode == HttpStatus.forbidden) {
      return ErrorResult(message: ApiMessages.forbidden);
    } else if (statusCode == HttpStatus.notFound) {
      return ErrorResult(message: ApiMessages.notFound);
    } else if (statusCode == HttpStatus.internalServerError) {
      return ErrorResult(message: ApiMessages.internalServerError);
    }
    return ErrorResult(message: ApiMessages.unexpectedError);
  }
}
