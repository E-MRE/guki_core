import 'result.dart';

class ErrorResult extends Result {
  ///You can use that class return bool with message.
  ///This class returns automatically success: false.
  ///Also you can add message.
  ///
  /// * Example:
  ///
  /// ```
  /// Result func(){
  ///   return ErrorResult(message: 'Operation is failed');
  /// }
  ///
  /// Result func(){
  ///   return ErrorResult();
  /// }
  /// ```
  ErrorResult({String message = ''}) : super(message: message, success: false);

  factory ErrorResult.fromJson(Map<String, dynamic> json) {
    return ErrorResult(message: json[Result.messageKey] ?? '');
  }

  @override
  ErrorResult fromJson(Map<String, dynamic> json) => ErrorResult.fromJson(json);

  @override
  Map<String, dynamic> toJson() {
    return {Result.messageKey: message, Result.successKey: false};
  }
}
