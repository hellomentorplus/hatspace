import 'package:flutter/material.dart';

class PropertyDetailScreen extends StatelessWidget {
  final String id;
  const PropertyDetailScreen({required this.id, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Property detail'),
        ),
        body: const Center(
          child: Text('T.B.D'),
        ),
      );
}
