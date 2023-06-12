import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hatspace/dimens/hs_dimens.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/route/router.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';

class WarningBottomSheetView extends StatelessWidget{
  final BuildContext bottomModalContext;
  const WarningBottomSheetView({super.key,
  required this.bottomModalContext
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return
      Padding(
        padding: const EdgeInsets.symmetric(vertical: HsDimens.spacing32, horizontal:HsDimens.spacing24),
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.end,
      children: [
      Column(
          children: [
            SvgPicture.asset(Assets.images.circleWarning),
            const SizedBox(height: HsDimens.spacing24,),
          Text(HatSpaceStrings.of(context).lostData, style: textTheme.displayLarge?.copyWith(fontSize: 18.0)),
          const SizedBox(height: HsDimens.spacing4),
            Text(HatSpaceStrings.of(context).yourDataMayBeLost,overflow: TextOverflow.ellipsis,maxLines: 3,textAlign: TextAlign.center,)
          ],
        ),
        const SizedBox(height: HsDimens.spacing24),

      

        // Button group
        
        Column(
          children: [
            PrimaryButton(label: "No", onPressed: (){
              // TODO; close bottom sheet, no data save
              context.pop();
            }),
            const SizedBox(height: HsDimens.spacing16),
            SecondaryButton(label: "Yes", onPressed: (){
              //TODO: close button sheet, erase data.
              context.pop();
            })
          ],
        )
      ],
    )
      );
    
  }


}