import 'package:flutter/material.dart';
import 'package:hatspace/features/debug/view/widget_list/core_button_view.dart';
import 'package:hatspace/features/debug/view/widget_list/toast_messages_view.dart';

class WidgetCatalogScreen extends StatelessWidget {
  WidgetCatalogScreen({super.key});
  // Add new item into ItemList
  final List<ItemList> itemList = [
    ItemList("Core Button", CoreButtonView()),
    // TODO: ADD Toast Message View to show all toast message
    ItemList("Toast Message", const ToastMessageViews())
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key("widget-for-debug"),
      appBar: AppBar(
        title: const Text("Widget Catalog"),
      ),
      body: Container(
          padding: const EdgeInsets.all(10),
          child: GridView.builder(
              itemCount: itemList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0),
              itemBuilder: (BuildContext context, index) {
                return ElevatedButton(
                    onPressed: (() {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return itemList[index].itemWidget;
                        },
                      ));
                    }),
                    child: Text(itemList[index].itemTitle));
              })),
    );
  }
}

class ItemList {
  String itemTitle;
  Widget itemWidget;
  ItemList(this.itemTitle, this.itemWidget);
}
