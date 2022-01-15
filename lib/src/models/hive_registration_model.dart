import 'package:hive_flutter/adapters.dart';

class HiveRegistrationModel<T> {
  TypeAdapter<T> adapter;
  int typeId;
  bool internal;
  bool override;

  HiveRegistrationModel({
    required this.adapter,
    required this.typeId,
    this.internal = false,
    this.override = false,
  });
}
