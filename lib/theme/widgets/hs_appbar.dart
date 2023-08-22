import 'package:flutter/material.dart';
import 'package:hatspace/dimens/hs_dimens.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';

class HsAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final double height;
  const HsAppBar(
      {required this.title,
      this.actions,
      super.key,
      this.height = kToolbarHeight});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(title,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(fontWeight: FontStyleGuide.fwBold)),
      backgroundColor: HSColor.neutral1,
      leading: const HsBackButton(),
      elevation: 0,
      bottom: PreferredSize(
          preferredSize: const Size.fromHeight(HsDimens.size1),
          child: Container(
            color: HSColor.neutral2,
            height: HsDimens.size1,
          )),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
