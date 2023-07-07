import 'package:flutter/material.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';

class NotificationSnackBar {
  const NotificationSnackBar._();

  static void showSnackBar(String messages, {required ThemeData themeData}) {
    Asuka.showSnackBar(
      SnackBar(
        content: Text(
          messages,
          style: themeData.textTheme.bodyLarge?.copyWith(color: Colors.white),
        ),
        backgroundColor: const Color.fromRGBO(0, 0, 0, 0.87),
        behavior: SnackBarBehavior.floating,
        width: 635,
      ),
    );
  }
}
