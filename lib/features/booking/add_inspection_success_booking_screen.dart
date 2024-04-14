import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hatspace/data/property_data.dart';
import 'package:hatspace/dimens/hs_dimens.dart';
import 'package:hatspace/features/booking/add_inspection_booking_screen.dart';
import 'package:hatspace/features/inspection/viewmodel/inspection_cubit.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/route/router.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:intl/intl.dart';

class AddInspectionSuccessScreen extends StatelessWidget {
  final String inspectionId;

  const AddInspectionSuccessScreen(this.inspectionId, {super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InspectionCubit()..getInspection(inspectionId),
      child: AddInspectionSuccessBody(inspecitonId: inspectionId),
    );
  }
}

class AddInspectionSuccessBody extends StatelessWidget {
  final String inspecitonId;
  const AddInspectionSuccessBody({required this.inspecitonId, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InspectionCubit, InspectionState>(
        builder: (context, state) {
      if (state is InspectionItem) {
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
                        context.goToPropertyDetail(
                            id: state.property.id!, replacement: true);
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
                padding:
                    const EdgeInsets.symmetric(horizontal: HsDimens.spacing16),
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
                      propertyName: state.property.name,
                      propertyType: state.property.type
                          .displayName, //HatSpaceStrings.current.apartment,
                      propertyImage:
                          // Previous link can not access, update in case QA assign this as a bug.
                          // TODO: Remove soon when implemnet data structure for inspection
                          state.property.photos[0],
                      price: state.property.price.rentPrice,
                      state: state.property.address.state.displayName,
                      currency: Currency.aud,
                      paymentPeriod: HatSpaceStrings.current.pm,
                      onPressed: () {
                        // TODO: implement BL
                      },
                    ),
                    const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: HsDimens.spacing20),
                        child: Divider(
                          color: HSColor.neutral2,
                        )),
                    //Avatar
                    Row(
                      children: [
                        ClipOval(
                          // TODO what to show when avatar is null?
                          child: CachedNetworkImage(
                            imageUrl: state.userDetail.avatar!,
                            width: HsDimens.size32,
                            height: HsDimens.size32,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: HsDimens.spacing8),
                        Text(
                          state.userDetail.displayName!,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  color: HSColor.neutral9,
                                  fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                    const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: HsDimens.spacing20),
                        child: Divider(
                          color: HSColor.neutral2,
                        )),
                    // Schedules
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _BookingSchedule(
                            label: HatSpaceStrings.current.start,
                            timeString: DateFormat('hh:mm a')
                                .format(state.inspection.startTime)),
                        _BookingSchedule(
                            label: HatSpaceStrings.current.end,
                            timeString: DateFormat('hh:mm a')
                                .format(state.inspection.endTime)),
                        _BookingSchedule(
                          label: HatSpaceStrings.current.date,
                          timeString: DateFormat('d MMM, yyyy ')
                              .format(state.inspection.startTime),
                          alignment: CrossAxisAlignment.end,
                        )
                      ],
                    ),
                    const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: HsDimens.spacing20),
                        child: Divider(
                          color: HSColor.neutral2,
                        )),
                    Text(HatSpaceStrings.current.notes,
                        style: textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w400,
                            color: HSColor.neutral5)),
                    const SizedBox(height: HsDimens.spacing4),
                    Text(state.inspection.message ?? '')
                  ],
                ),
              ),
            )));
      }
      return const SizedBox();
    });
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
