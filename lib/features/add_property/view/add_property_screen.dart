import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatspace/dimens/hs_dimens.dart';
import 'package:hatspace/features/add_property/view/widgets/add_property_features_view.dart';
import 'package:hatspace/features/add_property/view/widgets/add_property_images_view.dart';
import 'package:hatspace/features/add_property/view/widgets/add_property_preview_view.dart';
import 'package:hatspace/features/add_property/view/widgets/add_property_rooms_view.dart';
import 'package:hatspace/features/add_property/view/widgets/add_property_info_view/add_property_info_form_view.dart';
import 'package:hatspace/features/add_property/view/widgets/add_property_type_view.dart';
import 'package:hatspace/features/add_property/view_model/add_property_cubit.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/route/router.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/extensions/bottom_modal_extension.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:hatspace/theme/pop_up/pop_up_controller.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';
import 'package:hatspace/theme/widgets/hs_buttons_settings.dart';
import 'package:hatspace/theme/widgets/hs_warning_bottom_sheet.dart';

class AddPropertyView extends StatelessWidget {
  const AddPropertyView({super.key});

  @override
  Widget build(Object context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AddPropertyCubit>(
            create: (context) =>
                AddPropertyCubit()..validateNextButtonState(0)),
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
    const AddPropertyTypeView(),
    AddPropertyInfoFormView(),
    const AddPropertyRoomsView(),
    const AddPropertyFeaturesView(),
    const AddPropertyImagesView(),
    const AddPropertyPreviewView()
  ];

  Future<void> showLostDataModal(BuildContext context) {
    HsWarningBottomSheetView lostDataModal = HsWarningBottomSheetView(
        iconUrl: Assets.images.circleWarning,
        title: HatSpaceStrings.current.lostDataTitle,
        description: HatSpaceStrings.current.lostDataDescription,
        primaryButtonLabel: HatSpaceStrings.current.no,
        primaryOnPressed: () {
          context.pop();
        },
        secondaryButtonLabel: HatSpaceStrings.current.yes,
        secondaryOnPressed: () {
          context.read<AddPropertyCubit>().onResetData();
          context.pop();
        });
    return context.showHsBottomSheet(lostDataModal);
  }

  AddPropertyPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () {
        context.read<AddPropertyCubit>().onBackPressed(pages.length);

        return Future.value(false);
      },
      child: BlocListener<AddPropertyCubit, AddPropertyState>(
        listenWhen: (previous, current) => current is ExitAddPropertyFlow,
        listener: (context, state) {
          context.pop();
        },
        child: Scaffold(
          bottomNavigationBar: BottomController(
            pageController: pageController,
            totalPages: pages.length,
          ),
          appBar: AppBar(
            elevation: 0,
            backgroundColor: HSColor.background,
            leading: BlocListener<AddPropertyCubit, AddPropertyState>(
              listener: (_, state) {
                if (state is OpenLostDataWarningModal) {
                  showLostDataModal(context).then((value) {
                    context.read<AddPropertyCubit>().onCloseLostDataModal();
                  });
                }
              },
              child: IconButton(
                icon: const Icon(Icons.close, color: HSColor.onSurface),
                onPressed: () {
                  context.read<AddPropertyCubit>().onShowLostDataModal();
                },
              ),
            ),
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
          ),
        ),
      ),
    );
  }
}

class BottomController extends StatelessWidget {
  final PageController pageController;
  final int totalPages;

  const BottomController(
      {required this.pageController, required this.totalPages, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddPropertyCubit, AddPropertyState>(
        listener: (context, state) {
          if (state is PageViewNavigationState) {
            pageController.animateToPage(state.pageViewNumber,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeIn);
          }

          if (state is StartSubmitPropertyDetails) {
            context.showLoading();
          }

          if (state is EndSubmitPropertyDetails) {
            context.dismissLoading();
            context.goToPropertyDetail();
          }
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
                  context
                      .read<AddPropertyCubit>()
                      .onBackPressed(state.pageViewNumber);
                } else {
                  context
                      .read<AddPropertyCubit>()
                      .navigatePage(NavigatePage.reverse, totalPages);
                }
              },
              style: const ButtonStyle(
                  foregroundColor:
                      MaterialStatePropertyAll<Color>(HSColor.onSurface)),
              iconUrl: Assets.icons.chevronLeft,
            ),
            if (state is NextButtonEnable || state is StartSubmitPropertyDetails)
              PrimaryButton(
                  label: state is NextButtonEnable
                      ? state.btnLabel.label
                      : ButtonLabel.submit.label,
                  onPressed: (state is NextButtonEnable && state.isActive)
                      ? () {
                          context
                              .read<AddPropertyCubit>()
                              .navigatePage(NavigatePage.forward, totalPages);
                        }
                      : null,
                  iconUrl: (state is NextButtonEnable && state.showRightChevron)
                      ? Assets.icons.chevronRight
                      : null,
                  iconPosition:
                      (state is NextButtonEnable && state.showRightChevron)
                          ? IconPosition.right : null),
          ],
        ),
      );
    });
  }
}
