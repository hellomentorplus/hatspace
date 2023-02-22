import 'package:flutter/material.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';

class WidgetCatalogScreen extends StatelessWidget {
  WidgetCatalogScreen({super.key});
  // Add new item into ItemList
  // TODO: 
  //      Create CoreButtonView and ToastMessageView for debug screen
  
  List<ItemList> itemList = [
    ItemList("Core Button", const CoreButtonView()),
    ItemList("Toast Message", const ToastMessageView())
  ];
  @override
  Widget build(BuildContext context) {
    return 

       Scaffold(
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

// TODO: These two widget only for debug and temporary use in this story,
// REMOVE it when story get approve and separate it into different files
class CoreButtonView extends StatelessWidget {
  const CoreButtonView({super.key});
  
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Show all core UI buttons here"),
    );
  }
} 

class ToastMessageView extends StatelessWidget{
  const ToastMessageView ({super.key});
  @override
  Widget build(BuildContext context){
    return const Center(
      child: Text("Show all ToastMessage here"),
    );  
  }
}

class ItemList {
  String itemTitle;
  Widget itemWidget;
  ItemList(this.itemTitle, this.itemWidget);
}