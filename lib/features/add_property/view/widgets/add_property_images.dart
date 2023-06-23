import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hatspace/dimens/hs_dimens.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/strings/l10n.dart';

class AddPropertyImages extends StatelessWidget {
  const AddPropertyImages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: HsDimens.spacing16, vertical: HsDimens.spacing24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(HatSpaceStrings.current.letAddSomePhotosOfYourPlace,
                style: Theme.of(context).textTheme.displayLarge),
            const SizedBox(height: HsDimens.spacing8,),
            Text(HatSpaceStrings.current.requireAtLeast4Photos,
                style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: HsDimens.spacing20,),
            InkWell(
              onTap: () {},
              child: SvgPicture.asset(Assets.images.uploadPhoto),
            ),
          ],
        ),
      ),
    );
  }
}
