import 'package:flutter/material.dart';

import 'package:hatspace/theme/hs_theme.dart';

class PropertyDescriptionView extends StatelessWidget {
  final String description;
  final int? maxLine;
  const PropertyDescriptionView(
      {required this.description, required this.maxLine, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      description,
      maxLines: maxLine,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context)
          .textTheme
          .bodyMedium
          ?.copyWith(color: HSColor.neutral7),
    );
  }
}