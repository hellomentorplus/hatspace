import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hatspace/theme/hs_button_theme.dart';

import 'hs_buttons_settings.dart';

class ButtonWithIconContent extends StatelessWidget {
  final IconPosition? iconPosition;
  final String label;
  final String iconUrl;
  final MainAxisAlignment contentAlignment;
  const ButtonWithIconContent({
    super.key,
    this.iconPosition,
    required this.label,
    required this.iconUrl,
    required this.contentAlignment,
  });

  @override
  Widget build(BuildContext context) {
    final List<Widget> buttonContent = [
      SvgPicture.asset(
        iconUrl,
        width: 24,
        height: 24,
        color: DefaultTextStyle.of(context).style.color,
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
  const PrimaryButton({
    Key? key,
    required this.label,
    this.iconUrl,
    this.onPressed,
    this.iconPosition = IconPosition.left,
    this.style,
    this.contentAlignment = MainAxisAlignment.center,
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

  const SecondaryButton({
    Key? key,
    required this.label,
    this.iconUrl,
    this.onPressed,
    this.iconPosition = IconPosition.left,
    this.style,
    this.contentAlignment = MainAxisAlignment.center,
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
    Key? key,
    required this.label,
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

  const TertiaryButton({
    Key? key,
    required this.label,
    this.onPressed,
    this.iconUrl,
    this.iconPosition = IconPosition.left,
    this.contentAlignment = MainAxisAlignment.center,
    this.style,
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
        ));
  }
}

class HsBackButton extends StatelessWidget {
  final SvgPicture icon;
  final String lable;
  final VoidCallback? onPressed;
  const HsBackButton(
      {super.key, required this.lable, required this.icon, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.transparent)),
        child: Row(
          children: [
            icon,
            Container(width: 18),
            // TODO: Update theme
            Text(
              lable,
              style: const TextStyle(
                  fontWeight: FontWeight.w700, color: HSColor.onSurface),
            )
          ],
        ));
  }
}

class HsNextButton extends StatelessWidget {
  final SvgPicture icon;
  final String lable;
  final VoidCallback? onPressed;
  const HsNextButton(
      {super.key, required this.icon, required this.lable, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: const ButtonStyle(
          backgroundColor: MaterialStatePropertyAll<Color>(HSColor.primary),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
          child: Row(
            children: [
              // TODO: update theme
              Text(lable,
                  style: const TextStyle(
                      color: HSColor.background,
                      fontSize: 14,
                      fontWeight: FontWeight.w700)),
              Container(width: 18),
              icon
            ],
          ),
        ));
  }
}

class NextButton extends StatelessWidget {
  final String label;
  final String iconUrl;
  final VoidCallback? onPressed;

  const NextButton(
      {Key? key, required this.label, required this.iconUrl, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Button with icon
    return ElevatedButton(
        key: key,
        onPressed: onPressed,
        style: nextButtonTheme.style,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(label),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 4),
              child: SvgPicture.asset(
                iconUrl,
                width: 24,
                height: 24,
                color: onPressed == null ? HSColor.neutral6 : HSColor.onPrimary,
                alignment: Alignment.center,
              ),
            ),
          ],
        ));
  }
}

class PrevButton extends StatelessWidget {
  final String label;
  final String iconUrl;
  final VoidCallback? onPressed;

  const PrevButton(
      {Key? key, required this.label, required this.iconUrl, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Button with icon
    return TextButton(
        key: key,
        onPressed: onPressed,
        style: backButtonTheme.style,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10, top: 4),
              child: SvgPicture.asset(
                iconUrl,
                width: 24,
                height: 24,
                color: HSColor.neutral9,
                alignment: Alignment.center,
              ),
            ),
            Text(label),
          ],
        ));
  }
}
