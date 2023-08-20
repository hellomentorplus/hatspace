import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hatspace/dimens/hs_dimens.dart';
import 'package:hatspace/route/router.dart';
import 'package:hatspace/strings/l10n.dart';

import 'package:hatspace/theme/hs_theme.dart';

import 'package:hatspace/data/property_data.dart';

import 'package:hatspace/gen/assets.gen.dart';

class InspectionView extends StatelessWidget {
  const InspectionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: HsDimens.spacing16, vertical: HsDimens.spacing24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(HatSpaceStrings.current.inspectionBooking,
                  style: Theme.of(context).textTheme.displayLarge),
              const SizedBox(
                height: HsDimens.spacing20,
              ),
              Text(
                '3 inspect booking',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: FontStyleGuide.fontSize16,
                    fontWeight: FontWeight.w500),
              ),
              TenantBookItemView(
                propertyImage:
                    'https://img.staticmb.com/mbcontent/images/uploads/2022/12/Most-Beautiful-House-in-the-World.jpg',
                propertyName: 'Green living space in Melbourne',
                propertyType: PropertyTypes.apartment.displayName,
                price: 4800,
                currency: Currency.aud,
                timeRenting: 'pw',
                state: 'Victoria',
                timeBooking: '09:00 AM - 10:00 AM - 15 Sep, 2023',
                ownerName: 'Yolo Tim',
                ownerAvatar: null,
                onPressed: () => context.goToInspectionDetail(id: '1'),
              ),
              TenantBookItemView(
                propertyImage:
                    'https://exej2saedb8.exactdn.com/wp-content/uploads/2022/02/Screen-Shot-2022-02-04-at-2.28.40-PM.png?strip=all&lossy=1&ssl=1',
                propertyName: 'Black and white apartment in Sydney',
                propertyType: PropertyTypes.apartment.displayName,
                price: 8500,
                currency: Currency.aud,
                timeRenting: 'pw',
                state: 'New South Wales',
                timeBooking: '14:00 PM - 15:00 PM - 16 Sep, 2023',
                ownerName: 'Cyber James',
                ownerAvatar: null,
                onPressed: () => context.goToInspectionDetail(id: '2'),
              ),
              TenantBookItemView(
                propertyImage:
                    'https://cdn-bnokp.nitrocdn.com/QNoeDwCprhACHQcnEmHgXDhDpbEOlRHH/assets/images/optimized/rev-a642abc/www.decorilla.com/online-decorating/wp-content/uploads/2020/08/Modern-Apartment-Decor-.jpg',
                propertyName: 'Fully-furnished house in Rouse Hill',
                propertyType: PropertyTypes.house.displayName,
                price: 1000,
                currency: Currency.aud,
                timeRenting: 'pw',
                state: 'Victoria',
                timeBooking: '18:00 PM - 19:00 PM - 18 Sep, 2023',
                ownerName: 'Maggie Bean',
                ownerAvatar: null,
                onPressed: () => context.goToInspectionDetail(id: '3'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TenantBookItemView extends StatelessWidget {
  final String propertyImage;
  final String propertyName;
  final String propertyType;
  final double price;
  final Currency currency;
  final String timeRenting;
  final String state;
  final String timeBooking; // todo: need to update after demo
  final String? ownerName;
  final String? ownerAvatar;
  final VoidCallback onPressed;

  const TenantBookItemView({
    required this.propertyImage,
    required this.propertyName,
    required this.propertyType,
    required this.price,
    required this.currency,
    required this.timeRenting,
    required this.state,
    required this.timeBooking,
    required this.onPressed,
    this.ownerName,
    this.ownerAvatar,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: HsDimens.spacing12),
      child: Card(
        elevation: 5, // Controls the shadow depth
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(HsDimens.radius10),
        ),
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          onTap: onPressed,
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
                        padding:
                            const EdgeInsets.only(left: HsDimens.spacing16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              propertyType,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
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
                            Text(state,
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
                  padding:
                      const EdgeInsets.symmetric(vertical: HsDimens.spacing12),
                  child: SvgPicture.asset(
                    Assets.images.dashedDivider,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                _TimeRentingView(timeBooking: timeBooking)
              ],
            ),
          ),
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
