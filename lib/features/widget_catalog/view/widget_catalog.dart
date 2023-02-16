import 'package:flutter/material.dart';
import 'package:hatspace/features/widget_catalog/view/widget_list/toast_message_view.dart';

class WidgetCatalogScreen extends StatelessWidget {
  const WidgetCatalogScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Widget Catalog"),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ToastMessageView();
              }));
            },
            child: const Text("Toast Message Widgets")),
      ),
    );
  }
}
