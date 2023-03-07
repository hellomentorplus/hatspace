import 'package:flutter/material.dart';
import 'package:hatspace/theme/toast_messages/hs_toast_theme.dart';
import 'package:hatspace/theme/toast_messages/toast_messages.dart';

class ToastMessageViews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Toast Messages Demo"),
      ),
      body: Center(
        //Update view for widget catalog
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text("Error Toast Mesasge Demo"),
              onPressed: () {
                ToastMessages().showToast(context, ToastType.error,
                    "Login Fail", "Login fail message");
              },
            ),
          ],
        ),
      ),
    );
  }
}
