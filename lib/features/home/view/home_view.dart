import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hatspace/features/debug/view/widget_catalog_wrapper.dart';
import 'package:hatspace/features/home/view_model/bloc/home_bloc.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:shake/shake.dart';

class HomePageView extends StatelessWidget {
  HomePageView({Key? key}) : super(key: key);
  void _onItemTapped(int index) {
    _counter.value = index;
  }

  late ShakeDetector detector;

  final ValueNotifier<int> _counter = ValueNotifier<int>(0);
  @override
  Widget build(BuildContext context) {
    detector = ShakeDetector.waitForStart(onPhoneShake: () {
      // print("Phone is shaking");
      context.read<HomeBloc>().add(const ShowWidgetCatalogEvent());
      detector.stopListening();
    });
    detector.startListening();
    return BlocListener<HomeBloc, HomeState>(
      listenWhen: (previous, current) {
        return current is ShowWidgetCatalogState &&
            current.isShowCatalog == true;
      },
      listener: ((context, state) {
        if (state is ShowWidgetCatalogState && state.isShowCatalog == true) {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const WidgetCatalogWrapper();
          }));
        }
      }),
      child: Scaffold(
          appBar: AppBar(
            // leading: IconButton(
            //   icon: const Icon(Icons.arrow_back, color: Colors.black),
            //   onPressed: () => {},
            // ),
            title: Text(HatSpaceStrings.of(context).app_name),
            centerTitle: true,
          ),
          body: const Center(
            child: Text('Home Page'),
          ),
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
          )),
    );
  }
}
