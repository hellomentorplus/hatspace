import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/features/add_bedroom/view/add_bedroom_counter.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';

import '../../widget_tester_extension.dart';

void main() {
  testWidgets('verify UI components', (WidgetTester tester) async {
    final ValueNotifier<int> counter = ValueNotifier<int>(1);
    Widget widget = AddBedroomCounter(counter: counter, text: 'Bedrooms');

    await tester.wrapAndPump(widget);
    expect(find.byType(RoundButton), findsNWidgets(2));
    expect(find.text('Bedrooms'), findsOneWidget);
    expect(find.text('1'), findsOneWidget);

    await tester.tap(find.byType(RoundButton).first);
    expect(reason: "Testing decrement button", counter.value, 0);

    await tester.tap(find.byType(RoundButton).last);
    expect(reason: "Testing increment button", counter.value, 1);
  });
}
