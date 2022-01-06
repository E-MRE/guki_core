import 'result.dart';
import 'data_result.dart';

class SuccessDataResult<TData> extends DataResult<TData> {
  ///You can use that class for return bool with message and data.
  ///This class returns automatically `success: true.`
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
  SuccessDataResult({required TData data, String message = ''})
      : super(data: data, success: true, message: message);

  factory SuccessDataResult.fromJson(Map<String, dynamic> json) {
    return SuccessDataResult(
      data: json[Result.dataKey],
      message: json[Result.messageKey],
    );
  }

  @override
  SuccessDataResult<TData> fromJson(Map<String, dynamic> json) {
    return SuccessDataResult.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      Result.messageKey: message,
      Result.successKey: true,
      Result.dataKey: data,
    };
  }
}
