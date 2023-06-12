import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/features/add_property/view/property_infor/property_info_form.dart';
import 'package:hatspace/theme/hs_theme.dart';

import '../../../widget_tester_extension.dart';

void main() {
  Widget propertyInforForm = PropertyInforForm();
  testWidgets('Test UI', (widgetTester) async {
    await widgetTester.wrapAndPump(propertyInforForm);
    Text header = widgetTester.widget(find.text("Information"));
    expect(header.style, textTheme.displayLarge);

    Text addressHeader = widgetTester.widget(find.text("Your address"));
    expect(
        addressHeader.style, textTheme.displayLarge?.copyWith(fontSize: 18.0));
  });
}
