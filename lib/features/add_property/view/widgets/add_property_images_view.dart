import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hatspace/dimens/hs_dimens.dart';
import 'package:hatspace/features/add_property/view_model/add_property_images/add_property_images_cubit.dart';
import 'package:hatspace/gen/assets.gen.dart';
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
    print('xxx - didChangeAppLifecycleState - state=$state');
    if (state == AppLifecycleState.resumed) {
      print('xxx - didChangeAppLifecycleState - resume app');
      context.read<AddPropertyImagesCubit>().screenResumed();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddPropertyImagesCubit, AddPropertyImagesState>(
      listener: (_, state) {
        print('xxx - state=$state');
        if (state is PhotoPermissionDenied) {
          // do nothing
        }

        if (state is PhotoPermissionDeniedForever) {
          _showGoToSettingBottomSheet(context).then((result) {
            if (result == null || !result) {
              _dismissBottomSheet(context);
            }
          });
        }

        if (state is PhotoPermissionGranted) {
          // open photo screen
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
    return context.showHsBottomSheet(HsWarningBottomSheetView(
      title: HatSpaceStrings.current.hatSpaceWouldLikeToPhotoAccess,
      description:
          HatSpaceStrings.current.plsGoToSettingsAndAllowPhotoAccessForHatSpace,
      iconUrl: Assets.icons.photoAccess,
      primaryButtonLabel: HatSpaceStrings.current.goToSetting,
      primaryOnPressed: () {
        _goToSetting(context);
        Navigator.of(context).pop();
      },
      secondaryButtonLabel: HatSpaceStrings.current.cancelBtn,
      secondaryOnPressed: () {
        _cancelGotoSetting(context);
        Navigator.of(context).pop();
      },
    ));
  }

  void _dismissBottomSheet(BuildContext context) {
    context.read<AddPropertyImagesCubit>().dismissBottomSheet();
  }

  void _cancelGotoSetting(BuildContext context) {
    context.read<AddPropertyImagesCubit>().cancelPhotoAccess();
  }

  void _goToSetting(BuildContext context) {
    context.read<AddPropertyImagesCubit>().gotoSetting();
  }
}
