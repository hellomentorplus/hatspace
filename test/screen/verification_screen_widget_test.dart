import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/bloc/verification/authentication_bloc.dart';

import 'package:hatspace/ui/verification_screen.dart';

class MockLoginBloc extends MockBloc<AuthenticationEvent, SignUpState>
    implements AuthenticationBloc {}

void main() {
  testWidgets('VerificationScreen smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.wrapAndPumpWidget(VerificationScreen(
      value: '1',
    ));

    // expect(find.text('Space App'), findsOneWidget);

    Text titleText = tester.widget(find.text('Space App'));

    expect(titleText.data, 'Space App');
    expect(titleText.style?.color, Colors.white);
    expect(titleText.textAlign, TextAlign.center);

    Padding outterText = tester.widget(find.ancestor(
        of: find.text('Space App'), matching: find.byType(Padding)));

    expect(outterText.padding, const EdgeInsets.only(top: 50.0));
  });
}

extension WidgetTesterExtension on WidgetTester {
  Future<void> wrapAndPumpWidget(Widget widget) async {
    await pumpWidget(MaterialApp(
      home: widget,
    ));
    await pump();
  }
}
