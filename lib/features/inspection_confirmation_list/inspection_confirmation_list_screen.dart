import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hatspace/dimens/hs_dimens.dart';
import 'package:hatspace/route/router.dart';

import 'package:hatspace/data/property_data.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/hs_theme.dart';

class InspectionConfirmationListScreen extends StatelessWidget {
  final String id;

  const InspectionConfirmationListScreen({required this.id, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Green living space in Melbourne',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontStyleGuide.fwBold,
                fontSize: FontStyleGuide.fontSize14)),
        backgroundColor: HSColor.neutral1,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: SvgPicture.asset(Assets.icons.arrowCalendarLeft),
        ),
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(HsDimens.size1),
            child: Container(
              color: HSColor.neutral2,
              height: HsDimens.size1,
            )),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(HsDimens.spacing16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                HatSpaceStrings.current.numberOfInspectionBooking(1),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: FontStyleGuide.fontSize16,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: HsDimens.lineheight12),
              InkWell(
                onTap: () => context.goToInspectionConfirmationDetail(id: '1'),
                child: const BookingInformationItem(
                  propertyName: 'Green living space in Melbourne',
                  propertyImage:
                      'https://img.staticmb.com/mbcontent/images/uploads/2022/12/Most-Beautiful-House-in-the-World.jpg',
                  propertyType: PropertyTypes.apartment,
                  price: 4800,
                  currency: Currency.aud,
                  timeRenting: 'pw',
                  state: AustraliaStates.vic,
                  timeBooking: '09:00 AM-10:00 AM - 15 Sep, 2023',
                  ownerName: 'Captain Cole',
                  ownerAvatar: null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BookingInformationItem extends StatelessWidget {
  final String propertyImage;
  final String propertyName;
  final PropertyTypes propertyType;
  final double price;
  final Currency currency;
  final String timeRenting;
  final AustraliaStates state;
  final String timeBooking; // todo: need to update after demo
  final String? ownerName;
  final String? ownerAvatar;

  const BookingInformationItem({
    required this.propertyImage,
    required this.propertyName,
    required this.propertyType,
    required this.price,
    required this.currency,
    required this.timeRenting,
    required this.state,
    required this.timeBooking,
    this.ownerName,
    this.ownerAvatar,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5, // Controls the shadow depth
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(HsDimens.radius10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(HsDimens.spacing16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: HsDimens.size110,
                  height: HsDimens.size110,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(HsDimens.radius8),
                    child: Image.network(
                      propertyImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: HsDimens.spacing16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          propertyType.displayName,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).colorScheme.primary),
                        ),
                        const SizedBox(
                          height: HsDimens.spacing5,
                        ),
                        Text(propertyName,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontWeight: FontStyleGuide.fwBold,
                                )),
                        const SizedBox(
                          height: HsDimens.spacing5,
                        ),
                        Text(state.displayName,
                            style: Theme.of(context).textTheme.bodySmall),
                        const SizedBox(
                          height: HsDimens.spacing4,
                        ),
                        Text.rich(TextSpan(
                            text: HatSpaceStrings.current
                                .currencyFormatter(currency.symbol, price),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    fontSize: FontStyleGuide.fontSize18,
                                    height: 28 / 18,
                                    fontWeight: FontWeight.w700),
                            children: [
                              TextSpan(
                                  text: ' $timeRenting',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(color: HSColor.neutral6))
                            ])),
                        const SizedBox(
                          height: HsDimens.spacing4,
                        ),
                        if (ownerName != null)
                          _OwnerView(
                            ownerName: ownerName!,
                            ownerAvatar: ownerAvatar,
                          )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: HsDimens.spacing12),
              child: SvgPicture.asset(
                Assets.images.dashedDivider,
                fit: BoxFit.fitWidth,
              ),
            ),
            _TimeRentingView(timeBooking: timeBooking)
          ],
        ),
      ),
    );
  }
}

class _OwnerView extends StatelessWidget {
  final String ownerName;
  final String? ownerAvatar;

  const _OwnerView({required this.ownerName, required this.ownerAvatar});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: HsDimens.size24,
          height: HsDimens.size24,
          decoration: BoxDecoration(
              color: HSColor.neutral2,
              borderRadius: BorderRadius.circular(HsDimens.size64)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(HsDimens.radius24),
            child: ownerAvatar == null
                ? SvgPicture.asset(
                    Assets.images.userDefaultAvatar,
                    fit: BoxFit.cover,
                  )
                : Image.network(
                    ownerAvatar!,
                    fit: BoxFit.cover,
                  ),
          ),
        ),
        const SizedBox(
          width: HsDimens.spacing8,
        ),
        Text(ownerName,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                ))
      ],
    );
  }
}

// todo: update this class end startTime, endTime: double
// todo: after the demo session
class _TimeRentingView extends StatelessWidget {
  final String timeBooking;

  const _TimeRentingView({required this.timeBooking});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          Assets.icons.clock,
          fit: BoxFit.cover,
        ),
        const SizedBox(
          width: HsDimens.spacing4,
        ),
        Text(timeBooking),
      ],
    );
  }
}
