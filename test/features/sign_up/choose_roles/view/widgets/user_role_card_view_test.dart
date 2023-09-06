import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/data/data.dart';
import 'package:hatspace/features/sign_up/choose_roles/view/widgets/user_role_card_view.dart';
import 'package:hatspace/features/sign_up/choose_roles/view_model/choose_roles_cubit.dart';
import 'package:hatspace/models/authentication/authentication_service.dart';
import 'package:hatspace/models/storage/storage_service.dart';
import 'package:hatspace/singleton/hs_singleton.dart';
import 'package:mockito/annotations.dart';

import '../../../../../widget_tester_extension.dart';
import 'user_role_card_view_test.mocks.dart';

@GenerateMocks([StorageService, AuthenticationService])
void main() {
  MockStorageService storageService = MockStorageService();
  MockAuthenticationService authenticationService = MockAuthenticationService();
  setUp(() {
    HsSingleton.singleton.registerSingleton<StorageService>(storageService);
    HsSingleton.singleton
        .registerSingleton<AuthenticationService>(authenticationService);
  });
  testWidgets('[UI][Interaction] Validate role card',
      (WidgetTester tester) async {
    await tester.blocWrapAndPump(
        ChooseRolesCubit(), const UserRoleCardView(role: Roles.tenant));

    expect(find.byType(SvgPicture), findsOneWidget);
    expect(find.byType(Checkbox), findsOneWidget);
    expect(find.text('Tenant'), findsOneWidget);
    expect(
        find.text(
            'You can explore properties, connect directly to homeowners, upload your rental application.'),
        findsOneWidget);

    final Finder rolFinder = find.byType(UserRoleCardView);
    expect(rolFinder, findsOneWidget);
    final Card cardWidget = tester
        .widget(find.descendant(of: rolFinder, matching: find.byType(Card)));
    final Checkbox checkBoxWidget = tester.widget(find.byType(Checkbox));
    expect(checkBoxWidget.activeColor, const Color(0xFF32A854));

    expect(checkBoxWidget.value, false);
    expect((cardWidget.shape as RoundedRectangleBorder).side.color,
        Colors.transparent);
    expect(cardWidget.color, const Color(0xFFF3F3F3));

    await tester.tap(rolFinder);
    await tester.pumpAndSettle();

    final Checkbox checkBoxWidgetAfter = tester.widget(find.byType(Checkbox));
    final Card cardWidgetAfter = tester
        .widget(find.descendant(of: rolFinder, matching: find.byType(Card)));
    expect(checkBoxWidgetAfter.value, true);
    expect(cardWidgetAfter.color, const Color(0xffEBFAEF));
    expect((cardWidgetAfter.shape as RoundedRectangleBorder).side.color,
        const Color(0xFF32A854));

    await tester.tap(find.byType(Checkbox));
    await tester.pumpAndSettle();

    expect(checkBoxWidget.value, false);
    expect((cardWidget.shape as RoundedRectangleBorder).side.color,
        Colors.transparent);
    expect(cardWidget.color, const Color(0xFFF3F3F3));
  });
}
