import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hatspace/dimens/hs_dimens.dart';
import 'package:hatspace/route/router.dart';
import 'package:hatspace/features/inspection/viewmodel/display_item.dart';
import 'package:hatspace/features/inspection/viewmodel/inspection_cubit.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:hatspace/data/property_data.dart';
import 'package:hatspace/gen/assets.gen.dart';

class InspectionView extends StatelessWidget {
  const InspectionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocProvider<InspectionCubit>(
      create: (context) => InspectionCubit()..getUserRole(),
      child: const InspectionBody());
}

class InspectionBody extends StatelessWidget {
  const InspectionBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => SafeArea(
        child: BlocBuilder<InspectionCubit, InspectionState>(
          builder: (_, state) {
            if (state is InspectionLoaded) {
              return ListView.separated(
                  padding: const EdgeInsets.symmetric(
                      horizontal: HsDimens.spacing16,
                      vertical: HsDimens.spacing24),
                  itemCount: state.items.length,
                  separatorBuilder: (_, idx) {
                    if (idx == 0) {
                      return const SizedBox(
                        height: HsDimens.spacing20,
                      );
                    }
                    return const SizedBox(
                      height: HsDimens.spacing12,
                    );
                  },
                  itemBuilder: (BuildContext context, int index) {
                    final item = state.items[index];

                    if (item is Header) {
                      return Text(HatSpaceStrings.current.inspectionBooking,
                          style: Theme.of(context).textTheme.displayLarge);
                    } else if (item is NumberOfInspectionItem) {
                      return Text(
                        HatSpaceStrings.current
                            .numberOfInspectionBooking(item.number),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: FontStyleGuide.fontSize16,
                            fontWeight: FontWeight.w500),
                      );
                    } else if (item is TenantBookingItem) {
                      return InkWell(
                        onTap: () => {
                          context.goToInspectionDetail(id: item.id),
                        },
                        child: TenantBookItemView(
                          propertyName: item.propertyName,
                          propertyImage: item.propertyImage,
                          propertyType: item.propertyType,
                          price: item.price,
                          currency: item.currency,
                          timeRenting: item.timeRenting,
                          state: item.state,
                          timeBooking: item.timeBooking,
                          ownerName: item.ownerName,
                          ownerAvatar: item.ownerAvatar,
                        ),
                      );
                    } else if (item is HomeOwnerBookingItem) {
                      return InkWell(
                        onTap: () => {
                          context.goToInspectionConfirmationListDetail(
                              id: item.id),
                        },
                        child: HomeOwnerBookItemView(
                          propertyName: item.propertyName,
                          propertyImage: item.propertyImage,
                          propertyType: item.propertyType,
                          price: item.price,
                          currency: item.currency,
                          timeRenting: item.timeRenting,
                          state: item.state,
                          numberOfBookings: item.numberOfBookings,
                        ),
                      );
                    }

                    return const SizedBox.shrink();
                  });
            }
            return const SizedBox();
          },
        ),
      );
}

class TenantBookItemView extends StatelessWidget {
  final String propertyImage;
  final String propertyName;
  final PropertyTypes propertyType;
  final double price;
  final Currency currency;
  final String timeRenting;
  final String state;
  final String timeBooking; // todo: need to update after demo
  final String? ownerName;
  final String? ownerAvatar;

  const TenantBookItemView({
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
    Key? key,
  }) : super(key: key);

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

class HomeOwnerBookItemView extends StatelessWidget {
  final String propertyImage;
  final String propertyName;
  final PropertyTypes propertyType;
  final double price;
  final String timeRenting;
  final Currency currency;
  final String state;
  final int numberOfBookings; // todo: need to update after demo

  const HomeOwnerBookItemView({
    required this.propertyImage,
    required this.propertyName,
    required this.propertyType,
    required this.price,
    required this.timeRenting,
    required this.currency,
    required this.state,
    required this.numberOfBookings,
    Key? key,
  }) : super(key: key);

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
            _NumberOfInspectionView(number: numberOfBookings)
          ],
        ),
      ),
    );
  }
}

class _NumberOfInspectionView extends StatelessWidget {
  final int number;

  const _NumberOfInspectionView({required this.number});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          Assets.icons.numberBooking,
          fit: BoxFit.cover,
        ),
        const SizedBox(
          width: HsDimens.spacing4,
        ),
        Text(HatSpaceStrings.current.numberOfBooking(number)),
      ],
    );
  }
}
