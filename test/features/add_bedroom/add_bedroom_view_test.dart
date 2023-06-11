import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/features/add_bedroom/view/add_bedroom_counter.dart';
import 'package:hatspace/features/add_bedroom/view/add_bedroom_view.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';

import '../../widget_tester_extension.dart';

void main() {
  testWidgets('verify UI components', (WidgetTester tester) async {
    Widget widget = const AddBedroomView();

    await tester.wrapAndPump(widget);
    expect(find.byType(AddBedroomCounter), findsNWidgets(3));
    expect(find.text('How many bedrooms, bathrooms, parking?'), findsOneWidget);
    expect(find.byType(BottomAppBar), findsOneWidget);
    expect(find.byType(LinearProgressIndicator), findsOneWidget);
    final state = <MaterialState>{};

    TextOnlyButton backButton = tester.widget(find.byType(TextOnlyButton));

    LinearProgressIndicator indicator =
        tester.widget(find.byType(LinearProgressIndicator));
    expect(indicator.value, 0.5);

    expect(
      reason: "Testing padding of back button",
      backButton.style?.padding?.resolve(state),
      const EdgeInsets.fromLTRB(10, 17, 32, 17),
    );
    expect(
        reason: "Testing foreground color of back button",
        backButton.style?.foregroundColor?.resolve(state),
        HSColor.neutral9);
  });
}
