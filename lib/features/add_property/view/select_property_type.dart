import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hatspace/features/add_property/view/property_type_cart_view.dart';
import 'package:hatspace/features/add_property/view_model/bloc/add_property_bloc.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:hatspace/theme/widgets/hs_date_picker.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class SelectPropertyTypeBody extends StatelessWidget {
  const SelectPropertyTypeBody({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    String currentDate = DateFormat("dd MMMM, yyyy").format(DateTime.now());
    return BlocConsumer<AddPropertyBloc, AddPropertyState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 33, 16, 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(HatSpaceStrings.of(context).selectingRoleScreenTitle,
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium
                              ?.copyWith(
                                  fontSize: 24,
                                  color: HSColor.onSurface,
                                  fontWeight: FontWeight.w700)),
                      Container(height: 16),
                      Text(
                          HatSpaceStrings.of(context)
                              .selectigRoleScreenSubtitle,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                  fontWeight: FontWeight.w400, fontSize: 14)),
                      GridView.builder(
                          padding: const EdgeInsets.only(top: 32),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 15,
                          ),
                          shrinkWrap: true,
                          itemCount: 2,
                          itemBuilder: (BuildContext context, int position) {
                            return PropertyTypeCartView(
                              position: position,
                            );
                          }),
                      Container(height: 20),
                      Text(
                        HatSpaceStrings.of(context).availableDate,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: HSColor.onSurface),
                      ),
                      Container(height: 4),
                      OutlinedButton(
                          onPressed: () async {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                    alignment: Alignment.bottomCenter,
                                    insetPadding: const EdgeInsets.only(
                                        bottom: 24, left: 16, right: 16),
                                    // backgroundColor: Colors.orangeAccent,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(16))),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        mainAxisSize: MainAxisSize.min,
                                        children: const [
                                          HsDatePicker()
                                        ]),
                                  );
                                });
                          },
                          style: ButtonStyle(
                              textStyle: MaterialStatePropertyAll(
                                  textTheme.bodySmall?.copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14)),
                              alignment: Alignment.center,
                              padding:
                                  MaterialStateProperty.all<EdgeInsetsGeometry>(
                                      const EdgeInsets.symmetric(
                                          vertical: 12, horizontal: 16)),
                              shape: MaterialStatePropertyAll<OutlinedBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8))),
                              side: const MaterialStatePropertyAll<BorderSide>(
                                  BorderSide(color: HSColor.neutral3)),
                              backgroundColor:
                                  const MaterialStatePropertyAll<Color>(Colors.transparent),
                              foregroundColor: const MaterialStatePropertyAll<Color>(HSColor.neutral6)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: Text(currentDate.isEmpty
                                    ? "Unvailable"
                                    : currentDate),
                              ),
                              SvgPicture.asset(
                                Assets.images.calendar,
                                width: 24,
                                height: 24,
                              )
                            ],
                          )),
                    ],
                  ),
                ),
              ]);
        });
  }
}
