import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hatspace/dimens/hs_dimens.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/hs_button_theme.dart';
import 'package:hatspace/theme/hs_theme.dart';

import 'package:hatspace/theme/widgets/hs_buttons_settings.dart';

class ButtonWithIconContent extends StatelessWidget {
  final IconPosition? iconPosition;
  final String label;
  final String iconUrl;
  final MainAxisAlignment contentAlignment;
  final bool overrideIconColor;

  const ButtonWithIconContent({
    required this.label,
    required this.iconUrl,
    required this.contentAlignment,
    this.overrideIconColor = true,
    super.key,
    this.iconPosition,
  });

  @override
  Widget build(BuildContext context) {
    final List<Widget> buttonContent = [
      SvgPicture.asset(
        iconUrl,
        width: 24,
        height: 24,
        colorFilter: overrideIconColor
            ? ColorFilter.mode(
                DefaultTextStyle.of(context).style.color ?? HSColor.primary,
                BlendMode.srcIn)
            : null,
        alignment: Alignment.center,
      ),
      Padding(
        padding: iconPosition == IconPosition.left
            ? const EdgeInsets.only(left: 8)
            : const EdgeInsets.only(right: 8),
        child: Text(
          label,
          textAlign: TextAlign.center,
        ),
      ),
    ];
    return Row(
      mainAxisAlignment: contentAlignment,
      mainAxisSize: MainAxisSize.max,
      children: iconPosition == IconPosition.left
          ? buttonContent
          : buttonContent.reversed.toList(),
    );
  }
}

class PrimaryButton extends StatelessWidget {
  final String label;
  final String? iconUrl;
  final VoidCallback? onPressed;
  final IconPosition? iconPosition;
  final ButtonStyle? style;
  final MainAxisAlignment contentAlignment;
  final bool overrideIconColor;

  const PrimaryButton({
    required this.label,
    Key? key,
    this.iconUrl,
    this.onPressed,
    this.iconPosition = IconPosition.left,
    this.style,
    this.contentAlignment = MainAxisAlignment.center,
    this.overrideIconColor = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // FOR TEXT ONLY BUTTON
    if (iconUrl == null) {
      return ElevatedButton(
        key: key,
        onPressed: onPressed,
        style: style,
        child: Row(
          mainAxisAlignment: contentAlignment,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(label),
          ],
        ),
      );
    }

    return ElevatedButton(
      key: key,
      onPressed: onPressed,
      style: style,
      child: ButtonWithIconContent(
        contentAlignment: contentAlignment,
        iconPosition: iconPosition,
        iconUrl: iconUrl!,
        label: label,
        overrideIconColor: overrideIconColor,
      ),
    );
  }
}

class SecondaryButton extends StatelessWidget {
  final String label;
  final String? iconUrl;
  final IconPosition? iconPosition;
  final ButtonStyle? style;
  final VoidCallback? onPressed;
  final MainAxisAlignment contentAlignment;
  final bool overrideIconColor;

  const SecondaryButton({
    required this.label,
    Key? key,
    this.iconUrl,
    this.onPressed,
    this.iconPosition = IconPosition.left,
    this.style,
    this.contentAlignment = MainAxisAlignment.center,
    this.overrideIconColor = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // WITH TEXT ONLY
    if (iconUrl == null) {
      return OutlinedButton(
        onPressed: onPressed,
        style: style,
        child: Row(
          mainAxisAlignment: contentAlignment,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(label),
          ],
        ),
      );
    }

    return OutlinedButton(
      onPressed: onPressed,
      style: style,
      child: ButtonWithIconContent(
        contentAlignment: contentAlignment,
        iconPosition: iconPosition,
        iconUrl: iconUrl!,
        label: label,
        overrideIconColor: overrideIconColor,
      ),
    );
  }
}

class TextOnlyButton extends StatelessWidget {
  final String label;
  final String? iconUrl;
  final VoidCallback? onPressed;
  final IconPosition? iconPosition;
  final ButtonStyle? style;
  final MainAxisAlignment contentAlignment;

  const TextOnlyButton({
    required this.label,
    Key? key,
    this.onPressed,
    this.iconUrl,
    this.iconPosition = IconPosition.left,
    this.contentAlignment = MainAxisAlignment.center,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (iconUrl == null) {
      return TextButton(
        key: key,
        onPressed: onPressed,
        style: style,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(label),
          ],
        ),
      );
    }

    return TextButton(
        key: key,
        onPressed: onPressed,
        style: style,
        child: ButtonWithIconContent(
          contentAlignment: contentAlignment,
          iconPosition: iconPosition,
          iconUrl: iconUrl!,
          label: label,
        ));
  }
}

class TertiaryButton extends StatelessWidget {
  final String label;
  final String? iconUrl;
  final VoidCallback? onPressed;
  final IconPosition? iconPosition;
  final ButtonStyle? style;
  final MainAxisAlignment contentAlignment;
  final bool overrideIconColor;

  const TertiaryButton({
    required this.label,
    Key? key,
    this.onPressed,
    this.iconUrl,
    this.iconPosition = IconPosition.left,
    this.contentAlignment = MainAxisAlignment.center,
    this.style,
    this.overrideIconColor = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (iconUrl == null) {
      return OutlinedButton(
        key: key,
        onPressed: onPressed,
        style: style ?? tertiaryButtonTheme.style,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(label),
          ],
        ),
      );
    }

    return OutlinedButton(
        key: key,
        onPressed: onPressed,
        style: style ?? tertiaryButtonTheme.style,
        child: ButtonWithIconContent(
          contentAlignment: contentAlignment,
          iconPosition: iconPosition,
          iconUrl: iconUrl!,
          label: label,
          overrideIconColor: overrideIconColor,
        ));
  }
}

class RoundButton extends StatelessWidget {
  final String iconUrl;
  final VoidCallback? onPressed;
  final Color? textColor;
  const RoundButton(
      {required this.iconUrl,
      required this.onPressed,
      Key? key,
      this.textColor})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: roundButtonTheme.style,
      child: SvgPicture.asset(
        iconUrl,
        width: 24,
        height: 24,
        colorFilter: ColorFilter.mode(
            DefaultTextStyle.of(context).style.color ?? HSColor.neutral9,
            BlendMode.srcIn),
      ),
    );
  }
}

class HatSpaceDropDownButton extends StatelessWidget {
  final String? value;
  final VoidCallback onPressed;
  final String? icon;
  const HatSpaceDropDownButton(
      {required this.onPressed,
      super.key,
      bool? isRequired,
      this.icon,
      this.value});
  @override
  Widget build(BuildContext context) {
    return SecondaryButton(
      // TODO: implement placeholder with enum of preriod
      label: value ?? HatSpaceStrings.current.pleaseSelectValue,
      iconUrl: icon,
      iconPosition: IconPosition.right,
      contentAlignment: MainAxisAlignment.spaceBetween,
      style: secondaryButtonTheme.style?.copyWith(
          textStyle: MaterialStatePropertyAll<TextStyle?>(
            Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.5),
          ),
          padding: const MaterialStatePropertyAll<EdgeInsets>(
              EdgeInsets.fromLTRB(HsDimens.spacing16, HsDimens.spacing12,
                  HsDimens.spacing12, HsDimens.spacing12))),
      onPressed: () {
        // TODO: implement show rent period
      },
    );
  }
}
