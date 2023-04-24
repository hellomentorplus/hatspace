import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:hatspace/theme/pop_up/pop_up_controller.dart';

import '../widget_tester_extension.dart';

void main() {
  final Builder builder = Builder(builder: (BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          context.showLoading();
        },
        child: const Text("Show Loading"));
  });
  testWidgets("Test pop up ui", (WidgetTester widgetTester) async {
    await widgetTester.wrapAndPump(builder);
    await widgetTester.tap(find.byType(ElevatedButton));
    await widgetTester.pump();
    AlertDialog alert = widgetTester.widget(find.byType(AlertDialog));
    expect(alert.backgroundColor, HSColor.onPrimary);
    expect(alert.shape, isA<RoundedRectangleBorder>());
    expect(
        alert.shape,
        const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0))));
  });
}
