import 'package:flutter/cupertino.dart';
import 'package:guki_core/guki_core.dart';

class DisplayMessagesExample {
  void showAlert(BuildContext context) {
    DisplayAlertDialog(context).successAlert('Message is success');
  }

  void showSnackBar(BuildContext context) {
    DisplaySnackBar(context).errorMessage('Error message here');
  }
}
