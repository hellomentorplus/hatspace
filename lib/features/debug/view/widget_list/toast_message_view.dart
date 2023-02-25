import 'package:flutter/material.dart';
import 'package:hatspace/theme/hs_toast_type.dart';
import 'package:hatspace/theme/widgets/hs_toast_message.dart';

class ToastMessageView extends StatelessWidget {
  final _paddingKey = GlobalKey();
  // late OverlayEntry overlayEntry;
  late List<OverlayEntry> overlayEntryList;

  ToastMessageView({super.key});
  showOverLay(BuildContext context, String message, String type) async {
    OverlayState? overlayState = Overlay.of(context);

    OverlayEntry overlayEntry = OverlayEntry(builder: (context) {
      return Positioned(
          top: 100.0,
          left: 20,
          child: ToastMessage(message: message, type: type));
    });
    overlayState?.insert(overlayEntry);
    await Future.delayed(const Duration(seconds: 6));
    overlayEntry.remove();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      key: _paddingKey,
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
              onPressed: (() {
                // SHOW SUCCESS TOAST MESSAGE
                showOverLay(context, "Success Toast", ToastType.success);
              }),
              child: const Text("Show Success")),
          ElevatedButton(
              onPressed: () {
                // SHOW ERROR TOAST
                showOverLay(context, "Error Toast", ToastType.error);
              },
              child: const Text("Show Error")),
          ElevatedButton(
              onPressed: () {
                // SHOW WARNING TOAST
                showOverLay(context, "Warning Toast", ToastType.warning);
              },
              child: const Text("Show Warning")),
          ElevatedButton(
              onPressed: () {
                // SHOW INFO TOAST
                showOverLay(context, "Info Toast", ToastType.info);
              },
              child: const Text("Show Info"))
        ],
      ),
    ));
  }
}
