import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/features/application/view/application_guide_screen.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';

import '../../../widget_tester_extension.dart';
import '../../add_property/view/widgets/add_rooms_view_test.dart';

void main() {
  testWidgets('Verify UI', (widgetTester) async {
    await widgetTester.wrapAndPump(const ApplicationGuideScreen());

    expect(find.text('Guide for application'), findsOneWidget);
    expect(
        find.text(
            'All adult applicants (18 years or older) must complete a separate application for rental.'),
        findsOneWidget);

    expect(find.text('Please provide the following with your application:'),
        findsOneWidget);
    expect(find.text("Identification (driver's license/passport)"),
        findsOneWidget);
    expect(find.text('Tenancy ledger/rental reference'), findsOneWidget);
    expect(find.text('Pay slips/centre link statement'), findsOneWidget);
    expect(find.text('Current bank statement'), findsOneWidget);

    expect(find.text('Download Application form here'), findsOneWidget);

    expect(
        find.text(
            'If you have any questions, please feel free to let us know. We will always here to support you!'),
        findsOneWidget);

    expect(
        find.byWidgetPredicate((widget) => validateSvgPictureWithAssets(
            widget, 'assets/icons/identification.svg')),
        findsOneWidget);

    expect(
        find.byWidgetPredicate((widget) => validateSvgPictureWithAssets(
            widget, 'assets/icons/information.svg')),
        findsOneWidget);

    expect(
        find.byWidgetPredicate((widget) =>
            validateSvgPictureWithAssets(widget, 'assets/icons/pay_slips.svg')),
        findsOneWidget);

    expect(
        find.byWidgetPredicate((widget) => validateSvgPictureWithAssets(
            widget, 'assets/icons/tenancy_reference.svg')),
        findsOneWidget);

    expect(
        find.byWidgetPredicate((widget) => validateSvgPictureWithAssets(
            widget, 'assets/icons/bank_statement.svg')),
        findsOneWidget);

    expect(
        find.byWidgetPredicate((widget) =>
            validateSvgPictureWithAssets(widget, 'assets/icons/download.svg')),
        findsOneWidget);

    expect(
        find.byWidgetPredicate((widget) => validateSvgPictureWithAssets(
            widget, 'assets/icons/email_white.svg')),
        findsOneWidget);

    expect(find.ancestor(
        of: find.text('Download'), matching: find.byType(SecondaryButton)), findsOneWidget);
    
    expect(
        find.ancestor(
            of: find.text('Support contact'), matching: find.byType(SecondaryButton)),
        findsOneWidget);

    expect(
        find.ancestor(
            of: find.text('Send Email'), matching: find.byType(PrimaryButton)),
        findsOneWidget);
  });
}
