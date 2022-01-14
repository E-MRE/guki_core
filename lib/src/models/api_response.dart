///API Response model.
///Your Api Response model should extended from `ApiResponse`
///If your response json different `ApiResponseModel`.
///Example:
///
///```
///class ApiResponseModel<TData, TParse> implements ApiResponse<TData, TParse>{...}
///
///
///class ApiResponseModel<List<User>, User> implements ApiResponse<List<User>, User>{...}
///```
abstract class ApiResponse<TData, TParse> {
  ///Response data's clone model.
  ///Response json will be use [parseModel] for converting.
  TParse? parseModel;

  ///Response data. It can be List or any class. Define it's type with TData.
  TData? data;

  ///Api response code. You can manage your status codes.
  int? statusCode;

  ///Response message of API.
  String? message;

  ///Request result can be define with [success] variable.
  bool? success;

  ///Create `ApiResponse` model with json.
  ApiResponse fromJson(Map<String, dynamic> json, {TParse? parseModel});

  ///Change `ApiResponse` model to json.
  Map<String, dynamic> toJson();
}
