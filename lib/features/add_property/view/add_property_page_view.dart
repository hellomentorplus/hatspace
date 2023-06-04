import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatspace/features/add_property/view/select_property_type.dart';
import 'package:hatspace/features/add_property/view_model/cubit/add_property_cubit.dart';
import 'package:hatspace/features/add_property/view_model/cubit/add_property_state.dart';
import 'package:hatspace/features/add_property/view_model/cubit/property_type_cubit.dart';
import 'package:hatspace/features/home/view/home_view.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/route/router.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';
import 'package:hatspace/theme/widgets/hs_buttons_settings.dart';

class AddPropertyPageView extends StatelessWidget {
  const AddPropertyPageView({super.key});

  @override
  Widget build(Object context) {
    // TODO: implement build
    return MultiBlocProvider(
      providers: [
        BlocProvider<AddPropertyCubit>(create: (context) => AddPropertyCubit()),
        BlocProvider<PropertyTypeCubit>(
            create: (context) => PropertyTypeCubit())
      ],
      child: AddPropertyPageBody(),
    );
  }
}

class AddPropertyPageBody extends StatelessWidget {
  final PageController pageController =
      PageController(initialPage: 0, keepPage: true);
  final ValueNotifier<int> onProgressIndicatorState = ValueNotifier(0);
  // Number of Pages for PageView
  final List<Widget> pages = [SelectPropertyType(), const HomePageView()];
  AddPropertyPageBody({super.key});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<AddPropertyCubit, AddPropertyState>(
        builder: (context, state) {
      int currentPage = state.pageViewNumber;
      return Scaffold(
          bottomNavigationBar: BottomController(
            currentPage: currentPage,
            pageController: pageController,
            listOfPages: pages,
          ),
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
            physics: const NeverScrollableScrollPhysics(),
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

class BottomController extends StatelessWidget {
  final PageController pageController;
  final int currentPage;
  final List<Widget> listOfPages;
  const BottomController(
      {super.key,
      required this.currentPage,
      required this.pageController,
      required this.listOfPages});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddPropertyCubit, AddPropertyState>(
        listener: (context, state) {
      pageController.animateToPage(state.pageViewNumber,
          duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    }, builder: (context, state) {
      return BottomAppBar(
        color: HSColor.background,
        padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextOnlyButton(
              label: HatSpaceStrings.of(context).back,
              onPressed: () {
                // pageController.animateToPage(currentPage - 1,
                //     duration: const Duration(milliseconds: 300),
                //     curve: Curves.easeIn);
                context
                    .read<AddPropertyCubit>()
                    .navigatePage(NavigatePage.preverse, listOfPages);
              },
              style: const ButtonStyle(
                  foregroundColor:
                      MaterialStatePropertyAll<Color>(HSColor.onSurface)),
              iconUrl: Assets.images.chevronLeft,
            ),
            PrimaryButton(
                label: HatSpaceStrings.of(context).next,
                onPressed: (state is NextButtonEnable)
                    ? () {
                        context
                            .read<AddPropertyCubit>()
                            .navigatePage(NavigatePage.forward, listOfPages);
                      }
                    : null,
                iconUrl: Assets.images.chevronRight,
                iconPosition: IconPosition.right)
          ],
        ),
      );
    });
  }
}
