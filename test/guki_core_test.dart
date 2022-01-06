import 'package:flutter_test/flutter_test.dart';

import 'package:guki_core/guki_core.dart';

void main() {
  test('adds one to input values if value is not null', () {
    final calculator = Calculator();
    expect(calculator.addOneIfNotNull(2).data, 3);
    expect(calculator.addOneIfNotNull(null).runtimeType, ErrorDataResult<int>);
  });
}

/// A Calculator.
class Calculator {
  /// Returns [DataResult<int>]
  DataResult<int> addOneIfNotNull(int? value) {
    return value != null
        ? SuccessDataResult(data: value + 1)
        : ErrorDataResult(message: 'value is null');
  }
}
