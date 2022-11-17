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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => {},
        ),
        title: Text(HatSpaceStrings.of(context).app_name),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('Home Page'),
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                Assets.images.searchNormal,
                width: 24,
                height: 24,
              ),
              label: HatSpaceStrings.of(context).explore.toString(),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                Assets.images.calendar,
                width: 24,
                height: 24,
              ),
              label: HatSpaceStrings.of(context).tracking.toString(),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                Assets.images.messages,
                width: 24,
                height: 24,
              ),
              label: HatSpaceStrings.of(context).inbox.toString(),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                Assets.images.profileCircle,
                width: 24,
                height: 24,
              ),
              label: HatSpaceStrings.of(context).profile.toString(),
            ),
          ],
          selectedItemColor: Colors.brown),
    );
  }
}
