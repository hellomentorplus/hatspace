import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hatspace/data/property_data.dart';
import 'package:hatspace/dimens/hs_dimens.dart';
import 'package:hatspace/features/booking/widgets/booking_information_view.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/route/router.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';

class BookingDetailScreen extends StatelessWidget {
  final String id;
  const BookingDetailScreen({required this.id, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(HatSpaceStrings.current.details,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontStyleGuide.fwBold)),
        actions: [
          IconButton(
            onPressed: () {
              // TODO : Handle on delete tapped
            },
            icon: SvgPicture.asset(
              Assets.icons.delete,
              colorFilter:
                  const ColorFilter.mode(HSColor.red05, BlendMode.srcIn),
              width: HsDimens.size24,
              height: HsDimens.size24,
            ),
          )
        ],
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
                child: BookingInformationView(
                    propertyImageUrl:
                        'https://images.unsplash.com/photo-1575936123452-b67c3203c357?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aW1hZ2V8ZW58MHx8MHx8fDA%3D&w=1000&q=80',
                    propertyTitle: 'Single room for rent in Bankstown',
                    propertyPrice: 200,
                    propertyState: 'Gateway, Island',
                    propertySymbol: r'$',
                    userAvatar:
                        'https://images.unsplash.com/photo-1575936123452-b67c3203c357?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aW1hZ2V8ZW58MHx8MHx8fDA%3D&w=1000&q=80',
                    userName: 'Jane Cooper',
                    type: PropertyTypes.house,
                    startTime: DateTime(2023, 8, 12, 1),
                    endTime: DateTime(2023, 8, 12, 8),
                    notes:
                        'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint.')),
          ),
          Positioned(
              bottom: 0,
              left: HsDimens.spacing16,
              right: HsDimens.spacing16,
              child: Container(
                padding: const EdgeInsets.only(
                  top: HsDimens.spacing8,
                  bottom: HsDimens.spacing42,
                ),
                decoration: const BoxDecoration(
                    border: Border(
                        top: BorderSide(
                            width: HsDimens.size1, color: HSColor.neutral2))),
                child: SecondaryButton(
                  label: 'Edit',
                  iconUrl: Assets.icons.edit,
                  onPressed: () {
                    // TODO : Handle on edit tapped
                  },
                ),
              ))
        ],
      ),
    );
  }
}
