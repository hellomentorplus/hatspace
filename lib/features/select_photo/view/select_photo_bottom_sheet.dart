import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hatspace/features/select_photo/view/widgets/item_square_view.dart';
import 'package:hatspace/features/select_photo/view_model/lost_data_bottom_sheet_cubit.dart';
import 'package:hatspace/features/select_photo/view_model/photo_selection_cubit.dart';
import 'package:hatspace/features/select_photo/view_model/select_photo_cubit.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/route/router.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/extensions/bottom_modal_extension.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:hatspace/dimens/hs_dimens.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';

import 'package:hatspace/theme/widgets/hs_warning_bottom_sheet.dart';

enum PhotoTabs {
  allPhotos,
  // TODO add tab Album
  ;

  String get labelDisplay {
    switch (this) {
      case PhotoTabs.allPhotos:
        return HatSpaceStrings.current.allPhotos;
      // TODO add other tab
    }
  }

  Widget get tabView {
    switch (this) {
      case PhotoTabs.allPhotos:
        return const AllPhotosView();
      // TODO add other tab
    }
  }
}

class SelectPhotoBottomSheet extends StatelessWidget {
  const SelectPhotoBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider<SelectPhotoCubit>(
            create: (context) => SelectPhotoCubit()..loadPhotos(),
          ),
          BlocProvider<PhotoSelectionCubit>(
            create: (context) => PhotoSelectionCubit(),
          ),
          BlocProvider<LostDataBottomSheetCubit>(
            create: (context) => LostDataBottomSheetCubit(),
          )
        ],
        child: const SelectPhotoBody(),
      );
}

class SelectPhotoBody extends StatefulWidget {
  const SelectPhotoBody({Key? key}) : super(key: key);

  @override
  State<SelectPhotoBody> createState() => _SelectPhotoBodyState();
}

class _SelectPhotoBodyState extends State<SelectPhotoBody>
    with TickerProviderStateMixin {
  late final TabController tabController =
      TabController(length: 1, vsync: this);

  void _closeSelectPhotoBottomSheet(BuildContext context) {
    int selectedItemCount =
        context.read<PhotoSelectionCubit>().selectedItemCount;
    context
        .read<LostDataBottomSheetCubit>()
        .onCloseSelectPhotoBottomSheetTapped(selectedItemCount);
  }

  void _closeSelectPhotoBottomSheetWithoutSavingPhoto(BuildContext context) {
    context.read<LostDataBottomSheetCubit>().closeSelectPhotoBottomSheet();
  }

  Future<void> showLostDataBottomSheet(BuildContext context) {
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
          _closeSelectPhotoBottomSheetWithoutSavingPhoto(context);
          context.pop();
        });
    return context.showHsBottomSheet(lostDataModal);
  }

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async {
          _closeSelectPhotoBottomSheet(context);
          return false;
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(HsDimens.radius10),
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.background,
              title: TabBar(
                  labelColor: HSColor.black,
                  labelStyle: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w700),
                  labelPadding: const EdgeInsets.symmetric(
                      horizontal: HsDimens.spacing8,
                      vertical: HsDimens.spacing6),
                  indicatorColor: Colors.transparent,
                  controller: tabController,
                  tabs: PhotoTabs.values
                      .map((e) => Text(e.labelDisplay))
                      .toList()),
              actions: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                  child: BlocListener<LostDataBottomSheetCubit,
                      LostDataBottomSheetState>(
                    listener: (context, state) {
                      if (state is OpenLostDataBottomSheet) {
                        showLostDataBottomSheet(context);
                      }

                      if (state is CloseLostDataBottomSheet) {
                        context.pop();
                      }

                      if (state is ExitSelectPhoto) {
                        context.pop();
                      }
                    },
                    child: InkWell(
                      onTap: () {
                        _closeSelectPhotoBottomSheet(context);
                      },
                      borderRadius: BorderRadius.circular(HsDimens.size24),
                      child: SvgPicture.asset(
                        Assets.icons.close,
                        width: HsDimens.size24,
                        height: HsDimens.size24,
                      ),
                    ),
                  ),
                )
              ],
            ),
            body: TabBarView(
              controller: tabController,
              children: PhotoTabs.values.map((e) => e.tabView).toList(),
            ),
          ),
        ),
      );
}

class AllPhotosView extends StatelessWidget {
  const AllPhotosView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: BlocBuilder<SelectPhotoCubit, SelectPhotoState>(
          builder: (context, state) {
            if (state is PhotosLoaded) {
              return GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: 1,
                      crossAxisSpacing: 1),
                  children: List.generate(
                    state.photos.length,
                    (index) => ImageSquareView(index: index),
                  ));
            }

            return const SizedBox();
          },
        )),
        BlocBuilder<PhotoSelectionCubit, PhotoSelectionState>(
          builder: (context, state) {
            int count = 0;
            bool uploadEnable = false;

            if (state is PhotoSelectionUpdated) {
              count = state.count;
              uploadEnable = state.enableUpload;
            }

            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: HsDimens.spacing16,
                    vertical: HsDimens.spacing8),
                child: PrimaryButton(
                  label: HatSpaceStrings.current.uploadPhotoCount(count),
                  onPressed: uploadEnable
                      ? () {
                          if (state is PhotoSelectionUpdated) {
                            Navigator.of(context)
                                .pop(state.selectedItems.toList());
                          }
                        }
                      : null,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

extension SelectPhotoBottomSheetExtension on BuildContext {
  Future<List<String>?> showSelectPhotoBottomSheet() {
    return showModalBottomSheet<List<String>>(
      context: this,
      isScrollControlled: true,
      useSafeArea: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(HsDimens.radius10)),
      builder: (context) => const FractionallySizedBox(
          heightFactor: 0.95, child: SelectPhotoBottomSheet()),
    );
  }
}
