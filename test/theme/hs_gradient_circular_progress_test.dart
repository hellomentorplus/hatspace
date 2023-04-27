import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/theme/hs_gradient_circular_progress_bar.dart';
import 'package:hatspace/theme/widgets/hs_custom_loading.dart';

import '../widget_tester_extension.dart';

void main() {
  testWidgets("Ui testing of gradient circular progress bar",
      (WidgetTester widgetTester) async {
    GradientCircularProgressIndicator customProgress =
        const GradientCircularProgressIndicator(
            radius: 28,
            gradientColors: [Colors.white, Colors.redAccent],
            strokeCap: StrokeCap.round,
            strokeWidth: 5.0);

    await widgetTester.wrapAndPump(customProgress);

    expect(customProgress.radius, 28);
    expect(customProgress.gradientColors, [Colors.white, Colors.redAccent]);
    expect(customProgress.strokeCap, StrokeCap.round);
    expect(customProgress.strokeWidth, 5.0);
  });
  testWidgets("Test custom loading UI", (WidgetTester widgetTester) async {
    CustomLoading customLoading = const CustomLoading(
        duration: Duration(seconds: 2),
        strokeCap: StrokeCap.round,
        radius: 24,
        strokeWidth: 4.0,
        gradientColors: [Colors.white, Colors.redAccent]);

    await widgetTester.pumpWidget(customLoading);
    await widgetTester.pump(const Duration(seconds: 2));
    expect(customLoading.radius, 24);
    expect(customLoading.gradientColors, [Colors.white, Colors.redAccent]);
    expect(customLoading.strokeCap, StrokeCap.round);
    expect(customLoading.strokeWidth, 4.0);
  });
}
