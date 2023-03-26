import 'package:flutter/material.dart';
import 'package:hatspace/theme/toast_messages/hs_toast_theme.dart';
import 'package:async/async.dart';

extension ToastMessagesExtension on BuildContext {
  OverlayEntry showToast({
      required ToastType type,
      required String title,
      required String message,
      VoidCallback? onDissmiss
  }) {
  final overlayEntry = OverlayEntry(
    builder: (context) {
      return Positioned(
          child: SafeArea(
              child: Column(children: [
        Padding(
            padding: const EdgeInsets.all(12),
            child: ToastMessageContainer(
                toastType: type,
                toastTitle: title,
                toastContent: message))
      ])));
    })
    ..removeListener(() {
      onDissmiss?.call();
    });
    WidgetsBinding.instance.addPersistentFrameCallback((timeStamp) {
       Overlay.of(this).insert(overlayEntry);
      Future.delayed(
        const Duration(seconds: 6),
        (){
          if(overlayEntry.mounted == true){
            overlayEntry.remove();
          }
        }
      );
    });
    return overlayEntry;
  }

  void removeToast(OverlayEntry? overlayEntry) {
    if (overlayEntry?.mounted == true) {
      overlayEntry?.remove();
    }
  }
}
