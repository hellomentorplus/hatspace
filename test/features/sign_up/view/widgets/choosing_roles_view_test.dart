import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/features/sign_up/view/widgets/choosing_roles_view.dart';
import 'package:hatspace/features/sign_up/view_model/choose_role_view_bloc.dart';
import 'package:hatspace/features/sign_up/view_model/choose_role_view_state.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../widget_tester_extension.dart';
import 'choosing_roles_view_test.mocks.dart';

@GenerateMocks([ChooseRoleViewBloc])
void main() {
  MockChooseRoleViewBloc mockChooseRoleViewBloc = MockChooseRoleViewBloc();
  setUp(() {
    when(mockChooseRoleViewBloc.state)
        .thenAnswer((realInvocation) => ChooseRoleViewInitial());
    when(mockChooseRoleViewBloc.stream)
        .thenAnswer((realInvocation) => Stream.value(ChooseRoleViewInitial()));
  });

  testWidgets('Check widgets on screen', (WidgetTester tester) async {
    const widget = ChoosingRoleViewBody();
    await tester.blocWrapAndPump<ChooseRoleViewBloc>(
        mockChooseRoleViewBloc, widget);

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
    const widget = ChoosingRoleViewBody();

    await tester.blocWrapAndPump<ChooseRoleViewBloc>(
        mockChooseRoleViewBloc, widget);

    //LISTVIEW
    ListView listView = tester.widget(find.byType(ListView));
    expect(listView.padding, const EdgeInsets.only(top: 32));
    expect(listView.shrinkWrap, true);
  });

  testWidgets('Check buttons on screen', (WidgetTester tester) async {
    const widget = ChoosingRoleViewBody();

    await tester.blocWrapAndPump<ChooseRoleViewBloc>(
        mockChooseRoleViewBloc, widget);

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
