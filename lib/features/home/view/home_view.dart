import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/strings/l10n.dart';

class HomePageView extends StatelessWidget {
  const HomePageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(HatSpaceStrings.of(context).app_name),
      ),
      body: Center(
        child: SvgPicture.asset(
          Assets.images.facebook,
          width: 40,
          height: 40,
          color: Colors.blue,
        ),
      ),
    );
  }
}
