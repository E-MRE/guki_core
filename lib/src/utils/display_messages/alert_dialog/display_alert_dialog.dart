import 'package:flutter/material.dart';

import '../alert_dialog/error_alert_dialog.dart';
import '../alert_dialog/success_alert_dialog.dart';

class DisplayAlertDialog {
  late final BuildContext _context;

  DisplayAlertDialog(BuildContext context) {
    _context = context;
  }

  Future<T?> successAlert<T>(
    String content, {
    String title = 'Success',
    String buttonText = 'OK',
    VoidCallback? onPressed,
  }) {
    return showDialog<T?>(
        context: _context,
        builder: (context) {
          return SuccessAlertDialog(
            title: title,
            content: content,
            buttonText: buttonText,
            onPressed: onPressed,
          );
        });
  }

  Future<T?> errorAlert<T>(
    String content, {
    String title = 'Error',
    String buttonText = 'OK',
    VoidCallback? onPressed,
  }) {
    return showDialog<T?>(
        context: _context,
        builder: (context) {
          return ErrorAlertDialog(
            title: title,
            content: content,
            buttonText: buttonText,
            onPressed: onPressed,
          );
        });
  }
}
