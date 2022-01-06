///You can use that class for return bool with message.
///Function result is false but why? Result class generated for this.
///This class is generic type for create json to Result object.
///
/// * Example:
///```
///Result isValid(String? message){
/// if(message?.isNotEmpty ?? false){
///   return Result(success: true, message: 'Message is correct');
/// } else {
///   return Result(success: false, message: 'Message is null or empty');
/// }
///}
///```
abstract class Result {
  ///message is not required. Default value: ''.
  final String message;

  ///success is operation result. It's required.
  final bool success;

  Result({
    this.message = '',
    required this.success,
  });

  ///Use it for convert json to `Result` object.
  Result fromJson(Map<String, dynamic> json);

  ///Convert `Result` object to json.
  Map<String, dynamic> toJson();

  ///Json Keys for converting.
  ///If your json keys different, just change theese.
  static const String messageKey = 'Message';
  static const String successKey = 'Success';
  static const String dataKey = 'Result';
}
