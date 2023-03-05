import 'package:flutter/material.dart';
import 'package:hatspace/theme/toast_messages/toast_messages.dart';

class ToastMessageViews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Toast Messages Demo"),
        ),
        body: Center(
          child: ListView(
            padding: const EdgeInsets.all(10),
            children: [
              ElevatedButton(
                child: Text("Error Toast Mesasge Demo"),
                onPressed: () {
                  ToastMessages().showToast(context, ToastType.ERROR,
                      "Login Fail", "Login fail message");
                },
              ),
            ],
          ),
        ));
  }
}
