import 'data_result.dart';
import 'result.dart';

class ErrorDataResult<TData> extends DataResult<TData> {
  ///You can use that class for return bool with message and data.
  ///This class returns automatically `success: false.`
  ///
  ///Think about there is a function return data but before that
  ///it checks null or valid. You can return operation result,
  ///data and message.
  ///
  /// * Example:
  ///
  /// ```
  /// DataResult<int> convert(String numberText){
  ///   var number = int.tryParse(numberText);
  ///   return number == null
  ///     ? SuccessDataResult<int>(data: number!)
  ///     : ErrorDataResult(message: 'text is not number');
  /// }
  /// ```
  ErrorDataResult({TData? data, required String message})
      : super(data: data, success: false, message: message);

  factory ErrorDataResult.fromJson(Map<String, dynamic> json) {
    return ErrorDataResult(
        data: json[Result.dataKey], message: json[Result.messageKey]);
  }

  @override
  DataResult<TData> fromJson(Map<String, dynamic> json) {
    return ErrorDataResult.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      Result.messageKey: message,
      Result.successKey: false,
      Result.dataKey: data,
    };
  }
}
