import 'package:flutter/cupertino.dart';
import 'package:guki_core/src/caching/abstract/locale_caching_service.dart';
import 'package:guki_core/src/models/hive_registration_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class HiveService implements LocaleCachingService {
  @override
  Future<void> init({
    VoidCallback? customInit,
    List<HiveRegistrationModel>? adapters,
  });

  ///Register your adapter to hive.
  void registerAdapter<T>(
    TypeAdapter<T> adapter, {
    bool internal = false,
    bool override = false,
    int? typeId,
  });

  void registerAdapterList({List<HiveRegistrationModel>? adapters});

  Future<void> close<T>(String key);

  ///Check your adapter is registered.
  bool isAdapterRegistered(int typeId);

  ///Checks selected box is open.
  bool isBoxOpen(String key);
}
