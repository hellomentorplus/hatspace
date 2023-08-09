import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hatspace/dimens/hs_dimens.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/strings/l10n.dart';

import 'package:hatspace/theme/hs_theme.dart';

class PropertyDescriptionView extends StatelessWidget {
  final ValueNotifier<bool> _isExpanded = ValueNotifier(false);
  final String description;
  final int? maxLine;

  PropertyDescriptionView(
      {required this.description, required this.maxLine, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ValueListenableBuilder<bool>(
          valueListenable: _isExpanded,
          builder: (context, isExpanded, child) => Text(
            description,
            maxLines: isExpanded ? null : maxLine,
            overflow: isExpanded ? null : TextOverflow.ellipsis,
            textAlign: isExpanded ? TextAlign.justify : TextAlign.start,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: HSColor.neutral7),
          ),
        ),
        const SizedBox(
          height: HsDimens.spacing8,
        ),
        InkWell(
          onTap: () {
            _isExpanded.value = !_isExpanded.value;
          },
          child: Row(
            children: [
              ValueListenableBuilder<bool>(
                valueListenable: _isExpanded,
                builder: (context, isExpanded, child) => Text(
                  isExpanded
                      ? HatSpaceStrings.current.showLess
                      : HatSpaceStrings.current.showMore,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Theme.of(context).colorScheme.primary),
                ),
              ),
              SvgPicture.asset(
                Assets.icons.chervonDown,
                width: HsDimens.size20,
                height: HsDimens.size20,
                colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.primary, BlendMode.srcIn),
              )
            ],
          ),
        )
      ],
    );
  }
}
