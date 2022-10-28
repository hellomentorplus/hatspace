import 'package:flutter/material.dart';
import 'package:hatspace/strings/l10n.dart';

class HomePageView extends StatelessWidget {
  const HomePageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(HatSpaceStrings.of(context).app_name),
      ),
      body: const Center(
        child: Text('T.B.D'),
      ),
    );
  }
}
