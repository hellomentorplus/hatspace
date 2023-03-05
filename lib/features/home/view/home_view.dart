import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hatspace/features/debug/view/widget_list/widget_catalog_screen.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:hatspace/view_models/app_config/bloc/app_config_bloc.dart';
import 'package:hatspace/view_models/app_config/bloc/app_config_state.dart';
import 'package:shake/shake.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => HomePageViewState();
}

class HomePageViewState extends State<HomePageView> {
  late ShakeDetector detector;
  void _onItemTapped(int index) {
    _counter.value = index;
  }

  @override
  void dispose() {
    try {
      detector.stopListening();
    } catch (e) {}
    super.dispose();
  }

  void onShakeToAction(BuildContext context, AppConfigState state) {
    // Only listen ShakeDetector when debugOptionTrue
    detector = ShakeDetector.waitForStart(
        onPhoneShake: () async {
          // To limit that shaking will happend more than one so there will be muliple push happened
          if (detector.mShakeCount == 1) {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              // detector.stopListening();
              return WidgetCatalogScreen();
            }));
          }
        },
        shakeSlopTimeMS: 1000);
    detector.startListening();
  }

  final ValueNotifier<int> _counter = ValueNotifier<int>(0);
  @override
  Widget build(BuildContext context) {
    return BlocListener<AppConfigBloc, AppConfigState>(
        listener: (context, state) {
          if (state is DebugOptionEnabledState &&
              state.debugOptionEnabled == true) {
            onShakeToAction(context, state);
          }
        },
        child: Scaffold(
            appBar: AppBar(
              title: Text(HatSpaceStrings.of(context).app_name),
              centerTitle: true,
            ),
            body: Center(
                child: Text(
              HatSpaceStrings.of(context).homePageViewTitle,
            )),
            bottomNavigationBar: ValueListenableBuilder<int>(
              builder: (BuildContext context, int value, Widget? child) {
                return BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        Assets.images.searchNormal,
                        width: 24,
                        height: 24,
                        color: _counter.value == 0
                            ? HSColor.secondary
                            : HSColor.neutral4,
                      ),
                      label: HatSpaceStrings.of(context).explore.toString(),
                    ),
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        Assets.images.calendar,
                        width: 24,
                        height: 24,
                        color: _counter.value == 1
                            ? HSColor.secondary
                            : HSColor.neutral4,
                      ),
                      label: HatSpaceStrings.of(context).tracking.toString(),
                    ),
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        Assets.images.messages,
                        width: 24,
                        height: 24,
                        color: _counter.value == 2
                            ? HSColor.secondary
                            : HSColor.neutral4,
                      ),
                      label: HatSpaceStrings.of(context).inbox.toString(),
                    ),
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        Assets.images.profileCircle,
                        width: 24,
                        height: 24,
                        color: _counter.value == 3
                            ? HSColor.secondary
                            : HSColor.neutral4,
                      ),
                      label: HatSpaceStrings.of(context).profile.toString(),
                    ),
                  ],
                  selectedItemColor: HSColor.secondary,
                  currentIndex: _counter.value,
                  onTap: _onItemTapped,
                );
              },
              valueListenable: _counter,
            )));
  }
}
