import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/features/sign_up/view/choosing_roles_view.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';

import '../widget_tester_extension.dart';

void main() {
  testWidgets('Check widgets on screen', (WidgetTester tester) async {
    const widget = ChoosingRolesView();

    await tester.wrapAndPump(widget);

    Padding firstPadding = tester.firstWidget(find.byType(Padding));
    expect(firstPadding.padding,
        const EdgeInsets.only(top: 33, left: 16, right: 16, bottom: 30));

    // Column textColumn = tester.widget(find.ancestor(
    //     of: find.text('Choose your role'), matching: find.byType(Column)));
    // expect(textColumn.crossAxisAlignment, CrossAxisAlignment.start);
    // expect(textColumn.mainAxisAlignment, MainAxisAlignment.start);

    expect(find.text('Choose your role'), findsOneWidget);

    expect(find.text('You can be tenant or homeowner, OR you can be both.'),
        findsOneWidget);
  });

  testWidgets('Check list view on screen', (WidgetTester tester) async {
    const widget = ChoosingRolesView();

    await tester.wrapAndPump(widget);

    //LISTVIEW
    ListView listView = tester.widget(find.byType(ListView));
    expect(listView.padding, const EdgeInsets.only(top: 32));
    expect(listView.shrinkWrap, true);
  });

  testWidgets('Check buttons on screen', (WidgetTester tester) async {
    const widget = ChoosingRolesView();

    await tester.wrapAndPump(widget);

    //PRIMARY BUTTON
    PrimaryButton primaryBtn = tester.widget(find.byType(PrimaryButton));
    expect(primaryBtn.label, 'Continue');

    // Padding cancelBtnPadding = tester.widget(find.ancestor(
    //     of: find.byType(TextOnlyButton), matching: find.byType(Padding)));
    // expect(cancelBtnPadding.padding, const EdgeInsets.only(top: 33));
    //CANCEL BUTTON
    TextOnlyButton cancelBtn = tester.widget(find.byType(TextOnlyButton));
    expect(cancelBtn.label, 'Cancel');
    expect(cancelBtn.onPressed, isNotNull);
  });
}
