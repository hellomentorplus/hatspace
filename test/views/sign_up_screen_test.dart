import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/features/sign_up/view/sign_up_view.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';
import "../widget_tester_extension.dart";

void main() {
  testWidgets('Check close icon button', (WidgetTester tester) async {
    const widget = SignUpScreen();

    await tester.wrapAndPump(widget);
    Padding wrapContainer = tester.firstWidget(find.byType(Padding));
    expect(wrapContainer.padding,
        const EdgeInsets.only(left: 16, right: 16, bottom: 71));
    IconButton button = tester.widget(find.byType(IconButton));
    SecondaryButton signUpWithGoogleButton = tester.widget(find.ancestor(
        of: find.text("Sign up with Google"),
        matching: find.byType(SecondaryButton)));
    // await tester.tap(find.byWidget(signUpWithGoogleButton));
    SecondaryButton signUpWithFacebookButton = tester.widget(find.ancestor(
        of: find.text("Sign up with Facebook"),
        matching: find.byType(SecondaryButton)));
    //await tester.tap(find.byWidget(signUpWithFacebookButton));
    SecondaryButton signUpWithEmailButton = tester.widget(find.ancestor(
        of: find.text("Sign up with email"),
        matching: find.byType(SecondaryButton)));
    // await tester.tap(find.byWidget(signUpWithEmailButton));
    TextOnlyButton skipButton = tester.widget(find.ancestor(
        of: find.text("Skip"), matching: find.byType(TextOnlyButton)));
    // await tester.tap(find.byWidget(skipButton));
    RichText richText =
        tester.widget(find.textContaining("Sign in", findRichText: true));
    final span = richText.text as TextSpan;
    expect(span.children?.elementAt(1).toPlainText(), "Sign in");
  });
}