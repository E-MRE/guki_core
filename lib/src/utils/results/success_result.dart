import 'result.dart';

class SuccessResult extends Result {
  ///You can use that class return bool with message.
  ///This class returns automatically success: true.
  ///Also you can add message.
  ///
  /// * Example:
  ///
  /// ```
  /// Result func(){
  ///   return SuccessResult(message: 'Operation is successful');
  /// }
  ///
  /// Result func(){
  ///   return SuccessResult();
  /// }
  /// ```
  SuccessResult({String message = ''}) : super(message: message, success: true);

  factory SuccessResult.fromJson(Map<String, dynamic> json) {
    return SuccessResult(message: json[Result.messageKey] ?? '');
  }

  @override
  SuccessResult fromJson(Map<String, dynamic> json) =>
      SuccessResult.fromJson(json);

  @override
  Map<String, dynamic> toJson() {
    return {Result.messageKey: message, Result.successKey: true};
  }
}
