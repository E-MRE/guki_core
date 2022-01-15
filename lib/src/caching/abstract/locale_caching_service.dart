import 'package:flutter/cupertino.dart';

///Save your data to the cache. Active CacheServices:
///
/// * [HiveCachingManager]
abstract class LocaleCachingService {
  ///Initialize your caching package.
  ///Also add your initialize operations using [customInit].
  ///
  ///Example:
  ///
  ///```dart
  ///void main(){
  ///  await _cachingService.init(customInit: () => myInit());
  ///}
  ///```
  Future<void> init({VoidCallback? customInit});

  ///Get value using [String] key and also you can set default value.
  ///You should define value type
  ///
  ///Example:
  ///
  ///```dart
  ///var myData = await getValue<String>('token', '-');
  ///
  ///if((myData?.isEmpty ?? true) || myData == -){
  ///   return false;
  ///}
  ///```
  Future<T?> getValue<T>(String key, {T? defaultValue});

  ///Set value with [key] and [data].
  ///You should set data type.
  ///
  ///Example:
  ///
  ///```dart
  ///var isSaved = await setValue<String>('token', 'Qwewss123dasdasw_swws');
  ///
  ///if(!isSaved){
  ///   print('Data didn't saved to the cache');
  ///}
  ///```
  Future<bool> setValue<T>(String key, T data);

  ///Delete cached data using [key].
  ///If operation is successful then returns true if not returns false.
  ///
  ///Example:
  ///
  ///```dart
  ///var isDeleted = await deleteValue('token');
  ///
  ///if(!isDeleted){
  ///   print('An error occured while delete value on cache');
  ///}
  ///```
  Future<bool> deleteValue<T>(String key);
}
