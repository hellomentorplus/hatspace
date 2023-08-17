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
  final FocusNode _focusNode = FocusNode();
  final ValueNotifier<bool> _isEmpty = ValueNotifier(false);

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        _isEmpty.value = context.read<AddPropertyCubit>().address.isEmpty;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ValueListenableBuilder<bool>(
          valueListenable: _isEmpty,
          builder: (context, isEmpty, child) => HatSpaceInputText(
            focusNode: _focusNode,
            label: HatSpaceStrings.current.streetAddress,
            isRequired: true,
            placeholder: HatSpaceStrings.current.enterStreetAddress,
            onChanged: (value) {
              _isEmpty.value = value.isEmpty;
              context.read<AddPropertyCubit>().address = value;
            },
            errorText:
                isEmpty ? HatSpaceStrings.current.enterStreetAddress : null,
          ),
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
