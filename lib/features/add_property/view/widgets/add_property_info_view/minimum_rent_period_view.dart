import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatspace/data/property_data.dart';
import 'package:hatspace/features/add_property/view_model/add_property_cubit.dart';
import 'package:hatspace/features/add_property/view_model/add_property_state.dart';
import 'package:hatspace/route/router.dart';
import 'package:hatspace/theme/widgets/hs_modal_selection_view.dart';

class MinimumRentPeriodView extends StatelessWidget {
  MinimumRentPeriodView({super.key});
  final ValueNotifier<MinimumRentPeriod> initial =
      ValueNotifier<MinimumRentPeriod>(MinimumRentPeriod.invalid);
  final List<MinimumRentPeriod> periodList = MinimumRentPeriod.values.toList();
  @override
  Widget build(BuildContext context) {
    periodList.remove(MinimumRentPeriod.invalid);
    return BlocListener<AddPropertyCubit, AddPropertyState>(
        listener: (context, state) {
          if (state is OnSaveRentPeriod) {
            context.pop();
          }
        },
        child: HsModalSelectionView<MinimumRentPeriod>(
            itemList: periodList,
            dislayName: (item) => item.displayName,
            initialValue: initial,
            onValueChanges: (value) =>
                context.read<AddPropertyCubit>().saveRentPeriod(value)));
  }
}
