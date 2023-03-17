import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:hatspace/features/sign_up/view/sign_up_view.dart';
import 'package:hatspace/features/sign_up/view_model/sign_up_bloc.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../widget_tester_extension.dart';
import 'sign_up_view_test.mocks.dart';

@GenerateMocks([SignUpBloc])
void main() {
  final MockSignUpBloc signUpBloc = MockSignUpBloc();

  setUp(() {
    when(signUpBloc.state).thenAnswer((realInvocation) => SignUpInitial());
    when(signUpBloc.stream).thenAnswer((realInvocation) => Stream.value(SignUpInitial()));
  });

  testWidgets('verify that SignUpView listen to changes from SignUpBloc', (widgetTester) async {
    const Widget widget = SignUpScreen();

    await widgetTester.blocWrapAndPump<SignUpBloc>(signUpBloc, widget);

    expect(find.byType(BlocListener<SignUpBloc, SignUpState>), findsOneWidget);
  });

  testWidgets('verify UI components', (widgetTester) async {
    const Widget widget = SignUpScreen();

    await widgetTester.blocWrapAndPump<SignUpBloc>(signUpBloc, widget);

    expect(find.byType(AppBar), findsOneWidget);

    AppBar appBar = widgetTester.widget(find.byType(AppBar));
    expect(appBar.backgroundColor, const Color(0xFFF8F8F8));

    expect(find.descendant(of: find.byType(AppBar), matching: find.byType(SvgPicture)), findsOneWidget);
    SvgPicture svgPicture = widgetTester.widget(find.descendant(of: find.byType(AppBar), matching: find.byType(SvgPicture)));
    expect(svgPicture.pictureProvider, isA<ExactAssetPicture>());
    ExactAssetPicture assetPicture = svgPicture.pictureProvider as ExactAssetPicture;
    expect(assetPicture.assetName, 'assets/images/close_icon.svg');

    expect(find.widgetWithText(SecondaryButton, 'Sign up with Google'), findsOneWidget);
    expect(find.widgetWithText(SecondaryButton, 'Sign up with Facebook'), findsOneWidget);
    expect(find.widgetWithText(SecondaryButton, 'Sign up with email'), findsOneWidget);
    expect(find.widgetWithText(TextOnlyButton, 'Skip'), findsOneWidget);
  });
}