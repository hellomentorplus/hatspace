import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/features/add_property/view/widgets/add_property_info_view/property_info_form.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/hs_theme.dart';

import '../../../widget_tester_extension.dart';

void main() {
  testWidgets('Test AddPropertyView UI', (WidgetTester widgetTester) async {
    await HatSpaceStrings.load(const Locale.fromSubtags(languageCode: 'en'));
    Widget propertyInforForm = PropertyInforForm();
    await widgetTester.wrapAndPump(propertyInforForm);
    Text header = widgetTester.widget(find.text('Information'));
    expect(header.style, textTheme.displayLarge);

    Text addressHeader = widgetTester.widget(find.text('Your address'));
    expect(
        addressHeader.style, textTheme.displayLarge?.copyWith(fontSize: 18.0));
  });
}
