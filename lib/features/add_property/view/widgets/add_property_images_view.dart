import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hatspace/dimens/hs_dimens.dart';
import 'package:hatspace/features/add_property/view_model/add_property_images/add_property_image_selected_cubit.dart';
import 'package:hatspace/features/add_property/view_model/add_property_images/add_property_images_cubit.dart';
import 'package:hatspace/features/select_photo/view/select_photo_bottom_sheet.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/route/router.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/extensions/bottom_modal_extension.dart';
import 'package:hatspace/theme/widgets/hs_warning_bottom_sheet.dart';

class AddPropertyImagesView extends StatelessWidget {
  const AddPropertyImagesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AddPropertyImagesCubit>(
          create: (context) => AddPropertyImagesCubit(),
        ),
        BlocProvider<AddPropertyImageSelectedCubit>(
          create: (context) => AddPropertyImageSelectedCubit(),
        )
      ],
      child: const AddPropertyImagesBody(),
    );
  }
}

class AddPropertyImagesBody extends StatefulWidget {
  const AddPropertyImagesBody({Key? key}) : super(key: key);

  @override
  AddPropertyImagesBodyState createState() => AddPropertyImagesBodyState();
}

class AddPropertyImagesBodyState extends State<AddPropertyImagesBody>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      context.read<AddPropertyImagesCubit>().screenResumed();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddPropertyImagesCubit, AddPropertyImagesState>(
      listener: (_, state) {
        if (state is PhotoPermissionDenied) {
          // do nothing
        }

        if (state is PhotoPermissionDeniedForever) {
          _showPhotoPermissionBottomSheet(context).then((result) {
            context
                .read<AddPropertyImagesCubit>()
                .onPhotoPermissionBottomSheetDismissed();
          });
        }

        if (state is PhotoPermissionGranted) {
          // open photo screen
          context.showSelectPhotoBottomSheet().then((result) {
            context
                .read<AddPropertyImagesCubit>()
                .onSelectPhotoBottomSheetDismissed();

            context
                .read<AddPropertyImageSelectedCubit>()
                .onPhotosSelected(result);
          });
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: HsDimens.spacing16, vertical: HsDimens.spacing24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(HatSpaceStrings.current.letAddSomePhotosOfYourPlace,
                  style: Theme.of(context).textTheme.displayLarge),
              const SizedBox(
                height: HsDimens.spacing8,
              ),
              Text(HatSpaceStrings.current.requireAtLeast4Photos,
                  style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(
                height: HsDimens.spacing20,
              ),
              BlocBuilder<AddPropertyImageSelectedCubit,
                  AddPropertyImageSelectedState>(
                builder: (context, state) {
                  if (state is PhotoSelectionReturned) {
                    return _PhotoPreviewView(
                      paths: state.paths,
                      moreUpload: state.allowAddImage,
                    );
                  }
                  return InkWell(
                    onTap: () {
                      context
                          .read<AddPropertyImagesCubit>()
                          .checkPhotoPermission();
                    },
                    child: SvgPicture.asset(Assets.images.uploadPhoto),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showPhotoPermissionBottomSheet(BuildContext context) {
    return context.showHsBottomSheet<void>(HsWarningBottomSheetView(
      title: HatSpaceStrings.current.hatSpaceWouldLikeToPhotoAccess,
      description:
          HatSpaceStrings.current.plsGoToSettingsAndAllowPhotoAccessForHatSpace,
      iconUrl: Assets.icons.photoAccess,
      primaryButtonLabel: HatSpaceStrings.current.goToSetting,
      primaryOnPressed: () {
        context.read<AddPropertyImagesCubit>().gotoSetting();
        context.pop();
      },
      secondaryButtonLabel: HatSpaceStrings.current.cancelBtn,
      secondaryOnPressed: () {
        context.read<AddPropertyImagesCubit>().cancelPhotoAccess();
        context.pop();
      },
    ));
  }
}

class _PhotoPreviewView extends StatelessWidget {
  final List<String> paths;
  final bool moreUpload;
  const _PhotoPreviewView(
      {required this.paths, required this.moreUpload, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        children: [
          // first photo, large full display
          AspectRatio(
              aspectRatio: 343 / 220,
              child: ImagePreviewView(
                  path: paths.first,
                  closePadding: const EdgeInsets.all(HsDimens.spacing8))),
          const SizedBox(
            height: HsDimens.spacing8,
          ),
          GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.0,
                crossAxisSpacing: HsDimens.spacing8,
                mainAxisSpacing: HsDimens.spacing8),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: _generateGridChildren(),
          )
        ],
      );

  List<Widget> _generateGridChildren() {
    final List<Widget> widgets = paths
        .sublist(1)
        .map<Widget>((e) => ImagePreviewView(
              path: e,
            ))
        .toList();

    if (moreUpload) {
      widgets.add(SvgPicture.asset(Assets.images.upload));
    }

    return widgets;
  }
}

class ImagePreviewView extends StatelessWidget {
  final String path;
  final EdgeInsets? closePadding;
  const ImagePreviewView({required this.path, this.closePadding, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(HsDimens.radius8),
          image:
              DecorationImage(image: FileImage(File(path)), fit: BoxFit.cover)),
      child: Container(
        padding: closePadding ?? const EdgeInsets.all(HsDimens.spacing2),
        alignment: Alignment.topRight,
        child: InkWell(
          borderRadius: BorderRadius.circular(HsDimens.radius48),
          child: SvgPicture.asset(
            Assets.icons.closeCircle,
          ),
        ),
      ));
}
