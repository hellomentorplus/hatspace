import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatspace/features/add_property/view_model/add_property_cubit.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:hatspace/theme/widgets/hs_text_field.dart';

class AddPropertyAddressView extends StatefulWidget {
  const AddPropertyAddressView({super.key});

  @override
  State<AddPropertyAddressView> createState() => _AddPropertyAddressViewState();
}

class _AddPropertyAddressViewState extends State<AddPropertyAddressView>
    with AutomaticKeepAliveClientMixin<AddPropertyAddressView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HatSpaceInputText(
          label: HatSpaceStrings.current.streetAddress,
          isRequired: true,
          placeholder: HatSpaceStrings.current.enterYourAddress,
          onChanged: (value) {
            context.read<AddPropertyCubit>().address = value;
          },
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          HatSpaceStrings.current.houseNumberAndStreetName,
          style: textTheme.bodySmall?.copyWith(color: HSColor.neutral6),
        )
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
