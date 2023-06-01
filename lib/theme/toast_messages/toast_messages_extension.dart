import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hatspace/theme/toast_messages/hs_toast_theme.dart';

extension ToastMessagesExtension on BuildContext {
  static OverlayEntry? overlayEntry;
  static Timer? timer;
  void showToast(
      {required ToastType type,
      required String title,
      required String message,
      VoidCallback? onDissmiss}) {
    removeToast(overlayEntry);
    overlayEntry = OverlayEntry(builder: (context) {
      return Positioned(
          child: SafeArea(
              child: Column(children: [
        Padding(
            padding: const EdgeInsets.all(12),
            child: ToastMessageContainer(
              toastType: type,
              toastTitle: title,
              toastContent: message,
              onCloseTap: () {
                removeToast(overlayEntry);
              },
            ))
      ])));
    })
      ..removeListener(() {
        onDissmiss?.call();
      });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Overlay.of(this).insert(overlayEntry!);
      timer = Timer(const Duration(seconds: 5), () {
        removeToast(overlayEntry);
      });
    });
  }

  void removeToast(OverlayEntry? overlayEntry) {
    if (overlayEntry?.mounted == true) {
      timer?.cancel();
      overlayEntry?.remove();
    }
  }
}
