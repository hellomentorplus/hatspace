import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatspace/data/property_data.dart';
import 'package:hatspace/features/add_property/view_model/add_property_cubit.dart';
import 'package:hatspace/route/router.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/widgets/hs_modal_selection_view.dart';

class AddPropertyMinimumRentView extends StatelessWidget {
  AddPropertyMinimumRentView({super.key});
  final ValueNotifier<MinimumRentPeriod> initial =
      ValueNotifier<MinimumRentPeriod>(MinimumRentPeriod.invalid);
  final List<MinimumRentPeriod> periodList = MinimumRentPeriod.values.toList();
  @override
  Widget build(BuildContext context) {
    periodList.remove(MinimumRentPeriod.invalid);
    return HsModalSelectionView<MinimumRentPeriod>(
        label: HatSpaceStrings.current.minimumRentPeriod,
        isRequired: true,
        itemList: periodList,
        dislayName: (item) => item.displayName,
        selection: initial,
        onValueChanges: (value) {
          context.read<AddPropertyCubit>().saveRentPeriod(value);
          context.pop();
        });
  }
}
