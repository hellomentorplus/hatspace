import 'package:flutter/material.dart';
import 'package:hatspace/theme/toast_messages/hs_toast_theme.dart';

enum ToastType { SUCCESS, ERROR, WARNING, INFO }

class ToastMessages {
  void showToast(
      BuildContext context, ToastType type, String title, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.only(top: 100),
              child: type == ToastType.ERROR
                  ? ToastMessageError(message: message, title: title)
                  : Container())
        ],
      ),
      backgroundColor: Colors.transparent,
      width: MediaQuery.of(context).size.width,
      behavior: SnackBarBehavior.floating,
      elevation: 0,
    ));
  }
}
