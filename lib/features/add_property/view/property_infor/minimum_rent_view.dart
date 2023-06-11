import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hatspace/data/property_data.dart';
import 'package:hatspace/features/add_property/view/property_infor/property_info_form.dart';
import 'package:hatspace/features/add_property/view_model/cubit/property_infor_cubit.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/route/router.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';
import 'package:hatspace/theme/widgets/hs_text_field.dart';

class MinimumRentView extends StatelessWidget {
  MinimumRentView({super.key});
  final ValueNotifier<MinimumRentPeriod> selectPeriod =
      ValueNotifier<MinimumRentPeriod>(MinimumRentPeriod.values.first);
  final List<MinimumRentPeriod> stateList = MinimumRentPeriod.values.toList();
  @override
  Widget build(BuildContext context) {
    String label = HatSpaceStrings.of(context).pleaseSelectRentPeriod;
    stateList.remove(MinimumRentPeriod.invalid);
    // TODO: implement build
    return BlocBuilder<PropertyInforCubit, PropertyInforState>(
        builder: (context, state) {
      if (state.saveRentPeriod != MinimumRentPeriod.invalid) {
        selectPeriod.value = state.saveRentPeriod;
      }
      if (state is SaveMinimumPeriodState) {
        label = state.saveRentPeriod.rentPeriodName;
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HatSpaceLabel(
              label: HatSpaceStrings.of(context).minimumRentPeriod,
              isRequired: true),
          HatSpaceDropDownButton(
              label: label,
              //TODO: implement state
              isRequired: true,
              onPressed: () {
                showModalBottomSheet(
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    context: context,
                    builder: (context) {
                      return SizedBox(
                        key: const Key("minimum_rent_bottom_sheet"),
                          height: MediaQuery.of(context).size.height * 0.85,
                          child: Padding(
                              padding: const EdgeInsets.only(bottom: 42),
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(
                                        bottom: 8, top: 24.0),
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: HSColor.neutral2))),
                                    child: Row(
                                      children: [
                                        const Expanded(
                                            child: SizedBox.shrink()),
                                        Expanded(
                                            child: Center(
                                          child: Text(
                                            HatSpaceStrings.of(context)
                                                .minimumRentPeriod,
                                            style: textTheme.displayLarge
                                                ?.copyWith(
                                                    fontSize: FontStyleGuide
                                                        .fontSize16),
                                          ),
                                        )),
                                        Expanded(
                                            child: Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: IconButton(
                                                  icon: SvgPicture.asset(
                                                      Assets.images.closeIcon),
                                                  onPressed: () {
                                                    context.pop();
                                                  },
                                                )))
                                      ],
                                    ),
                                  ),
                                  Flexible(
                                      child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 24.0,
                                    ),
                                    child: ListView.separated(
                                        separatorBuilder: (context, index) {
                                          return const Divider(
                                            thickness: 1.0,
                                            color: HSColor.neutral3,
                                          );
                                        },
                                        itemCount: stateList.length,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                              onTap: () {
                                                selectPeriod.value =
                                                    MinimumRentPeriod
                                                        .values[index];
                                              },
                                              child: ValueListenableBuilder(
                                                  valueListenable: selectPeriod,
                                                  builder:
                                                      (context, value, child) {
                                                    return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 16.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              stateList[index]
                                                                  .rentPeriodName,
                                                            ),
                                                            value ==
                                                                    MinimumRentPeriod
                                                                            .values[
                                                                        index]
                                                                ? SvgPicture
                                                                    .asset(Assets
                                                                        .images
                                                                        .check)
                                                                : const SizedBox
                                                                    .shrink()
                                                          ],
                                                        ));
                                                  }));
                                        }),
                                  )),
                                  Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 24.0),
                                      child: TertiaryButton(
                                        style: const ButtonStyle(
                                          foregroundColor:
                                              MaterialStatePropertyAll<Color>(
                                                  HSColor.background),
                                          backgroundColor:
                                              MaterialStatePropertyAll<Color>(
                                                  HSColor.green06),
                                        ),
                                        label: HatSpaceStrings.of(context).save,
                                        onPressed: () {
                                          context.pop();
                                        },
                                      ))
                                ],
                              )));
                    }).then((value) {
                  context
                      .read<PropertyInforCubit>()
                      .saveMinimumRentPeriod(selectPeriod.value);
                });
              })
        ],
      );
    });
  }
}
