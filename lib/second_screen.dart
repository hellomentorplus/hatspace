import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  State<MyWidget> createState() => _MySecondPage();
}

class _MySecondPage extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("Second Screen here"),
    );
  }
}