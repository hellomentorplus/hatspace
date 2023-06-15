import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hatspace/dimens/hs_dimens.dart';
import 'package:hatspace/features/add_property/view/add_property_view.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/route/router.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';

class WarningBottomSheetView extends StatelessWidget {
  final ValueChanged isClosed;
  const WarningBottomSheetView({
    super.key,
    required this.isClosed
  });
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
        key: const Key("warning_bottom_modal"),
        padding: const EdgeInsets.symmetric(
            vertical: HsDimens.spacing32, horizontal: HsDimens.spacing24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              children: [
                SvgPicture.asset(Assets.images.circleWarning),
                const SizedBox(
                  height: HsDimens.spacing24,
                ),
                Text(HatSpaceStrings.of(context).lostData,
                    style: textTheme.displayLarge?.copyWith(fontSize: 18.0)),
                const SizedBox(height: HsDimens.spacing4),
                Text(
                  HatSpaceStrings.of(context).yourDataMayBeLost,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  textAlign: TextAlign.center,
                )
              ],
            ),
            const SizedBox(height: HsDimens.spacing24),

            // Button group

            Column(
              children: [
                PrimaryButton(
                    label: HatSpaceStrings.of(context).no,
                    onPressed: () {
                      // TODO; close bottom sheet, no data save
                      isClosed(false);
                    }),
                const SizedBox(height: HsDimens.spacing16),
                SecondaryButton(
                    label: HatSpaceStrings.of(context).yes,
                    onPressed: () {
                      //TODO: close button sheet, erase data.
                      isClosed(true);
                    })
              ],
            )
          ],
        ));
  }
}
