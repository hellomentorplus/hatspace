import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/features/sign_up/view/widgets/user_role_card_view.dart';
import 'package:hatspace/features/sign_up/view_model/choose_role_view_bloc.dart';
import 'package:hatspace/models/authentication/authentication_service.dart';
import 'package:hatspace/models/storage/storage_service.dart';
import 'package:hatspace/singleton/hs_singleton.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:mockito/annotations.dart';

import '../../view_model/sign_up_bloc_test.mocks.dart';
import '../../../../widget_tester_extension.dart';

@GenerateMocks([StorageService, AuthenticationService])
void main() {
  MockStorageService storageService = MockStorageService();
  MockAuthenticationService authenticationService = MockAuthenticationService();
  setUp(() {
    HsSingleton.singleton.registerSingleton<StorageService>(storageService);
    HsSingleton.singleton
        .registerSingleton<AuthenticationService>(authenticationService);
  });
  testWidgets('Check widgets on screen', (WidgetTester tester) async {
    const widget = UserRoleCardView(position: 1);

    await tester.blocWrapAndPump(ChooseRoleViewBloc(), widget);

    InkWell inkWell = tester.widget(find.byType(InkWell));
    expect(inkWell.onTap, isNotNull);

    Card card = tester.widget(find.byType(Card));
    expect(card.margin, const EdgeInsets.only(top: 16));
    expect(card.elevation, 6);
    expect(
        card.shape,
        const RoundedRectangleBorder(
            side: BorderSide(color: HSColor.neutral5),
            borderRadius: BorderRadius.all(Radius.circular(12))));
  });
}
