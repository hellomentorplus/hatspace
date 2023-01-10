import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/features/sign_up/view/user_role_card_view.dart';
import 'package:hatspace/theme/hs_theme.dart';

import '../widget_tester_extension.dart';

void main() {
  testWidgets('Check widgets on screen', (WidgetTester tester) async {
    final widget = UserRoleCardView(position: 1, onChanged: (bool) => {true});

    await tester.wrapAndPump(widget);

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
