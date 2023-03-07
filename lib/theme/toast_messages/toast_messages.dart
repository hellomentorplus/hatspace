import 'package:flutter/material.dart';
import 'package:hatspace/theme/toast_messages/hs_toast_theme.dart';

enum ToastType { success, error, warning, info }

// CHANGE file name and class name to make class more relative to its function
class ToastMessages {
  void showToast(
      BuildContext context, ToastType type, String title, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.only(top: 12),
              child: checkToastType(type, title, message))
        ],
      ),
      backgroundColor: Colors.transparent,
      width: MediaQuery.of(context).size.width,
      behavior: SnackBarBehavior.floating,
      elevation: 0,
      duration: const Duration(seconds: 6),
    ));
  }

  void closeToast(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }

  Widget checkToastType(ToastType type, String title, String message) {
    switch (type) {
      case ToastType.error:
        return ToastMessageError(message: message, title: title);
      default:
        return const ToastMessageError(
            message: "Toast Type defalut", title: "TOAST TYPE DEFAUL");
    }
  }
}
