import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hatspace/dimens/hs_dimens.dart';
import 'package:hatspace/features/add_property/view_model/add_property_cubit.dart';
import 'package:hatspace/features/add_property/view_model/add_property_images/add_property_image_selected_cubit.dart';
import 'package:hatspace/features/select_photo/view/select_photo_bottom_sheet.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/hs_theme.dart';

class AddPropertyImagesView extends StatelessWidget {
  const AddPropertyImagesView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AddPropertyImageSelectedCubit>(
          create: (context) => AddPropertyImageSelectedCubit(),
        )
      ],
      child: const AddPropertyImagesBody(),
    );
  }
}

class AddPropertyImagesBody extends StatefulWidget {
  const AddPropertyImagesBody({super.key});

  @override
  AddPropertyImagesBodyState createState() => AddPropertyImagesBodyState();
}

class AddPropertyImagesBodyState extends State<AddPropertyImagesBody> {
  @override
  void initState() {
    super.initState();

    final List<String> selectedPhotos = context.read<AddPropertyCubit>().photos;
    context
        .read<AddPropertyImageSelectedCubit>()
        .onPhotosSelected(selectedPhotos);
  }

  @override
  Widget build(BuildContext context) => Padding(
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
                    context.read<AddPropertyCubit>().validateNextButtonState(4);
                    return _PhotoPreviewView(
                      paths: state.paths,
                      moreUpload: state.allowAddImage,
                    );
                  }
                  return InkWell(
                    onTap: () {
                      // open photo screen
                      context.showSelectPhotoBottomSheet().then((result) {
                        context
                            .read<AddPropertyImageSelectedCubit>()
                            .onPhotosSelected(result);

                        if (result != null) {
                          context.read<AddPropertyCubit>().photos = result;
                        }
                      });
                    },
                    child: SvgPicture.asset(Assets.images.uploadPhoto),
                  );
                },
              ),
            ],
          ),
        ),
      );
}

class _PhotoPreviewView extends StatelessWidget {
  final List<String> paths;
  final bool moreUpload;

  const _PhotoPreviewView({required this.paths, required this.moreUpload});

  @override
  Widget build(BuildContext context) => Column(
        children: [
          // first photo, large full display
          AspectRatio(
              aspectRatio: 343 / 220,
              child: Stack(
                children: [
                  ImagePreviewView(
                      path: paths.first,
                      closePadding: const EdgeInsets.all(HsDimens.spacing8)),
                  Container(
                    decoration: const ShapeDecoration(
                        shape: StadiumBorder(), color: HSColor.neutral1),
                    margin: const EdgeInsets.all(HsDimens.spacing8),
                    padding: const EdgeInsets.symmetric(
                        horizontal: HsDimens.spacing8,
                        vertical: HsDimens.spacing4),
                    child: Text(HatSpaceStrings.current.coverPhoto),
                  )
                ],
              )),
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
            children: _generateGridChildren(context),
          )
        ],
      );

  List<Widget> _generateGridChildren(BuildContext context) {
    final List<Widget> widgets = paths
        .sublist(1)
        .map<Widget>((e) => ImagePreviewView(
              path: e,
            ))
        .toList();

    if (moreUpload) {
      widgets.add(InkWell(
        onTap: () {
          context.showSelectPhotoBottomSheet(paths).then((result) {
            context
                .read<AddPropertyImageSelectedCubit>()
                .onPhotosSelected(result);

            if (result != null) {
              context.read<AddPropertyCubit>().photos = result;
            }
          });
        },
        child: SvgPicture.asset(Assets.images.upload),
      ));
    }

    return widgets;
  }
}

class ImagePreviewView extends StatelessWidget {
  final String path;
  final EdgeInsets? closePadding;

  const ImagePreviewView({required this.path, this.closePadding, super.key});

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
          onTap: () {
            context
                .read<AddPropertyImageSelectedCubit>()
                .removePhoto(context.read<AddPropertyCubit>().photos, path);
          },
          borderRadius: BorderRadius.circular(HsDimens.radius48),
          child: SvgPicture.asset(
            Assets.icons.closeCircle,
          ),
        ),
      ));
}
