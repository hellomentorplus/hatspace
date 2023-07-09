import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hatspace/dimens/hs_dimens.dart';
import 'package:hatspace/features/add_property/view_model/add_property_images/add_property_images_cubit.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/route/router.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/extensions/bottom_modal_extension.dart';
import 'package:hatspace/theme/widgets/hs_warning_bottom_sheet.dart';

class AddPropertyImagesView extends StatelessWidget {
  const AddPropertyImagesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddPropertyImagesCubit>(
      create: (context) => AddPropertyImagesCubit(),
      child: const AddPropertyImagesBody(),
    );
  }
}

class AddPropertyImagesBody extends StatefulWidget {
  const AddPropertyImagesBody({Key? key}) : super(key: key);

  @override
  _AddPropertyImagesBodyState createState() => _AddPropertyImagesBodyState();
}

class _AddPropertyImagesBodyState extends State<AddPropertyImagesBody>
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

        if (state is OpenSelectPhotoScreen) {
          _showSelectPhotoBottomSheet(context).then((isShown) {
            context
                .read<AddPropertyImagesCubit>()
                .dismissSelectPhotoPermissionBottomSheet(isShown);
          });
        }

        if (state is PhotoPermissionDeniedForever) {
          _showGoToSettingBottomSheet(context).then((isShown) {
            context
                .read<AddPropertyImagesCubit>()
                .dismissPhotoPermissionBottomSheet(isShown);
          });
        }

        if (state is PhotoPermissionGranted) {
          context.read<AddPropertyImagesCubit>().openSelectPhotoBottomSheet();
        }
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: HsDimens.spacing16, vertical: HsDimens.spacing24),
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
              InkWell(
                onTap: () {
                  print('onTap');
                  context.read<AddPropertyImagesCubit>().checkPhotoPermission();
                },
                child: SvgPicture.asset(Assets.images.uploadPhoto),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool?> _showGoToSettingBottomSheet(BuildContext context) {
    return context.showHsBottomSheet<bool>(HsWarningBottomSheetView(
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

  Future<bool?> _showSelectPhotoBottomSheet(BuildContext context) {
    return showModalBottomSheet<bool>(
        context: context,
        builder: (_) {
          return Container(
            height: 200,
            color: Colors.amber,
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text('Select Photo'),
                ],
              ),
            ),
          );
        });
  }
}
