import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hatspace/theme/hs_button_theme.dart';
import 'package:hatspace/theme/hs_theme.dart';

class PrimaryButton extends StatelessWidget {
  final String? label;
  final String? iconUrl;
  final VoidCallback? onPressed;

  const PrimaryButton({Key? key, this.label, this.iconUrl, this.onPressed})
      : assert(label != null || iconUrl != null, "label or icon is required"),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    // FOR TEXT ONLY BUTTON
    if (iconUrl == null && label != null) {
      return ElevatedButton(
          key: key,
          onPressed: onPressed,
          style: primaryButtonTheme.style,
          child: Text(label!));
    }
    // BUTTON WITH ICON ONLY
    if (iconUrl != null && label == null) {
      return ElevatedButton(
        onPressed: onPressed,
        style: buttonWithIconTheme.style,
        child: SvgPicture.asset(
          iconUrl!,
          width: 24,
          height: 24,
          color: onPressed == null ? HSColor.onPrimary : null,
          alignment: Alignment.center,
        ),
      );
    }
    // Button with icon
    return ElevatedButton(
        key: key,
        onPressed: onPressed,
        style: buttonWithIconTheme.style,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: SvgPicture.asset(
                iconUrl!,
                width: 24,
                height: 24,
                color: onPressed == null ? HSColor.onPrimary : null,
                alignment: Alignment.center,
              ),
            ),
            Expanded(
                flex: 4,
                child: Text(
                  label!,
                  textAlign: TextAlign.center,
                )),
          ],
        ));
  }
}

class SecondaryButton extends StatelessWidget {
  final String? label;
  final String? iconURL;
  final VoidCallback? onPressed;
  const SecondaryButton({Key? key, this.label, this.iconURL, this.onPressed})
      : assert(label != null || iconURL != null, "either are required"),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    // WITH TEXT ONLY
    if (iconURL == null && label != null) {
      return OutlinedButton(
          onPressed: onPressed,
          style: secondaryButtonTheme.style,
          child: Text(label!));
    }
    // WITH ICON ONLY
    if (iconURL != null && label == null) {
      return OutlinedButton(
          style: secondaryButtonWithIconTheme.style,
          onPressed: onPressed,
          child: SvgPicture.asset(
            iconURL!,
            width: 24,
            height: 24,
            color: onPressed == null ? HSColor.neutral3 : null,
            alignment: Alignment.center,
          ));
    }

    // BUTTON WITH ICON AND TEXT
    return OutlinedButton(
        onPressed: onPressed,
        style: secondaryButtonWithIconTheme.style,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: SvgPicture.asset(
                  iconURL!,
                  width: 24,
                  height: 24,
                  color: onPressed == null ? HSColor.neutral3 : null,
                  alignment: Alignment.center,
                )),
            Expanded(
                flex: 4,
                child: Text(
                  label!,
                  textAlign: TextAlign.center,
                )),
          ],
        ));
  }
}

class TextOnlyButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final Color? textColor;
  const TextOnlyButton(
      {Key? key, required this.label, required this.onPressed, this.textColor})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: textOnlyButtonTheme.style,
      child: Text(label),
    );
  }
}

class RoundButton extends StatelessWidget {
  // final String label;
  final String? iconUrl;
  final VoidCallback? onPressed;
  final Color? textColor;
  const RoundButton(
      {Key? key,
      required this.iconUrl,
      required this.onPressed,
      this.textColor})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: roundButtonTheme.style,
      child: SvgPicture.asset(
        iconUrl!,
        width: 24,
        height: 24,
        color: onPressed == null ? HSColor.neutral6 : null,
      ),
    );
  }
}

class NextButton extends StatelessWidget {
  final String? label;
  final String? iconUrl;
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
            Text(label!),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 4),
              child: SvgPicture.asset(
                iconUrl!,
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
  final String? label;
  final String? iconUrl;
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
                iconUrl!,
                width: 24,
                height: 24,
                color: HSColor.neutral9,
                alignment: Alignment.center,
              ),
            ),
            Text(label!),
          ],
        ));
  }
}
