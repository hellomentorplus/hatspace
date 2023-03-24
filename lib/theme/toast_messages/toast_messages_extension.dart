import 'package:flutter/material.dart';
import 'package:hatspace/theme/toast_messages/hs_toast_theme.dart';

extension ToastMessagesExtension on BuildContext {
  void showToast(ToastType type, String title, String message) async {
    OverlayEntry? overlayEntry;
    overlayEntry = OverlayEntry(builder: (context) {
      return Positioned(
          child: SafeArea(
              child: Column(children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: ToastMessageContainer(
              overlayEntry: overlayEntry,
              toastType: type, toastTitle: title, toastContent: message),
        )
      ])));
    });
    Overlay.of(this).insert(overlayEntry);
    try{
     await Future.delayed(const Duration(seconds: 3));
       overlayEntry.remove();
    }catch(e){
      print(e);
    }
  }
}
