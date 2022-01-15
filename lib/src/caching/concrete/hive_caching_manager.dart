import 'package:flutter/cupertino.dart';
import 'package:guki_core/src/caching/abstract/hive_service.dart';
import 'package:guki_core/src/models/hive_registration_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveCachingManager implements HiveService {
  static HiveCachingManager? _instance;

  static HiveCachingManager get instance {
    _instance ??= HiveCachingManager._init();
    return _instance!;
  }

  final String _key = 'Key';

  HiveCachingManager._init();

  @override
  Future<void> init({
    VoidCallback? customInit,
    List<HiveRegistrationModel>? adapters,
  }) async {
    try {
      await Hive.initFlutter('document');
      if (adapters?.isNotEmpty ?? false) {
        registerAdapterList(adapters: adapters);
      }

      customInit?.call();
    } catch (error) {
      return;
    }
  }

  @override
  Future<T?> getValue<T>(String key, {T? defaultValue}) async {
    try {
      var box = await _openBox<T>(key);
      return box.get(_generateKey(key), defaultValue: defaultValue);
    } catch (error) {
      return defaultValue;
    }
  }

  @override
  Future<bool> setValue<T>(String key, T data) async {
    try {
      var box = await _openBox<T>(key);
      await box.put(_generateKey(key), data);
      return true;
    } catch (error) {
      return false;
    }
  }

  @override
  Future<bool> deleteValue<T>(String key) async {
    try {
      var box = await _openBox<T>(key);
      box.delete(_generateKey(key));
      return true;
    } catch (error) {
      return false;
    }
  }

  @override
  Future<void> close<T>(String key) async {
    try {
      var box = await _openBox<T>(key);
      box.close();
    } catch (error) {
      return;
    }
  }

  @override
  void registerAdapter<T>(
    TypeAdapter<T> adapter, {
    bool internal = false,
    bool override = false,
    int? typeId,
  }) {
    bool isRegistered = false;
    if (typeId != null) {
      isRegistered = isAdapterRegistered(typeId);
    }

    if (!isRegistered) {
      Hive.registerAdapter<T>(adapter, internal: internal, override: override);
    }
  }

  @override
  void registerAdapterList({List<HiveRegistrationModel>? adapters}) {
    adapters?.map((item) => registerAdapter(
          item.adapter,
          internal: item.internal,
          override: item.override,
          typeId: item.typeId,
        ));
  }

  @override
  bool isAdapterRegistered(int typeId) {
    return Hive.isAdapterRegistered(typeId);
  }

  @override
  bool isBoxOpen(String key) {
    return Hive.isBoxOpen(_generateKey(key));
  }

  Future<Box<T>> _openBox<T>(String key) => Hive.openBox<T>(_generateKey(key));

  String _generateKey(String key) => '$key$_key';
}
