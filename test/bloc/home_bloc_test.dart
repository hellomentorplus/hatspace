import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/features/home/view/home_view.dart';
import 'package:hatspace/features/home/view_model/bloc/home_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../widget_tester_extension.dart';

@GenerateMocks([HomePageView, HomeBloc])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  Widget TestHomeView() {
    return BlocProvider<HomeBloc>(
      create: ((context) => HomeBloc()),
      child: HomePageView(),
    );
  }

  group(
    "Sign_up_bloc test state",
    () {
      late HomeBloc homeBloc;
      setUpAll(() {
        homeBloc = HomeBloc();
      });
      test("initial test", () {
        expect(HomeBloc().state, HomeInitial());
      });
      blocTest<HomeBloc, HomeState>(
          "widget catalog will be displayed when ShowWidgetCatalogState is TRUE",
          build: () => HomeBloc(),
          act: ((bloc) {
            bloc.add(const ShowWidgetCatalogEvent());
          }),
          expect: () {
            return [const ShowWidgetCatalogState(true)];
          });
      tearDown(() {
        homeBloc.close();
      });
    },
  );
}
