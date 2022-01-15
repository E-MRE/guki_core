// ignore_for_file: avoid_print

import 'package:guki_core/guki_core.dart';

class HiveCachingManagerExamples {
  // HiveCachingManager implements HiveService.
  // HiveService implements LocaleCachingService
  // Which mean you can use hive spesific functions or locale caching functions

  ///[_cachingService] can use  only [LocaleCachingService] methods.
  final LocaleCachingService _cachingService = HiveCachingManager.instance;

  ///[_hiveService] can use [LocaleCachingService] methods and [HiveService] spesific methods.
  final HiveService _hiveService = HiveCachingManager.instance;

  Future<void> examples() async {
    var isSaved = await _cachingService.setValue<String>('Test', 'My data');
    print(isSaved.toString());

    var myDataCache =
        await _cachingService.getValue<String>('Test', defaultValue: '');
    var myDataHive =
        await _hiveService.getValue<String>('Test', defaultValue: '');

    print(myDataCache?.toString() ?? 'error cache');
    print(myDataHive?.toString() ?? 'error hive');

    var isOpen = _hiveService.isBoxOpen('Test');
    if (isOpen) {
      await _hiveService.close<String>('Test');
    }

    var isDeleted = await _cachingService.deleteValue('Test');
    print('Is Deleted: $isDeleted');
  }
}
