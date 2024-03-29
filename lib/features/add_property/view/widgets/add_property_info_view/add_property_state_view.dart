import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatspace/data/property_data.dart';
import 'package:hatspace/features/add_property/view_model/add_property_cubit.dart';
import 'package:hatspace/route/router.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/widgets/hs_modal_selection_view.dart';

class AddPropertyStateView extends StatelessWidget {
  AddPropertyStateView({super.key});
  final ValueNotifier<AustraliaStates> initial =
      ValueNotifier<AustraliaStates>(AustraliaStates.invalid);
  final List<AustraliaStates> stateList = AustraliaStates.values.toList();
  @override
  Widget build(BuildContext context) {
    stateList.remove(AustraliaStates.invalid);
    return HsModalSelectionView<AustraliaStates>(
        label: HatSpaceStrings.current.state,
        isRequired: true,
        itemList: stateList,
        dislayName: (item) => item.displayName,
        selection: initial,
        onValueChanges: (value) {
          context.read<AddPropertyCubit>().australiaState = value;
          context.pop();
        });
  }
}
