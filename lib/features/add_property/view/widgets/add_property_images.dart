import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hatspace/dimens/hs_dimens.dart';
import 'package:hatspace/features/add_property/view_model/add_properties_images/add_property_images_cubit.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/strings/l10n.dart';

class AddPropertyImages extends StatelessWidget {
  const AddPropertyImages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddPropertyImagesCubit>(create: (context) => AddPropertyImagesCubit(),
        child: BlocBuilder<AddPropertyImagesCubit, AddPropertyImagesState>(
            builder: (context, state) {
              if (state is PhotoPermissionDenied) {
                // do nothing
              }

              if (state is PhotoPermissionDeniedForever) {
                // open app setting
              }

              if (state is PhotoPermissionGranted) {
                // open photo screen
              }

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: HsDimens.spacing16,
                      vertical: HsDimens.spacing24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(HatSpaceStrings.current.letAddSomePhotosOfYourPlace,
                          style: Theme
                              .of(context)
                              .textTheme
                              .displayLarge),
                      const SizedBox(
                        height: HsDimens.spacing8,
                      ),
                      Text(HatSpaceStrings.current.requireAtLeast4Photos,
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyMedium),
                      const SizedBox(
                        height: HsDimens.spacing20,
                      ),
                      InkWell(
                        onTap: () {
                          context.read<AddPropertyImagesCubit>()
                              .requestPhotoPermission();
                        },
                        child: SvgPicture.asset(Assets.images.uploadPhoto),
                      ),
                    ],
                  ),
                ),
              );
            }
        ),
    );
  }
}
