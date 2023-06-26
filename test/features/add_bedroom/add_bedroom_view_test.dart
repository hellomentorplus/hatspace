import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/features/add_bedroom/view/add_bedroom_counter.dart';
import 'package:hatspace/features/add_property/view/widgets/add_bedroom_view.dart';

import '../../widget_tester_extension.dart';

void main() {
  testWidgets('verify UI components', (WidgetTester tester) async {
    Widget widget = const AddBedroomView();

    await tester.wrapAndPump(widget);
    expect(find.byType(AddBedroomCounter), findsNWidgets(3));
    expect(find.text('How many bedrooms, bathrooms, parking?'), findsOneWidget);
  });
}
