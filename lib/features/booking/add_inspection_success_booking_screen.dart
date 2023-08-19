import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hatspace/data/property_data.dart';
import 'package:hatspace/dimens/hs_dimens.dart';
import 'package:hatspace/features/booking/add_inspection_booking_screen.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/route/router.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/hs_theme.dart';

class AddInspectionSuccessScreen extends StatelessWidget {
  const AddInspectionSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: null,
          automaticallyImplyLeading: false,
          backgroundColor: HSColor.background,
          shadowColor: Colors.transparent,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: HsDimens.spacing16),
              child: IconButton(
                  onPressed: () {
                    context.pop();
                  },
                  icon: SvgPicture.asset(
                    Assets.icons.close,
                    width: HsDimens.size32,
                    height: HsDimens.size32,
                  )),
            )
          ],
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: HsDimens.spacing16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(Assets.icons.primaryCheck),
                const SizedBox(height: HsDimens.spacing16),
                //Body
                Text(
                  HatSpaceStrings.current.congratulations,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                const SizedBox(height: HsDimens.spacing8),
                Text(HatSpaceStrings.current.bookingSuccessMessage,
                    style: textTheme.bodyMedium?.copyWith(
                        height: 22.0 /
                            FontStyleGuide
                                .fontSize14 // Convert figma line heigh to flutter line height
                        )),
                const SizedBox(height: HsDimens.spacing24),
                BookedItemCard(
                  padding: const EdgeInsets.all(0),
                  shadowColor: Colors.transparent,
                  propertyName: 'Green living space in Melbourne',
                  propertyType: HatSpaceStrings.current.apartment,
                  propertyImage:
                      'https://cdn-bnokp.nitrocdn.com/QNoeDwCprhACHQcnEmHgXDhDpbEOlRHH/assets/images/optimized/rev-a642abc/www.decorilla.com/online-decorating/wp-content/uploads/2020/08/Modern-Apartment-Decor-.jpg',
                  price: 4800,
                  state: 'Vitoria',
                  currency: Currency.aud,
                  rentingPeriod: 'pw',
                  onPressed: () {
                    // TODO: implement BL
                  },
                ),
                const Padding(
                    padding: EdgeInsets.symmetric(vertical: HsDimens.spacing20),
                    child: Divider(
                      color: HSColor.neutral2,
                    )),
                //Avatar
                Row(
                  children: [
                    ClipOval(
                      // TODO what to show when avatar is null?
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://as2.ftcdn.net/v2/jpg/05/49/98/39/1000_F_549983970_bRCkYfk0P6PP5fKbMhZMIb07mCJ6esXL.jpg',
                        width: HsDimens.size32,
                        height: HsDimens.size32,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: HsDimens.spacing8),
                    Text(
                      'Yolo Tim',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: HSColor.neutral9, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
                const Padding(
                    padding: EdgeInsets.symmetric(vertical: HsDimens.spacing20),
                    child: Divider(
                      color: HSColor.neutral2,
                    )),
                // Schedules
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _BookingSchedule(
                        label: HatSpaceStrings.current.start,
                        timeString: '09:00 AM'),
                    _BookingSchedule(
                        label: HatSpaceStrings.current.end,
                        timeString: '10:00 AM'),
                    _BookingSchedule(
                      label: HatSpaceStrings.current.date,
                      timeString: '14 Mar, 2023',
                      alignment: CrossAxisAlignment.end,
                    )
                  ],
                ),
                const Padding(
                    padding: EdgeInsets.symmetric(vertical: HsDimens.spacing20),
                    child: Divider(
                      color: HSColor.neutral2,
                    )),
                Text(HatSpaceStrings.current.notes,
                    style: textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w400, color: HSColor.neutral5)),
                const SizedBox(height: HsDimens.spacing4),
                const Text(
                  'My number is 0438825121',
                )
              ],
            ),
          ),
        )));
  }
}

class _BookingSchedule extends StatelessWidget {
  final String label;
  final String timeString;
  final CrossAxisAlignment alignment;
  const _BookingSchedule(
      {required this.label,
      required this.timeString,
      CrossAxisAlignment? alignment})
      : alignment = alignment ?? CrossAxisAlignment.start;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: alignment,
      children: [
        Text(
          label,
          textAlign: TextAlign.left,
          style: textTheme.bodySmall
              ?.copyWith(fontWeight: FontWeight.w400, color: HSColor.neutral5),
        ),
        const SizedBox(height: HsDimens.spacing4),
        Text(
          timeString,
          style: textTheme.bodySmall?.copyWith(
              decorationColor: HSColor.neutral9, fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}
