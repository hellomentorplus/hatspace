import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hatspace/dimens/hs_dimens.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/route/router.dart';
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
  final TextStyle? labelStyle;

  const ButtonWithIconContent(
      {required this.label,
      required this.iconUrl,
      required this.contentAlignment,
      this.overrideIconColor = true,
      super.key,
      this.iconPosition,
      this.labelStyle});

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
          style: labelStyle,
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
  final TextStyle? labelStyle;
  final FocusNode? focusNode;
  final ValueChanged? onFocusChange;

  const SecondaryButton(
      {required this.label,
      Key? key,
      this.iconUrl,
      this.onPressed,
      this.iconPosition = IconPosition.left,
      this.style,
      this.contentAlignment = MainAxisAlignment.center,
      this.overrideIconColor = true,
      this.labelStyle,
      this.focusNode,
      this.onFocusChange})
      : super(key: key);

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
          children: [Text(label)],
        ),
      );
    }

    return OutlinedButton(
      focusNode: focusNode,
      onFocusChange: onFocusChange,
      onPressed: onPressed,
      style: style,
      child: ButtonWithIconContent(
        contentAlignment: contentAlignment,
        iconPosition: iconPosition,
        iconUrl: iconUrl!,
        label: label,
        labelStyle: labelStyle,
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
  final ButtonStyle? style;
  final Color? textColor;
  const RoundButton(
      {required this.iconUrl,
      required this.onPressed,
      this.style,
      Key? key,
      this.textColor})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: style ?? roundButtonTheme.style,
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

class HsDropDownButton extends StatelessWidget {
  final String? value;
  final VoidCallback onPressed;
  final String? icon;
  final TextStyle? labelStyle;
  final String? placeholder;
  final TextStyle? placeholderStyle;
  final FocusNode? focusNode;
  final ValueChanged? onFocusChange;
  const HsDropDownButton(
      {required this.onPressed,
      super.key,
      bool? isRequired,
      this.icon,
      this.value,
      this.labelStyle,
      this.placeholder,
      this.placeholderStyle,
      this.focusNode,
      this.onFocusChange});
  @override
  Widget build(BuildContext context) {
    return SecondaryButton(
      focusNode: focusNode,
      onFocusChange: onFocusChange,
      // TODO: implement placeholder with enum of preriod
      label: value ?? placeholder ?? HatSpaceStrings.current.pleaseSelectValue,
      labelStyle: value == null ? placeholderStyle : labelStyle,
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
      onPressed: onPressed,
    );
  }
}

class HsBackButton extends StatelessWidget {
  const HsBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => context.pop(),
      icon: SvgPicture.asset(Assets.icons.arrowCalendarLeft),
    );
  }
}
