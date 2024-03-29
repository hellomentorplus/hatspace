import 'package:flutter/material.dart';
import 'package:hatspace/theme/toast_messages/hs_toast_theme.dart';
import 'package:hatspace/theme/toast_messages/toast_messages_extension.dart';

class ToastMessageViews extends StatelessWidget {
  const ToastMessageViews({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Toast Messages Demo'),
      ),
      body: Center(
        //Update view for widget catalog
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text('Error Toast Mesasge Demo'),
              onPressed: () {
                context.showToast(
                    type: ToastType.errorToast,
                    title: 'Login Fail',
                    message: 'Login fail message');
              },
            ),
          ],
        ),
      ),
    );
  }
}
