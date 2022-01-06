import 'package:flutter/material.dart';
import 'base_snack_bar.dart';

class DisplaySnackBar {
  late final BuildContext _context;

  DisplaySnackBar(context) {
    _context = context;
  }

  void successMessage(String text,
      {IconData icon = Icons.done_rounded,
      Color backgroundColor = Colors.green}) {
    return _showSnackBar(text, icon, backgroundColor);
  }

  void errorMessage(String text,
      {IconData icon = Icons.cancel_outlined,
      Color backgroundColor = Colors.red}) {
    return _showSnackBar(text, icon, backgroundColor);
  }

  void _showSnackBar(String text, IconData icon, Color backgroundColor) {
    ScaffoldMessenger.of(_context)
      ..removeCurrentSnackBar()
      ..showSnackBar(BaseSnackBar(
        content: _buildContent(text, icon),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.fixed,
      ));
  }

  Widget _buildContent(String text, IconData icon) {
    return Row(children: [
      Icon(icon, color: Theme.of(_context).scaffoldBackgroundColor),
      const Spacer(),
      Text(text,
          style: Theme.of(_context).textTheme.bodyText2?.copyWith(
              fontFamily: Theme.of(_context).textTheme.headline5?.fontFamily,
              color: Theme.of(_context).scaffoldBackgroundColor)),
      const Spacer(flex: 10)
    ]);
  }
}
