import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hatspace/data/property_data.dart';
import 'package:hatspace/features/add_property/view/property_infor/property_info_form.dart';
import 'package:hatspace/features/add_property/view_model/cubit/property_infor_cubit.dart';
import 'package:hatspace/features/add_property/view_model/cubit/property_type_cubit.dart';
import 'package:hatspace/features/add_property/view_model/cubit/select_state_cubit.dart';
import 'package:hatspace/features/add_property/view_model/cubit/select_state_state.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/route/router.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';

class StateSelectionView extends StatelessWidget {
  const StateSelectionView({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<PropertyInforCubit, PropertyInforState>(
        builder: (context, state) {
      if (state is SaveSelectedState) {
        print("abc");
      }
      print("render $state");
      return HatSpaceDropDownButton(
          label: state.selectedState == AustraliaStates.invalid
              ? "Please select your state"
              : state.selectedState.stateName,
          //TODO: implement state
          isRequired: true,
          onPressed: () {
            showModalBottomSheet(
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                context: context,
                builder: (BuildContext context) {
                  return MultiBlocProvider(providers: [
                    BlocProvider(create: (context) => PropertyInforCubit()),
                    BlocProvider(create: (context) => SelectStateCubit())
                  ], child: StateBottomModalView());
                });
          });
    });
  }
}

class StateBottomModalView extends StatelessWidget {
  final List<AustraliaStates> stateList = AustraliaStates.values.toList();
  StateBottomModalView({super.key});
  @override
  Widget build(BuildContext context) {
    stateList.remove(AustraliaStates.invalid);
    return BlocBuilder<PropertyInforCubit,PropertyInforState>(
      builder: (context,state){
        return SizedBox(
        height: MediaQuery.of(context).size.height * 0.85,
        child: Padding(
            padding: const EdgeInsets.only(bottom: 42),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 8, top: 24.0),
                  decoration: const BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: HSColor.neutral2))),
                  child: Row(
                    children: [
                      const Expanded(child: Text("")),
                      const Expanded(
                          child: Center(
                        child: Text("Space"),
                      )),
                      Expanded(
                          child: Align(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                icon: SvgPicture.asset(Assets.images.closeIcon),
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
                      return BlocSelector<SelectStateCubit, SelectStateState,
                              AustraliaStates>(
                          selector: (state) => state.australiaState,
                          builder: (context, state) {
                            return GestureDetector(
                                onTap: () {
                                  context
                                      .read<SelectStateCubit>()
                                      .SelectAustraliaState(
                                          AustraliaStates.values[index]);
                                },
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          stateList[index].stateName,
                                        ),
                                        state.stateName ==
                                                stateList[index].stateName
                                            ? SvgPicture.asset(
                                                Assets.images.check)
                                            : const Text("")
                                      ],
                                    )));
                          });
                    },
                  ),
                )),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child:TertiaryButton(
                        style: const ButtonStyle(
                          foregroundColor: MaterialStatePropertyAll<Color>(
                              HSColor.background),
                          backgroundColor:
                              MaterialStatePropertyAll<Color>(HSColor.green06),
                        ),
                        label: "Save",
                        onPressed: () {
                          context
                              .read<PropertyInforCubit>()
                              .saveSelectedState(state.selectedState);
                           context.pop();
                        },
                      )
                    )
              ],
            )));
      }
    
    );
  }
}
