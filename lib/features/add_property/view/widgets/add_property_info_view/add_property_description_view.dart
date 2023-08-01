import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatspace/features/add_property/view_model/add_property_cubit.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:hatspace/theme/widgets/hs_text_field.dart';

class AddPropertyDescriptionView extends StatelessWidget {
  final ValueNotifier<int> _textCount = ValueNotifier(0);

  final int _maxTextCount = 4000;

  AddPropertyDescriptionView({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            HsLabel(
                label: HatSpaceStrings.current.description, isRequired: false),
            ValueListenableBuilder<int>(
              valueListenable: _textCount,
                builder: (context, value, child) => Text('$value/$_maxTextCount'))
          ],
        ),
        const SizedBox(
          height: 4,
        ),
        TextFormField(
          style: textTheme.bodyMedium,
          minLines: 3,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          maxLength: _maxTextCount,
          decoration: inputTextTheme.copyWith(
            hintText: HatSpaceStrings.current.enterYourDescription,
            counterText: '',
            semanticCounterText: '',
          ),
          onChanged: (value) {
            _textCount.value = value.length;
            context.read<AddPropertyCubit>().description = value;
          },
        )
      ],
    );
  }
}
