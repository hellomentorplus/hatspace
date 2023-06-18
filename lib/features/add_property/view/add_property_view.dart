import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatspace/dimens/hs_dimens.dart';
import 'package:hatspace/features/add_property/view_model/add_property_cubit.dart';
import 'package:hatspace/features/add_property/view_model/add_property_state.dart';
import 'package:hatspace/features/add_property_type/view/select_property_type.dart';
import 'package:hatspace/features/add_property_type/view_modal/property_type_cubit.dart';
import 'package:hatspace/features/warning_bottom_sheet/warning_bottom_sheet_view.dart';

import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/route/router.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';
import 'package:hatspace/theme/widgets/hs_buttons_settings.dart';

class AddPropertyView extends StatelessWidget {
  const AddPropertyView({super.key});
  @override
  Widget build(Object context) {
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
  final List<Widget> pages = [
    const SelectPropertyType(),
  ];
  AddPropertyPageBody({super.key});
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
       return BlocListener<AddPropertyCubit, AddPropertyState>(
        listener: (context, state) {
          if (state is AddPropertyPageClosedState) {
            context.popToRootHome();
          }
        },
        child: Scaffold(
            bottomNavigationBar: BottomController(
              pageController: pageController,
              totalPages: pages.length,
            ),
            appBar: AppBar(
              elevation: 0,
              backgroundColor: HSColor.background,
              leading: IconButton(
                icon: const Icon(Icons.close, color: HSColor.onSurface),
                onPressed: () {
                  // HS-99 scenario 6
                  // context.popToRootHome();
                  showModalBottomSheet(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      context: context,
                      builder: (modalContext) {
                        return Wrap(
                          children: [
                            WarningBottomSheetView(isClosed: (isClosed){
                                if(isClosed){
                                  context.read<AddPropertyCubit>().closeAddPropertyPage();
                                }else{
                                  context.pop();
                                }
                            })
                          ],
                        );
                  });
              }),
          bottom: PreferredSize(
              preferredSize: Size(size.width, 0),
              child: BlocSelector<AddPropertyCubit, AddPropertyState, int>(
                selector: (state) => state.pageViewNumber,
                builder: (context, state) {
                  return LinearProgressIndicator(
                    backgroundColor: HSColor.neutral2,
                    color: HSColor.primary,
                    value: (state + 1) / pages.length,
                    semanticsLabel:
                        HatSpaceStrings.of(context).linearProgressIndicator,
                  );
                },
              )),
        ),
        body: PageView.builder(
          onPageChanged: (value) {
            onProgressIndicatorState.value = value;
          },
          itemCount: pages.length,
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          itemBuilder: (context, index) {
            return pages[index];
          },
        )));
  }
}

class BottomController extends StatelessWidget {
  final PageController pageController;
  final int totalPages;
  const BottomController(
      {super.key, required this.pageController, required this.totalPages});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddPropertyCubit, AddPropertyState>(
        listener: (context, state) {
      pageController.animateToPage(state.pageViewNumber,
          duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    }, builder: (context, state) {
      return BottomAppBar(
        color: HSColor.background,
        padding: const EdgeInsets.only(
            left: HsDimens.spacing16,
            right: HsDimens.spacing16,
            top: HsDimens.spacing8,
            bottom: 29.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextOnlyButton(
              label: HatSpaceStrings.of(context).back,
              onPressed: () {
                if (state.pageViewNumber == 0) {
                  context.popToRootHome();
                } else {
                  context
                      .read<AddPropertyCubit>()
                      .navigatePage(NavigatePage.reverse, totalPages);
                }
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
                            .navigatePage(NavigatePage.forward, totalPages);
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
