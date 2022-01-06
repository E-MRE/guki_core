import 'dart:developer';

import 'package:guki_core/guki_core.dart';

class ResultsExample {
  Result isOdd(int value) {
    return value % 2 != 0
        ? SuccessResult()
        : ErrorResult(message: 'value is not a number');
  }

  DataResult<List<String>> splitData(String? data, String splitValue) {
    if (data?.isEmpty ?? true) {
      return ErrorDataResult(message: 'Data is null or empty');
    } else if (!(data?.contains(splitValue) ?? true)) {
      return ErrorDataResult(message: 'data is not contains splitValue');
    }

    return SuccessDataResult(data: data!.split(splitValue));
  }
}

class ResultsTest {
  final ResultsExample _resultsExample = ResultsExample();

  void tryExamples() {
    var result = _resultsExample.isOdd(5);
    log('Operation: ${result.success} Message: ${result.message}');

    var dataResult = _resultsExample.splitData('A,B,C,D,E', '-');
    log('Operation: ${dataResult.success} Message: ${dataResult.message} Result: ${dataResult.data ?? ''}');
  }
}
