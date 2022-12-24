import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/features/sign_up/view/sign_up_view.dart';
import 'package:hatspace/features/sign_up/view_model/sign_up_bloc.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "../widget_tester_extension.dart";

void main() {
  Widget widget = BlocProvider<SignUpBloc>(
    create: (context) {
      return SignUpBloc();
    },
    child: const SignUpScreen(),
  );
  setUpAll(() {
    const MethodChannel('plugins.flutter.io/shared_preferences')
        .setMockMethodCallHandler((MethodCall methodCall) async {
      if (methodCall.method == 'getAll') {
        return <String, dynamic>{}; // set initial values here if desired
      }
      return null;
    });
  });
  testWidgets('Check close icon button', (WidgetTester tester) async {
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

  testWidgets("Skip event - detect first launch app",
      (WidgetTester tester) async {
    await tester.wrapAndPump(widget);
    SharedPreferences.setMockInitialValues({});
    TextOnlyButton skipButton = tester.widget(find.ancestor(
        of: find.text("Skip"), matching: find.byType(TextOnlyButton)));
    await tester.tap(find.byWidget(skipButton));
    await tester.pumpAndSettle();
    SharedPreferences pref = await SharedPreferences.getInstance();
    expect(pref.getBool(isFirstLaunchConst), false);
  });
  testWidgets("Close button event - detect first launch app",
      (WidgetTester tester) async {
    await tester.wrapAndPump(widget);
    SharedPreferences.setMockInitialValues({});
    IconButton closeButton = tester.widget(find.byType(IconButton));
    await tester.tap(find.byWidget(closeButton));
    await tester.pumpAndSettle();
    SharedPreferences pref = await SharedPreferences.getInstance();
    expectLater(pref.getBool(isFirstLaunchConst), false);
  });
}
