import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hatspace/data/property_data.dart';
import 'package:hatspace/dimens/hs_dimens.dart';
import 'package:hatspace/features/inspection_detail/widgets/inspection_information_view.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/route/router.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/hs_theme.dart';

class InspectionDetailScreen extends StatelessWidget {
  final String id;
  const InspectionDetailScreen({required this.id, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(HatSpaceStrings.current.details,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontStyleGuide.fwBold)),

        /// TODO : Enable later when implement deletion
        // actions: [
        // IconButton(
        //   onPressed: () {
        //     // TODO : Handle on delete tapped
        //   },
        //   icon: SvgPicture.asset(
        //     Assets.icons.delete,
        //     colorFilter:
        //         const ColorFilter.mode(HSColor.red05, BlendMode.srcIn),
        //     width: HsDimens.size24,
        //     height: HsDimens.size24,
        //   ),
        // )
        // ],
        backgroundColor: HSColor.neutral1,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: SvgPicture.asset(Assets.icons.arrowCalendarLeft),
        ),
        elevation: 0,
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(HsDimens.size1),
            child: Container(
              color: HSColor.neutral2,
              height: HsDimens.size1,
            )),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: HsDimens.spacing16),
                child: InspectionInformationView(
                    propertyImageUrl:
                        'https://img.staticmb.com/mbcontent/images/uploads/2022/12/Most-Beautiful-House-in-the-World.jpg',
                    propertyTitle: 'Green living space in Melbourne',
                    propertyPrice: 4800,
                    propertyState: 'Victoria',
                    propertySymbol: r'$',
                    userName: 'Yolo Tim',
                    type: PropertyTypes.apartment,
                    startTime: DateTime(2023, 9, 15, 9),
                    endTime: DateTime(2023, 9, 15, 10),
                    rentingDuration: HatSpaceStrings.current.pw,
                    notes: 'My number is 0438825121')),
          ),
          // TODO : Enable later when implement edit feature
          // Positioned(
          //     bottom: 0,
          //     left: HsDimens.spacing16,
          //     right: HsDimens.spacing16,
          //     child: Container(
          //       padding: const EdgeInsets.only(
          //         top: HsDimens.spacing8,
          //         bottom: HsDimens.spacing42,
          //       ),
          //       decoration: const BoxDecoration(
          //           border: Border(
          //               top: BorderSide(
          //                   width: HsDimens.size1, color: HSColor.neutral2))),
          //       child: SecondaryButton(
          //         label: 'Edit',
          //         iconUrl: Assets.icons.edit,
          //         onPressed: () {
          //           // TODO : Handle on edit tapped
          //         },
          //       ),
          //     ))
        ],
      ),
    );
  }
}
