import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';
import 'package:hatspace/main.dart';

import '../widget_tester_extension.dart';

void main() {
  testWidgets(
      "Test PrimaryButtonTheme with ONLY TEXT with Default-Disabled-Hovered ",
      (WidgetTester tester) async {
    int count = 0;
    Widget primaryButton = PrimaryButton(
        label: "Continue",
        onPressed: () {
          count = 1;
        });
    await tester.wrapAndPump(primaryButton);
    ElevatedButton btn =
        tester.widget(find.widgetWithText(ElevatedButton, "Continue"));
    // ====== DEFAULT ========
    final state = <MaterialState>{};
    expect(
        reason: "Show True if alignemnt is center",
        btn.style?.alignment,
        Alignment.center);
    expect(
        reason: "Testing padding top and bottom of button",
        btn.style?.padding?.resolve(state),
        const EdgeInsets.only(top: 17, bottom: 17));
    expect(
        reason: "Testing borderRadius of button",
        btn.style?.shape?.resolve(state),
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)));
    expect(
        reason: "Check Default Background",
        btn.style?.backgroundColor?.resolve(state),
        const Color(0xff3ACD64));

    await tester.tap(find.widgetWithText(ElevatedButton, "Continue"));
    expect(reason: "Testing onPressed button", count, 1);
    //===== DISABLED ========
    final disabelState = <MaterialState>{MaterialState.disabled};
    expect(
        reason: "Check Default Background",
        btn.style?.backgroundColor?.resolve(disabelState),
        const Color(0xffD1D1D6));
    expect(
        reason: "Testing color of Text",
        btn.style?.foregroundColor?.resolve(disabelState),
        HSColor.onPrimary);
  });

  // TODO:  WAIT FOR UI DESGIN -- need to ask for confirmation

  testWidgets(
      "Test SecondaryButton with ONLY TEXT with Default-Disabled-Hovered ",
      (WidgetTester tester) async {
    int count = 0;
    Widget secondaryButton = SecondaryButton(
        label: "Continue",
        onPressed: () {
          count = 1;
        });
    await tester.wrapAndPump(secondaryButton);
    OutlinedButton btn =
        tester.widget(find.widgetWithText(OutlinedButton, "Continue"));
    // ====== DEFAULT ========
    final state = <MaterialState>{};
    expect(
        reason: "Show True if alignemnt is center",
        btn.style?.alignment,
        Alignment.center);
    expect(
        reason: "Testing padding top and bottom of button",
        btn.style?.padding?.resolve(state),
        const EdgeInsets.only(top: 17, bottom: 17));
    expect(
        reason: "Testing borderRadius of button",
        btn.style?.shape?.resolve(state),
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)));
    expect(
        reason: "Check Default border color with default state",
        btn.style?.side?.resolve(state),
        const BorderSide(color: HSColor.primary));

    await tester.tap(find.widgetWithText(OutlinedButton, "Continue"));
    expect(reason: "Testing onPressed button", count, 1);
    //===== DISABLED ========
    final disabelState = <MaterialState>{MaterialState.disabled};
    expect(
        reason: "Check Default border color with disabled state",
        btn.style?.side?.resolve(disabelState),
        const BorderSide(color: HSColor.neutral3));
  });

  testWidgets("Test TextOnlyButton with DEFAULT-DISABLE-HOVERED",
      (WidgetTester tester) async {
    int count = 0;
    Widget secondaryButton = TextOnlyButton(
        label: "Continue",
        onPressed: () {
          count = 1;
        });
    await tester.wrapAndPump(secondaryButton);
    TextButton btn = tester.widget(find.widgetWithText(TextButton, "Continue"));
    // ====== DEFAULT ========
    final state = <MaterialState>{};

    expect(
        reason: "Testing underline",
        btn.style?.textStyle?.resolve(state)?.decoration,
        TextDecoration.underline);

    await tester.tap(find.widgetWithText(TextButton, "Continue"));
    expect(reason: "Testing onPressed button", count, 1);
    //===== DISABLED ========
    final disabelState = <MaterialState>{MaterialState.disabled};
  });

  testWidgets("Test Button with Icon With DEFAULT-DISABLE-HOVER",
      (WidgetTester tester) async {
    Widget primaryButton = PrimaryButton(
        iconUrl: Assets.images.facebook,
        label: "Continue with Facebook",
        onPressed: () {});
    await tester.wrapAndPump(primaryButton);
    ElevatedButton btn = tester
        .widget(find.widgetWithText(ElevatedButton, "Continue with Facebook"));
    SvgPicture innerIcon = tester.firstWidget(find.byType(SvgPicture));

    // ====== DEFAULT ========
    final state = <MaterialState>{};
    expect(
        reason: "Show True if alignemnt is center",
        btn.style?.alignment,
        Alignment.center);
    expect(
        reason: "innerIcon is in center",
        innerIcon.alignment,
        Alignment.center);

    // expect (reason:"Testing padding top and bottom of button",btn.style?.padding?.resolve(state), const EdgeInsets.only(top: 17, bottom: 17));
    // expect (reason:"Testing borderRadius of button", btn.style?.shape?.resolve(state),RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)));
    // expect (reason: "Check Default Background", btn.style?.backgroundColor?.resolve(state), const Color(0xff3ACD64));

    // await tester.tap(find.widgetWithText(ElevatedButton, "Continue"));
    // expect (reason:"Testing onPressed button",count, 1 );
    // //===== DISABLED ========
    // final disabelState = <MaterialState>{MaterialState.disabled};
    // expect (reason: "Check Default Background", btn.style?.backgroundColor?.resolve(disabelState), const Color(0xffD1D1D6));
    //  expect (reason: "Testing color of Text", btn.style?.foregroundColor?.resolve(disabelState),HSColor.onPrimary);
  });
}
