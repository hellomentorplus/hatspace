import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';
import 'package:hatspace/theme/widgets/hs_warning_bottom_sheet.dart';

import '../widget_tester_extension.dart';

void main() {
  testWidgets('Verify UI when having all fields',
      (WidgetTester widgetTester) async {
    Widget hsWarningBottomSheetView = HsWarningBottomSheetView(
      title: 'title',
      description: 'description',
      iconUrl: Assets.images.check,
      primaryButtonLabel: 'Primary button',
      primaryOnPressed: null,
      secondaryButtonLabel: 'Secondary button',
      secondaryOnPressed: null,
      textButtonLabel: 'Text button',
      textButtonOnPressed: null,
      tertiaryButtonLabel: 'Tertiary button',
      tertiaryButtonOnPressed: null,
    );
    await widgetTester.wrapAndPump(hsWarningBottomSheetView);
    // Verify text style
    Text title = widgetTester.widget(find.text('title'));
    expect(title.style?.fontSize, FontStyleGuide.fontSize18);
    Text description = widgetTester.widget(find.text('description'));
    expect(description.maxLines, 3);
    expect(description.overflow, TextOverflow.ellipsis);
    // Verify icon
    expect(find.byType(SvgPicture), findsOneWidget);
    // Verify buttons
    expect(find.byType(PrimaryButton), findsOneWidget);
    expect(find.byType(SecondaryButton), findsOneWidget);
    expect(find.byType(TextOnlyButton), findsOneWidget);
    expect(find.byType(TertiaryButton), findsOneWidget);
  });
}
