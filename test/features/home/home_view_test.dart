import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:hatspace/features/home/view/home_view.dart';
import 'package:hatspace/view_models/app_config/bloc/app_config_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../widget_tester_extension.dart';
import 'home_view_test.mocks.dart';

@GenerateMocks([AppConfigBloc])
void main() {
  final MockAppConfigBloc appConfigBloc = MockAppConfigBloc();

  setUp(() {
    when(appConfigBloc.stream).thenAnswer(
        (realInvocation) => Stream.value(const AppConfigInitialState()));
    when(appConfigBloc.state).thenReturn(const AppConfigInitialState());
  });

  testWidgets('verify home view listen to changes on BlocListener',
      (widgetTester) async {
    const Widget widget = HomePageView();

    await widgetTester.blocWrapAndPump<AppConfigBloc>(appConfigBloc, widget);

    expect(find.byType(BlocListener<AppConfigBloc, AppConfigState>),
        findsOneWidget);
  });

  testWidgets('verify UI components', (widgetTester) async {
    const Widget widget = HomePageView();

    await widgetTester.blocWrapAndPump<AppConfigBloc>(appConfigBloc, widget);

    expect(find.byType(AppBar), findsOneWidget);
    expect(find.text('HAT Space'), findsOneWidget);
    expect(find.byType(BottomNavigationBar), findsOneWidget);
  });
}
