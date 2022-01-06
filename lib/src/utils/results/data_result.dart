import 'result.dart';

abstract class DataResult<TData> extends Result {
  ///You can use that class for return bool with message and data.
  ///Think about there is a function return data but before that
  ///it checks null or valid. You can return operation result,
  ///data and message.
  ///
  ///`TData` is type of data.
  ///
  /// * Example:
  ///
  /// ```
  /// DataResult<T> func(T data){
  ///   return DataResult<T>(success: true, data: data, message: 'success');
  /// }
  ///
  ///  DataResult<T> func(T data){
  ///   return DataResult<T>(success: false);
  /// }
  /// ```
  DataResult({this.data, required bool success, String message = ''})
      : super(success: success, message: message);

  ///Generic type data. It can be null.
  final TData? data;

  @override
  Map<String, dynamic> toJson();

  @override
  DataResult<TData> fromJson(Map<String, dynamic> json);
}
