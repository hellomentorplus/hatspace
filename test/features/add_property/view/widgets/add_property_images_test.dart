import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/features/add_property/view/widgets/add_property_images.dart';

import '../../../../widget_tester_extension.dart';

void main() {
  testWidgets('verify add property images screen with empty selected images', (widgetTester) async {
    const Widget widget = AddPropertyImages();
    await widgetTester.wrapAndPump(widget);

    expect(find.byType(Text), findsNWidgets(2));
    expect(find.text('Let\'s add some photos of your place'), findsOneWidget);
    expect(find.text('Require at least 4 photos *'), findsOneWidget);
    expect(find.byType(SvgPicture), findsOneWidget);
  });
}