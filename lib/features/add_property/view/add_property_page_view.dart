import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatspace/features/add_property/view/info_form/property_infor_form.dart';
import 'package:hatspace/features/home/view/home_view.dart';
import 'package:hatspace/features/sign_up/view_model/sign_up_bloc.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/route/router.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';

class AddPropertyPageView extends StatelessWidget {
  final PageController pageController =
      PageController(initialPage: 0, keepPage: true);
  final ValueNotifier<int> onProgressIndicatorState = ValueNotifier(0);
  // Number of Pages for PageView
  final List<Widget> pages = [ PropertyInforForm(), const HomePageView()];
  AddPropertyPageView({super.key});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ValueListenableBuilder(
        valueListenable: onProgressIndicatorState,
        builder: (context, currentPage, child) {
          return Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: HSColor.background,
                leading: IconButton(
                  icon: const Icon(Icons.close, color: HSColor.onSurface),
                  onPressed: () {
                    if (currentPage == 0) {
                      // HS-99 scenario 6
                      context.popToRootHome();
                    }
                  },
                ),
                bottom: PreferredSize(
                  preferredSize: Size(size.width, 0),
                  child: LinearProgressIndicator(
                    backgroundColor: HSColor.neutral2,
                    color: HSColor.primary,
                    value: (currentPage + 1) / pages.length,
                    semanticsLabel:
                        HatSpaceStrings.of(context).linearProgressIndicator,
                  ),
                ),
                title: Text(HatSpaceStrings.of(context).app_name),
              ),
             
              body: PageView.builder(
                    onPageChanged: (value) {
                      onProgressIndicatorState.value = value;
                    },
                    // physics: const NeverScrollableScrollPhysics(),
                    controller: pageController,
                    itemBuilder: (context, index) {
                      for (int i = 0; i < pages.length; i++) {
                        if (i == index) {
                          return pages[i];
                        }
                      }
                      return null;
                    },
                  ));
        });
  }
}