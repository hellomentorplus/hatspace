import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatspace/features/add_property/view_model/add_property_cubit.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/widgets/hs_text_field.dart';

class AddPropertyUnitView extends StatefulWidget {
  const AddPropertyUnitView({super.key});

  @override
  State<AddPropertyUnitView> createState() => _AddPropertyUnitViewState();
}

class _AddPropertyUnitViewState extends State<AddPropertyUnitView>
    with AutomaticKeepAliveClientMixin<AddPropertyUnitView> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      HatSpaceInputText(
        label: HatSpaceStrings.of(context).unitNumber,
        optional: HatSpaceStrings.of(context).optional,
        placeholder: HatSpaceStrings.of(context).enterYourUnitnumber,
        onChanged: (value) {
          context.read<AddPropertyCubit>().unitNumber = value;
        },
      )
    ]);
  }

  @override
  bool get wantKeepAlive => true;
}
