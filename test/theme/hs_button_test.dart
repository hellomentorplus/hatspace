import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';
import 'package:hatspace/theme/widgets/hs_buttons_settings.dart';

import '../widget_tester_extension.dart';

void main() {
  group("Test PrimaryButton", () {
    testWidgets(
        "Test PrimaryButton with ONLY TEXT with Default-Disabled-Hovered ",
        (WidgetTester tester) async {
      int count = 0;
      final Builder primaryButton = Builder(builder: (BuildContext context) {
        return PrimaryButton(
            label: "Continue",
            style: Theme.of(context).elevatedButtonTheme.style,
            onPressed: () {
              count = 1;
            });
      });
      // Widget primaryButton = PrimaryButton(
      //     label: "Continue",
      //     onPressed: () {
      //       count = 1;
      //     });
      await tester.wrapAndPump(primaryButton, theme: lightThemeData);
      ElevatedButton btn =
          tester.widget(find.widgetWithText(ElevatedButton, "Continue"));
      // ====== DEFAULT ========
      final state = <MaterialState>{};
      expect(find.byType(Text), findsOneWidget);
      expect(find.byType(SvgPicture), findsNothing);

      expect(
          reason: "Show True if alignment is center",
          btn.style?.alignment,
          Alignment.center);
      expect(
          reason: "Testing padding of button",
          btn.style?.padding?.resolve(state),
          const EdgeInsets.symmetric(vertical: 17, horizontal: 32));
      expect(
          reason: "Testing borderRadius of button",
          btn.style?.shape?.resolve(state),
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)));
      expect(
          reason: "Check Default Background",
          btn.style?.backgroundColor?.resolve(state),
          HSColor.primary);

      await tester.tap(find.widgetWithText(ElevatedButton, "Continue"));
      expect(reason: "Testing onPressed button", count, 1);
      //===== DISABLED ========
      final disabledState = <MaterialState>{MaterialState.disabled};
      expect(
          reason: "Check Default Background",
          btn.style?.backgroundColor?.resolve(disabledState),
          HSColor.neutral3);
      expect(
          reason: "Testing color of Text",
          btn.style?.foregroundColor?.resolve(disabledState),
          HSColor.neutral5);
    });

    testWidgets('Test PrimaryButton with icon', (WidgetTester tester) async {
      final Builder primaryButton = Builder(builder: (BuildContext context) {
        return PrimaryButton(
          label: "Continue",
          iconUrl: Assets.images.facebook,
          style: Theme.of(context).elevatedButtonTheme.style,
        );
      });

      await tester.wrapAndPump(primaryButton, theme: lightThemeData);
      ElevatedButton btn =
          tester.widget(find.widgetWithText(ElevatedButton, "Continue"));
      SvgPicture svgPicture = tester.widget(find.byType(SvgPicture));
      final state = <MaterialState>{};

      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.byType(SvgPicture), findsOneWidget);

      expect(
          reason: "Show True if alignment is center",
          btn.style?.alignment,
          Alignment.center);

      // verify Svg icon size
      expect(svgPicture.width, 24);
      expect(svgPicture.height, 24);

      expect(
          reason: "innerIcon is in center",
          svgPicture.alignment,
          Alignment.center);
      expect(
          reason: "Testing padding top and bottom of button",
          btn.style?.padding?.resolve(state),
          const EdgeInsets.symmetric(vertical: 17, horizontal: 32));
      expect(
          reason: "Testing borderRadius of button",
          btn.style?.shape?.resolve(state),
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)));
      expect(
          reason: "Check Default Background",
          btn.style?.backgroundColor?.resolve(state),
          HSColor.primary);

      //===== DISABLED ========
      final disabledState = <MaterialState>{MaterialState.disabled};
      expect(
          reason: "Check Default Background",
          btn.style?.backgroundColor?.resolve(disabledState),
          HSColor.neutral3);
      expect(
          reason: "Testing color of Text",
          btn.style?.foregroundColor?.resolve(disabledState),
          HSColor.neutral5);
    });

    testWidgets(
        "Test if primary button passes on params to ButtonWithIconContent",
        (WidgetTester tester) async {
      PrimaryButton primaryButton = PrimaryButton(
        label: "Continue",
        iconUrl: Assets.images.facebook,
        iconPosition: IconPosition.right,
        contentAlignment: MainAxisAlignment.start,
      );
      await tester.wrapAndPump(primaryButton);
      ButtonWithIconContent buttonContent =
          tester.widget(find.byType(ButtonWithIconContent));
      expect(
          reason: "Button content has start alignment",
          buttonContent.contentAlignment,
          MainAxisAlignment.start);
      expect(
          reason: "Button content has right icon position",
          buttonContent.iconPosition,
          IconPosition.right);
      expect(
          reason: "Button content has the correct text passed on",
          buttonContent.label,
          "Continue");
      expect(
          reason: "Button content has the correct image passed on",
          buttonContent.iconUrl,
          Assets.images.facebook);
    });
  });

  // TODO:  WAIT FOR UI DESGIN -- need to ask for confirmation

  group("Test SecondaryButton", () {
    testWidgets(
        "Test SecondaryButton with ONLY TEXT with Default-Disabled-Hovered ",
        (WidgetTester tester) async {
      int count = 0;
      final Builder secondaryButton = Builder(builder: (BuildContext context) {
        return SecondaryButton(
          label: "Continue",
          style: Theme.of(context).outlinedButtonTheme.style,
          onPressed: () {
            count = 1;
          },
        );
      });
      // Widget secondaryButton = SecondaryButton(
      //     label: "Continue",
      //     onPressed: () {
      //       count = 1;
      //     });
      await tester.wrapAndPump(secondaryButton, theme: lightThemeData);
      OutlinedButton btn =
          tester.widget(find.widgetWithText(OutlinedButton, "Continue"));
      // ====== DEFAULT ========
      final state = <MaterialState>{};
      expect(
          reason: "Show True if alignemnt is center",
          btn.style?.alignment,
          Alignment.center);
      expect(
          reason: "Testing padding of button",
          btn.style?.padding?.resolve(state),
          const EdgeInsets.symmetric(vertical: 17, horizontal: 32));
      expect(
          reason: "Testing borderRadius of button",
          btn.style?.shape?.resolve(state),
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)));
      expect(
          reason: "Check Default border color with default state",
          btn.style?.side?.resolve(state),
          const BorderSide(color: HSColor.neutral4));

      await tester.tap(find.widgetWithText(OutlinedButton, "Continue"));
      expect(reason: "Testing onPressed button", count, 1);
      //===== DISABLED ========
      final disabledState = <MaterialState>{MaterialState.disabled};
      expect(
          reason: "Check Default border color with disabled state",
          btn.style?.side?.resolve(disabledState),
          const BorderSide(color: HSColor.neutral3));
    });

    testWidgets('Test SecondaryButton with icon', (WidgetTester tester) async {
      final Builder secondaryButton = Builder(builder: (BuildContext context) {
        return SecondaryButton(
          label: "Continue",
          iconUrl: Assets.images.facebook,
          style: Theme.of(context).outlinedButtonTheme.style,
        );
      });

      await tester.wrapAndPump(secondaryButton, theme: lightThemeData);
      OutlinedButton btn =
          tester.widget(find.widgetWithText(OutlinedButton, "Continue"));
      SvgPicture svgPicture = tester.widget(find.byType(SvgPicture));
      final state = <MaterialState>{};

      expect(find.byType(OutlinedButton), findsOneWidget);
      expect(find.byType(SvgPicture), findsOneWidget);

      expect(
          reason: "Show True if alignment is center",
          btn.style?.alignment,
          Alignment.center);

      // verify Svg icon size
      expect(svgPicture.width, 24);
      expect(svgPicture.height, 24);

      expect(
          reason: "innerIcon is in center",
          svgPicture.alignment,
          Alignment.center);
      expect(
          reason: "Testing padding top and bottom of button",
          btn.style?.padding?.resolve(state),
          const EdgeInsets.symmetric(vertical: 17, horizontal: 32));
      expect(
          reason: "Testing borderRadius of button",
          btn.style?.shape?.resolve(state),
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)));
      expect(
          reason: "Check Default border",
          btn.style?.side?.resolve(state),
          const BorderSide(color: HSColor.neutral4));

      //===== DISABLED ========
      final disabledState = <MaterialState>{MaterialState.disabled};
      expect(
          reason: "Check Default Border",
          btn.style?.side?.resolve(disabledState),
          const BorderSide(color: HSColor.neutral3));
      expect(
          reason: "Testing color of Text",
          btn.style?.foregroundColor?.resolve(disabledState),
          HSColor.neutral5);
    });

    testWidgets(
        "Test if secondary button passes on params to ButtonWithIconContent",
        (WidgetTester tester) async {
      SecondaryButton secondaryButton = SecondaryButton(
        label: "Continue",
        iconUrl: Assets.images.facebook,
        iconPosition: IconPosition.right,
        contentAlignment: MainAxisAlignment.start,
      );
      await tester.wrapAndPump(secondaryButton);
      ButtonWithIconContent buttonContent =
          tester.widget(find.byType(ButtonWithIconContent));
      expect(
          reason: "Button content has start alignment",
          buttonContent.contentAlignment,
          MainAxisAlignment.start);
      expect(
          reason: "Button content has right icon position",
          buttonContent.iconPosition,
          IconPosition.right);
      expect(
          reason: "Button content has the correct text passed on",
          buttonContent.label,
          "Continue");
      expect(
          reason: "Button content has the correct image passed on",
          buttonContent.iconUrl,
          Assets.images.facebook);
    });
  });

  group("Test TextOnlyButton", () {
    testWidgets("Test TextOnlyButton with DEFAULT-DISABLE-HOVERED",
        (WidgetTester tester) async {
      int count = 0;
      final Builder textOnlyButton = Builder(builder: (BuildContext context) {
        return TextOnlyButton(
          label: "Continue",
          style: Theme.of(context).textButtonTheme.style,
          onPressed: () {
            count = 1;
          },
        );
      });
      // Widget textOnlyButton = TextOnlyButton(
      //     label: "Continue",
      //     onPressed: () {
      //       count = 1;
      //     });
      await tester.wrapAndPump(textOnlyButton, theme: lightThemeData);
      TextButton btn =
          tester.widget(find.widgetWithText(TextButton, "Continue"));
      // ====== DEFAULT ========
      final state = <MaterialState>{};

      expect(
          reason: "Show True if alignemnt is center",
          btn.style?.alignment,
          Alignment.center);
      expect(
          reason: "Testing padding of button",
          btn.style?.padding?.resolve(state),
          const EdgeInsets.symmetric(vertical: 17, horizontal: 32));
      expect(
          reason: "Testing borderRadius of button",
          btn.style?.shape?.resolve(state),
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)));
      expect(
          reason: "Testing color of Text",
          btn.style?.foregroundColor?.resolve(state),
          HSColor.primary);

      await tester.tap(find.widgetWithText(TextButton, "Continue"));
      expect(reason: "Testing onPressed button", count, 1);
      //===== DISABLED ========
      final disabledState = <MaterialState>{MaterialState.disabled};
      expect(
          reason: "Testing color of Text",
          btn.style?.foregroundColor?.resolve(disabledState),
          HSColor.neutral3);
    });

    testWidgets('Test SecondaryButton with icon', (WidgetTester tester) async {
      final Builder textOnlyButton = Builder(builder: (BuildContext context) {
        return TextOnlyButton(
          label: "Continue",
          iconUrl: Assets.images.facebook,
          style: Theme.of(context).textButtonTheme.style,
        );
      });

      await tester.wrapAndPump(textOnlyButton, theme: lightThemeData);
      TextButton btn =
          tester.widget(find.widgetWithText(TextButton, "Continue"));
      SvgPicture svgPicture = tester.widget(find.byType(SvgPicture));
      final state = <MaterialState>{};

      expect(find.byType(TextButton), findsOneWidget);
      // expect(find.byType(SvgPicture), findsOneWidget);

      expect(
          reason: "Show True if alignment is center",
          btn.style?.alignment,
          Alignment.center);

      // verify Svg icon size
      expect(svgPicture.width, 24);
      expect(svgPicture.height, 24);

      expect(
          reason: "innerIcon is in center",
          svgPicture.alignment,
          Alignment.center);
      expect(
          reason: "Testing padding top and bottom of button",
          btn.style?.padding?.resolve(state),
          const EdgeInsets.symmetric(vertical: 17, horizontal: 32));
      expect(
          reason: "Testing borderRadius of button",
          btn.style?.shape?.resolve(state),
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)));
      expect(
          reason: "Testing color of Text",
          btn.style?.foregroundColor?.resolve(state),
          HSColor.primary);
      //===== DISABLED ========
      final disabledState = <MaterialState>{MaterialState.disabled};
      expect(
          reason: "Testing color of Text",
          btn.style?.foregroundColor?.resolve(disabledState),
          HSColor.neutral3);
    });

    testWidgets("Test if text button passes on params to ButtonWithIconContent",
        (WidgetTester tester) async {
      TextOnlyButton textOnlyButton = TextOnlyButton(
        label: "Continue",
        iconUrl: Assets.images.facebook,
        iconPosition: IconPosition.right,
        contentAlignment: MainAxisAlignment.start,
      );
      await tester.wrapAndPump(textOnlyButton);
      ButtonWithIconContent buttonContent =
          tester.widget(find.byType(ButtonWithIconContent));
      expect(
          reason: "Button content has start alignment",
          buttonContent.contentAlignment,
          MainAxisAlignment.start);
      expect(
          reason: "Button content has right icon position",
          buttonContent.iconPosition,
          IconPosition.right);
      expect(
          reason: "Button content has the correct text passed on",
          buttonContent.label,
          "Continue");
      expect(
          reason: "Button content has the correct image passed on",
          buttonContent.iconUrl,
          Assets.images.facebook);
    });
  });

  group("Test Tertiary Button", () {
    testWidgets(
        "Test TertiaryButton with ONLY TEXT with Default-Disabled-Hovered ",
        (WidgetTester tester) async {
      int count = 0;
      Widget tertiaryButton = TertiaryButton(
          label: "Continue",
          onPressed: () {
            count = 1;
          });
      await tester.wrapAndPump(tertiaryButton, theme: lightThemeData);
      OutlinedButton btn =
          tester.widget(find.widgetWithText(OutlinedButton, "Continue"));
      // ====== DEFAULT ========
      final state = <MaterialState>{};
      expect(find.byType(Text), findsOneWidget);
      expect(find.byType(SvgPicture), findsNothing);

      expect(
          reason: "Show True if alignment is center",
          btn.style?.alignment,
          Alignment.center);
      expect(
          reason: "Testing padding of button",
          btn.style?.padding?.resolve(state),
          const EdgeInsets.symmetric(vertical: 17, horizontal: 32));
      expect(
          reason: "Testing borderRadius of button",
          btn.style?.shape?.resolve(state),
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)));
      expect(
          reason: "Check Default Background",
          btn.style?.backgroundColor?.resolve(state),
          HSColor.accent);

      await tester.tap(find.widgetWithText(OutlinedButton, "Continue"));
      expect(reason: "Testing onPressed button", count, 1);
      //===== DISABLED ========
      final disabledState = <MaterialState>{MaterialState.disabled};
      expect(
          reason: "Check Default Background",
          btn.style?.backgroundColor?.resolve(disabledState),
          HSColor.neutral3);
      expect(
          reason: "Testing color of Text",
          btn.style?.foregroundColor?.resolve(disabledState),
          HSColor.neutral5);
    });

    testWidgets('Test TertiaryButton with icon', (WidgetTester tester) async {
      TertiaryButton outlinedButton = TertiaryButton(
        label: "Continue",
        iconUrl: Assets.images.facebook,
      );

      await tester.wrapAndPump(outlinedButton);
      OutlinedButton btn =
          tester.widget(find.widgetWithText(OutlinedButton, "Continue"));
      SvgPicture svgPicture = tester.widget(find.byType(SvgPicture));
      final state = <MaterialState>{};

      expect(find.byType(OutlinedButton), findsOneWidget);
      expect(find.byType(SvgPicture), findsOneWidget);

      expect(
          reason: "Show True if alignemnt is center",
          btn.style?.alignment,
          Alignment.center);

      // verify Svg icon size
      expect(svgPicture.width, 24);
      expect(svgPicture.height, 24);

      expect(
          reason: "innerIcon is in center",
          svgPicture.alignment,
          Alignment.center);
      expect(
          reason: "Testing padding top and bottom of button",
          btn.style?.padding?.resolve(state),
          const EdgeInsets.symmetric(vertical: 17, horizontal: 32));
      expect(
          reason: "Testing borderRadius of button",
          btn.style?.shape?.resolve(state),
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)));
      expect(
          reason: "Check Default Background",
          btn.style?.backgroundColor?.resolve(state),
          const Color(0xffEBFAEF));

      //===== DISABLED ========
      final disabledState = <MaterialState>{MaterialState.disabled};
      expect(
          reason: "Check Default Background",
          btn.style?.backgroundColor?.resolve(disabledState),
          HSColor.neutral3);
      expect(
          reason: "Testing color of Text",
          btn.style?.foregroundColor?.resolve(disabledState),
          HSColor.neutral5);
    });

    testWidgets(
        "Test if tertiary button passes on params to ButtonWithIconContent",
        (WidgetTester tester) async {
      TertiaryButton outlinedButton = TertiaryButton(
        label: "Continue",
        iconUrl: Assets.images.facebook,
        iconPosition: IconPosition.right,
        contentAlignment: MainAxisAlignment.start,
      );
      await tester.wrapAndPump(outlinedButton);
      ButtonWithIconContent buttonContent =
          tester.widget(find.byType(ButtonWithIconContent));
      expect(
          reason: "Button content has start alignment",
          buttonContent.contentAlignment,
          MainAxisAlignment.start);
      expect(
          reason: "Button content has right icon position",
          buttonContent.iconPosition,
          IconPosition.right);
      expect(
          reason: "Button content has the correct text passed on",
          buttonContent.label,
          "Continue");
      expect(
          reason: "Button content has the correct image passed on",
          buttonContent.iconUrl,
          Assets.images.facebook);
    });
  });

  group("Test ButtonWithIconContent", () {
    testWidgets("Center alignment and right icon position",
        (WidgetTester tester) async {
      Widget button = ButtonWithIconContent(
        label: "Continue",
        iconUrl: Assets.images.google,
        contentAlignment: MainAxisAlignment.center,
        iconPosition: IconPosition.right,
      );
      await tester.wrapAndPump(button);
      Row row = tester.widget(find.byType(Row));
      Padding textPadding = tester.widget(find.byType(Padding));
      expect(
          reason: "Row has center main axis alignment",
          row.mainAxisAlignment,
          MainAxisAlignment.center);

      expect(find.text("Continue"), findsOneWidget);
      expect(find.byType(SvgPicture), findsOneWidget);
      expect(
          reason: "Has padding on the right",
          textPadding.padding,
          const EdgeInsets.only(right: 8));
    });

    testWidgets("Start alignment and left icon position",
        (WidgetTester tester) async {
      Widget button = ButtonWithIconContent(
        label: "Continue",
        iconUrl: Assets.images.google,
        contentAlignment: MainAxisAlignment.start,
        iconPosition: IconPosition.left,
      );
      await tester.wrapAndPump(button);
      Row row = tester.widget(find.byType(Row));
      Padding textPadding = tester.widget(find.byType(Padding));
      expect(
          reason: "Row has start main axis alignment",
          row.mainAxisAlignment,
          MainAxisAlignment.start);

      expect(find.text("Continue"), findsOneWidget);
      expect(find.byType(SvgPicture), findsOneWidget);
      expect(
          reason: "Has padding on the left",
          textPadding.padding,
          const EdgeInsets.only(left: 8));
    });
  });

  testWidgets("Test RoundButton with DEFAULT-DISABLE-HOVERED",
      (WidgetTester tester) async {
    int count = 0;
    Widget roundButton = RoundButton(
        iconUrl: Assets.images.increment,
        onPressed: () {
          count = 1;
        });
    await tester.wrapAndPump(roundButton);

    expect(find.byType(TextButton), findsOneWidget);
    expect(find.byType(SvgPicture), findsOneWidget);
    expect(find.byType(Text), findsNothing);

    // verify Svg icon size
    SvgPicture svgPicture = tester.widget(find.byType(SvgPicture));
    expect(svgPicture.width, 24);
    expect(svgPicture.height, 24);

    await tester.tap(find.byType(SvgPicture));
    expect(reason: "Testing onPressed button", count, 1);

    //Verify button shape
    TextButton btn = tester.widget(find.byType(TextButton));
    //===== DISABLED ========
    final disabledState = <MaterialState>{MaterialState.disabled};
    expect(
      reason: "Testing color of Text",
      btn.style?.foregroundColor?.resolve(disabledState),
      HSColor.neutral6,
    );
  });
}
