import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:hatspace/data/data.dart';
import 'package:hatspace/data/property_data.dart';
import 'package:hatspace/features/home/data/property_item_data.dart';
import 'package:hatspace/features/home/view/home_view.dart';
import 'package:hatspace/features/home/view/widgets/property_item_view.dart';
import 'package:hatspace/features/home/view_model/get_properties_cubit.dart';
import 'package:hatspace/features/home/view_model/home_interaction_cubit.dart';
import 'package:hatspace/models/authentication/authentication_service.dart';
import 'package:hatspace/models/storage/member_service/property_storage_service.dart';
import 'package:hatspace/models/storage/storage_service.dart';
import 'package:hatspace/singleton/hs_singleton.dart';
import 'package:hatspace/view_models/app_config/bloc/app_config_bloc.dart';
import 'package:hatspace/view_models/authentication/authentication_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../widget_tester_extension.dart';
import 'home_view_test.mocks.dart';

@GenerateMocks([
  AppConfigBloc,
  StorageService,
  AuthenticationService,
  AuthenticationBloc,
  PropertyService,
  GetPropertiesCubit,
  HomeInteractionCubit
])
void main() {
  initializeDateFormatting();
  final MockAppConfigBloc appConfigBloc = MockAppConfigBloc();
  final MockStorageService storageService = MockStorageService();
  final MockAuthenticationService authenticationService =
      MockAuthenticationService();
  final MockAuthenticationBloc authenticationBloc = MockAuthenticationBloc();
  final MockPropertyService propertyService = MockPropertyService();
  final MockGetPropertiesCubit getPropertiesCubit = MockGetPropertiesCubit();
  final MockHomeInteractionCubit interactionCubit = MockHomeInteractionCubit();
  late final List<BlocProvider<StateStreamableSource<Object?>>>
      requiredHomeBlocs;

  setUpAll(() {
    HsSingleton.singleton.registerSingleton<StorageService>(storageService);
    HsSingleton.singleton
        .registerSingleton<AuthenticationService>(authenticationService);
    requiredHomeBlocs = [
      BlocProvider<GetPropertiesCubit>(
        create: (context) => getPropertiesCubit,
      ),
      BlocProvider<AuthenticationBloc>(
        create: (context) => authenticationBloc,
      ),
      BlocProvider<HomeInteractionCubit>(
        create: (context) => interactionCubit,
      ),
      BlocProvider<AppConfigBloc>(
        create: (context) => appConfigBloc,
      ),
    ];
  });

  setUp(() {
    when(appConfigBloc.stream).thenAnswer(
        (realInvocation) => Stream.value(const AppConfigInitialState()));
    when(appConfigBloc.state).thenReturn(const AppConfigInitialState());
    when(storageService.property).thenReturn(propertyService);
  });

  group(
    'user not login',
    () {
      setUp(() {
        when(authenticationBloc.state)
            .thenAnswer((realInvocation) => AnonymousState());
        when(authenticationBloc.stream)
            .thenAnswer((realInvocation) => Stream.value(AnonymousState()));
      });

      tearDown(() {
        reset(authenticationBloc);
        reset(appConfigBloc);
      });

      testWidgets('verify home view listen to changes on BlocListener',
          (widgetTester) async {
        const Widget widget = HomePageView();

        await widgetTester.multiBlocWrapAndPump([
          BlocProvider<AppConfigBloc>(
            create: (context) => appConfigBloc,
          ),
          BlocProvider<AuthenticationBloc>(
            create: (context) => authenticationBloc,
          )
        ], widget);

        expect(find.byType(BlocListener<AppConfigBloc, AppConfigState>),
            findsOneWidget);
      });

      testWidgets('verify UI components', (widgetTester) async {
        const Widget widget = HomePageView();

        await widgetTester.multiBlocWrapAndPump([
          BlocProvider<AppConfigBloc>(
            create: (context) => appConfigBloc,
          ),
          BlocProvider<AuthenticationBloc>(
            create: (context) => authenticationBloc,
          )
        ], widget);
        expect(find.byType(AppBar), findsOneWidget);
        expect(find.text('Hi there 👋'), findsOneWidget);
        expect(find.text('Search rental, location...'), findsOneWidget);
        expect(find.byType(BottomAppBar), findsOneWidget);
      });
    },
  );

  group('user login', () {
    setUp(() {
      final UserDetail userDetail =
          UserDetail(uid: 'uid', displayName: 'displayName');
      when(authenticationBloc.state)
          .thenAnswer((realInvocation) => AuthenticatedState(userDetail));
      when(authenticationBloc.stream).thenAnswer(
          (realInvocation) => Stream.value(AuthenticatedState(userDetail)));
    });

    tearDown(() {
      reset(authenticationBloc);
      reset(appConfigBloc);
    });

    testWidgets('verify UI components', (widgetTester) async {
      const Widget widget = HomePageView();

      await widgetTester.multiBlocWrapAndPump([
        BlocProvider<AppConfigBloc>(
          create: (context) => appConfigBloc,
        ),
        BlocProvider<AuthenticationBloc>(
          create: (context) => authenticationBloc,
        )
      ], widget);
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text('👋 Hi displayName'), findsOneWidget);
      expect(find.text('Search rental, location...'), findsOneWidget);
      expect(find.byType(BottomAppBar), findsOneWidget);
    });
  });

  group('[Properties] Property list', () {
    /// Set up other blocs/cubits that don't related to property list
    setUpAll(() {
      when(interactionCubit.stream)
          .thenAnswer((_) => Stream.value(HomeInitial()));
      when(interactionCubit.state).thenReturn(HomeInitial());

      when(authenticationBloc.stream)
          .thenAnswer((_) => Stream.value(AnonymousState()));
      when(authenticationBloc.state).thenReturn(AnonymousState());

      when(appConfigBloc.stream).thenAnswer(
          (realInvocation) => Stream.value(const AppConfigInitialState()));
      when(appConfigBloc.state).thenReturn(const AppConfigInitialState());
    });
    testWidgets(
        'Given cubit state is initial'
        'When user firstly goes to home screen'
        'Then user does not see list of property', (widgetTester) async {
      when(getPropertiesCubit.stream)
          .thenAnswer((_) => Stream.value(const GetPropertiesInitialState()));
      when(getPropertiesCubit.state)
          .thenAnswer((_) => const GetPropertiesInitialState());

      const Widget home = HomePageBody();
      await widgetTester.multiBlocWrapAndPump(requiredHomeBlocs, home);
      await widgetTester.pumpAndSettle();
      expect(find.byType(ListView), findsNothing);
    });

    testWidgets(
        'Given cubit state is loading'
        'When user firstly goes to home screen'
        'Then user does not see list of property', (widgetTester) async {
      when(getPropertiesCubit.stream).thenAnswer(
          (_) => Stream.value(const GetPropertiesFailedState('error')));
      when(getPropertiesCubit.state)
          .thenAnswer((_) => const GetPropertiesFailedState('error'));

      const Widget home = HomePageBody();
      await widgetTester.multiBlocWrapAndPump(requiredHomeBlocs, home);
      await widgetTester.pumpAndSettle();
      expect(find.byType(ListView), findsNothing);
    });

    testWidgets(
        'Given cubit state is success but does not have data'
        'When user firstly goes to home screen'
        'Then user does not see list of property', (widgetTester) async {
      when(getPropertiesCubit.stream)
          .thenAnswer((_) => Stream.value(const GetPropertiesSucceedState([])));
      when(getPropertiesCubit.state)
          .thenAnswer((_) => const GetPropertiesSucceedState([]));

      const Widget home = HomePageBody();
      await widgetTester.multiBlocWrapAndPump(requiredHomeBlocs, home);
      await widgetTester.pumpAndSettle();
      expect(find.byType(ListView), findsNothing);
    });

    testWidgets(
        'Given cubit state is success and have data'
        'When user firstly goes to home screen'
        'Then user will see list of property', (widgetTester) async {
      final List<PropertyItemData> fakeData = [
        PropertyItemData(
            id: 'id',
            photos: const ['1', '2'],
            price: 280.0,
            name: 'name',
            state: 'state',
            type: PropertyTypes.apartment,
            numberOfBedrooms: 1,
            numberOfBathrooms: 1,
            numberOfParkings: 1,
            numberOfViewsToday: 20,
            availableDate: DateTime(2023, 1, 1),
            ownerAvatar: '1',
            ownerName: 'name',
            isFavorited: true, 
            currency: Currency.aud),
        PropertyItemData(
            id: 'id 1',
            photos: const ['1', '2'],
            price: 270.0,
            name: 'name 1',
            state: 'state 1',
            type: PropertyTypes.apartment,
            numberOfBedrooms: 1,
            numberOfBathrooms: 1,
            numberOfParkings: 1,
            numberOfViewsToday: 20,
            availableDate: DateTime(2023, 1, 2),
            ownerAvatar: '1',
            ownerName: 'name',
            isFavorited: true,
            currency: Currency.aud),
      ];
      when(getPropertiesCubit.stream).thenAnswer(
          (_) => Stream.value(GetPropertiesSucceedState(fakeData)));
      when(getPropertiesCubit.state)
          .thenAnswer((_) => GetPropertiesSucceedState(fakeData));

      const HomePageBody home = HomePageBody();
      await mockNetworkImagesFor(
          () => widgetTester.multiBlocWrapAndPump(requiredHomeBlocs, home));
      await widgetTester.pumpAndSettle();

      final Finder propertiesListViewFinder = find.byType(ListView);
      expect(propertiesListViewFinder, findsOneWidget);

      final PropertyItemView propertyWidget1 =
          widgetTester.widget(find.byKey(ValueKey(fakeData.first.id)));
      expect(propertyWidget1.property.id, fakeData.first.id);

      await widgetTester.drag(propertiesListViewFinder, const Offset(0, -300));
      await widgetTester.pump();

      final PropertyItemView propertyWidget2 =
          widgetTester.widget(find.byKey(ValueKey(fakeData[1].id)));
      expect(propertyWidget2.property.id, fakeData[1].id);
    });
  });
}
