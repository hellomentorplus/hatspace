import 'package:flutter/material.dart';
import 'package:hatspace/theme/toast_messages/hs_toast_theme.dart';

extension ToastMessagesExtension on BuildContext {
  void showToast(ToastType type, String title, String message) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.only(top: 12),
              child: ToastMessageContainer(
                  toastType: type, toastTitle: title, toastContent: message))
        ],
      ),
      backgroundColor: Colors.transparent,
      behavior: SnackBarBehavior.floating,
      elevation: 0,
      duration: const Duration(seconds: 6),
    ));
  }

  void closeToast() {
    ScaffoldMessenger.of(this).hideCurrentSnackBar();
  }
}
