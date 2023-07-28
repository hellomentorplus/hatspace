import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/data/property_data.dart';
import 'package:hatspace/features/add_property/view_model/add_property_cubit.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'add_property_cubit_test.mocks.dart';

void main() {
  initializeDateFormatting();
  blocTest(
    "Given when user press NEXT button when it's enable, then update Page view navigation, and update next button validation",
    build: () => AddPropertyCubit(),
    act: (bloc) => {bloc.navigatePage(NavigatePage.forward, 2)},
    expect: () => [isA<PageViewNavigationState>(), isA<NextButtonEnable>()],
  );

  blocTest(
    "Given when user press BACK button when it's enable, then update new state",
    build: () => AddPropertyCubit(),
    act: (bloc) {
      bloc.navigatePage(NavigatePage.forward, 2);
      bloc.validateNextButtonState(0);
      bloc.navigatePage(NavigatePage.reverse, 2);
    },
    expect: () => [
      isA<PageViewNavigationState>(),
      isA<NextButtonEnable>(),
      isA<PageViewNavigationState>(),
      isA<NextButtonEnable>()
    ],
  );

  blocTest(
    'Given page is What kind of place, when validate next button, then emit NextButton true',
    build: () => AddPropertyCubit(),
    act: (bloc) {
      bloc.validateNextButtonState(0);
    },
    expect: () => [isA<NextButtonEnable>()],
    verify: (bloc) {
      AddPropertyState state = bloc.state;
      expect(state, isA<NextButtonEnable>());

      NextButtonEnable nextButtonEnable = state as NextButtonEnable;
      expect(nextButtonEnable.isActive, true);
      expect(nextButtonEnable.pageViewNumber, 0);
    },
  );

  blocTest(
    'given page is rooms info, and no room added, when validate next button, then emit NextButton false',
    build: () => AddPropertyCubit(),
    act: (bloc) => bloc.validateNextButtonState(2),
    expect: () => [isA<NextButtonEnable>()],
    verify: (bloc) {
      AddPropertyState state = bloc.state;
      expect(state, isA<NextButtonEnable>());

      NextButtonEnable nextButtonEnable = state as NextButtonEnable;
      expect(nextButtonEnable.isActive, false);
      expect(nextButtonEnable.pageViewNumber, 0);
    },
  );

  blocTest(
    'given page is rooms info, and rooms are added, when validate next button, then emit NextButton false',
    build: () => AddPropertyCubit(),
    act: (bloc) {
      // set rooms number
      bloc.parking = 1;
      bloc.bedrooms = 1;
      bloc.validateNextButtonState(2);
    },
    expect: () => [isA<NextButtonEnable>()],
    verify: (bloc) {
      AddPropertyState state = bloc.state;
      expect(state, isA<NextButtonEnable>());

      NextButtonEnable nextButtonEnable = state as NextButtonEnable;
      expect(nextButtonEnable.isActive, true);
      expect(nextButtonEnable.pageViewNumber, 0);
    },
  );

  blocTest(
    'given page is Feature list, and no feature added, when validate next button, then emit NextButton true by default',
    build: () => AddPropertyCubit(),
    act: (bloc) => bloc.validateNextButtonState(3),
    expect: () => [isA<NextButtonEnable>()],
    verify: (bloc) {
      AddPropertyState state = bloc.state;
      expect(state, isA<NextButtonEnable>());

      NextButtonEnable nextButtonEnable = state as NextButtonEnable;
      expect(nextButtonEnable.isActive, true);
      expect(nextButtonEnable.pageViewNumber, 0);
    },
  );

  blocTest(
    'given page is Feature list, and features are added, when validate next button, then emit NextButton true',
    build: () => AddPropertyCubit(),
    act: (bloc) {
      // set rooms number
      bloc.features = [Feature.securityCameras];
      bloc.validateNextButtonState(3);
    },
    expect: () => [isA<NextButtonEnable>()],
    verify: (bloc) {
      AddPropertyState state = bloc.state;
      expect(state, isA<NextButtonEnable>());

      NextButtonEnable nextButtonEnable = state as NextButtonEnable;
      expect(nextButtonEnable.isActive, true);
      expect(nextButtonEnable.pageViewNumber, 0);
    },
  );

  blocTest<AddPropertyCubit, AddPropertyState>(
    'given current page is 3, when back button pressed, then return to page 2',
    build: () => AddPropertyCubit(),
    act: (bloc) {
      bloc.onBackPressed(4);
    },
    seed: () => const NextButtonEnable(3, true, ButtonLabel.next, true),
    expect: () => [isA<PageViewNavigationState>(), isA<NextButtonEnable>()],
    verify: (bloc) {
      AddPropertyState state = bloc.state;
      expect(state, isA<NextButtonEnable>());

      NextButtonEnable nextButtonEnable = state as NextButtonEnable;
      expect(nextButtonEnable.pageViewNumber, 2);
    },
  );

  group('when set value into cubit, then revalidate current page', () {
    blocTest<AddPropertyCubit, AddPropertyState>(
      'set propertyType',
      build: () => AddPropertyCubit(),
      seed: () => const NextButtonEnable(3, false, ButtonLabel.next, true),
      act: (bloc) => bloc.propertyType = PropertyTypes.house,
      expect: () => [isA<NextButtonEnable>()],
      verify: (bloc) => expect(bloc.propertyType, PropertyTypes.house),
    );

    blocTest<AddPropertyCubit, AddPropertyState>(
      'set availableDate',
      build: () => AddPropertyCubit(),
      seed: () => const NextButtonEnable(3, false, ButtonLabel.next, true),
      act: (bloc) => bloc.availableDate = DateTime.now(),
      expect: () => [isA<NextButtonEnable>()],
    );

    blocTest<AddPropertyCubit, AddPropertyState>(
      'set australiaState',
      build: () => AddPropertyCubit(),
      seed: () => const NextButtonEnable(3, false, ButtonLabel.next, true),
      act: (bloc) => bloc.australiaState = AustraliaStates.nsw,
      expect: () => [isA<NextButtonEnable>()],
      verify: (bloc) => expect(bloc.australiaState, AustraliaStates.nsw),
    );

    blocTest<AddPropertyCubit, AddPropertyState>(
      'set rentPeriod',
      build: () => AddPropertyCubit(),
      seed: () => const NextButtonEnable(3, false, ButtonLabel.next, true),
      act: (bloc) => bloc.rentPeriod = MinimumRentPeriod.sixMonths,
      expect: () => [isA<NextButtonEnable>()],
      verify: (bloc) => expect(bloc.rentPeriod, MinimumRentPeriod.sixMonths),
    );

    blocTest<AddPropertyCubit, AddPropertyState>(
      'set propertyName',
      build: () => AddPropertyCubit(),
      seed: () => const NextButtonEnable(3, false, ButtonLabel.next, true),
      act: (bloc) => bloc.propertyName = 'this is property name',
      expect: () => [isA<NextButtonEnable>()],
      verify: (bloc) => expect(bloc.propertyName, 'this is property name'),
    );

    blocTest<AddPropertyCubit, AddPropertyState>(
      'set price',
      build: () => AddPropertyCubit(),
      seed: () => const NextButtonEnable(3, false, ButtonLabel.next, true),
      act: (bloc) => bloc.price = 1500,
      expect: () => [isA<NextButtonEnable>()],
      verify: (bloc) => expect(bloc.price, 1500),
    );

    blocTest<AddPropertyCubit, AddPropertyState>(
      'set suburb',
      build: () => AddPropertyCubit(),
      seed: () => const NextButtonEnable(3, false, ButtonLabel.next, true),
      act: (bloc) => bloc.suburb = 'suburb',
      expect: () => [isA<NextButtonEnable>()],
      verify: (bloc) => expect(bloc.suburb, 'suburb'),
    );

    blocTest<AddPropertyCubit, AddPropertyState>(
      'set postalCode',
      build: () => AddPropertyCubit(),
      seed: () => const NextButtonEnable(3, false, ButtonLabel.next, true),
      act: (bloc) => bloc.postalCode = 3000,
      expect: () => [isA<NextButtonEnable>()],
      verify: (bloc) => expect(bloc.postalCode, 3000),
    );

    blocTest<AddPropertyCubit, AddPropertyState>(
      'set bedrooms',
      build: () => AddPropertyCubit(),
      seed: () => const NextButtonEnable(3, false, ButtonLabel.next, true),
      act: (bloc) => bloc.bedrooms = 3,
      expect: () => [isA<NextButtonEnable>()],
      verify: (bloc) => expect(bloc.bedrooms, 3),
    );

    blocTest<AddPropertyCubit, AddPropertyState>(
      'set bathrooms',
      build: () => AddPropertyCubit(),
      seed: () => const NextButtonEnable(3, false, ButtonLabel.next, true),
      act: (bloc) => bloc.bathrooms = 3,
      expect: () => [isA<NextButtonEnable>()],
      verify: (bloc) => expect(bloc.bathrooms, 3),
    );

    blocTest<AddPropertyCubit, AddPropertyState>(
      'set parking',
      build: () => AddPropertyCubit(),
      seed: () => const NextButtonEnable(3, false, ButtonLabel.next, true),
      act: (bloc) => bloc.parking = 3,
      expect: () => [isA<NextButtonEnable>()],
      verify: (bloc) => expect(bloc.parking, 3),
    );

    blocTest<AddPropertyCubit, AddPropertyState>(
      'set features',
      build: () => AddPropertyCubit(),
      seed: () => const NextButtonEnable(3, false, ButtonLabel.next, true),
      act: (bloc) => bloc.features = [Feature.fridge, Feature.airConditioners],
      expect: () => [isA<NextButtonEnable>()],
      verify: (bloc) =>
          expect(bloc.features, [Feature.fridge, Feature.airConditioners]),
    );

    blocTest<AddPropertyCubit, AddPropertyState>(
      'given no photos available, when validateNextButtonState, then return NextButtonEnable false',
      build: () => AddPropertyCubit(),
      act: (bloc) => bloc.validateNextButtonState(4),
      expect: () => [isA<NextButtonEnable>()],
      verify: (bloc) {
        NextButtonEnable state = bloc.state as NextButtonEnable;

        expect(state.isActive, false);
        expect(state.btnLabel, ButtonLabel.previewAndSubmit);
      }
    );

    blocTest<AddPropertyCubit, AddPropertyState>(
        'when added photos, then emit NextButtonEnable true',
        build: () => AddPropertyCubit(),
        act: (bloc) => bloc.photos = ['path'],
        expect: () => [isA<NextButtonEnable>()],
        verify: (bloc) {
          NextButtonEnable state = bloc.state as NextButtonEnable;

          expect(state.isActive, isTrue);
        }
    );

    blocTest<AddPropertyCubit, AddPropertyState>(
        'when clear all photos, then emit NextButtonEnable false',
        build: () => AddPropertyCubit(),
        seed: () => const NextButtonEnable(4, true, ButtonLabel.next, true),
        act: (bloc) => bloc.photos = [],
        expect: () => [isA<NextButtonEnable>()],
        verify: (bloc) {
          NextButtonEnable state = bloc.state as NextButtonEnable;

          expect(state.isActive, isFalse);
        }
    );

    group('lost data modal', () {
      blocTest<AddPropertyCubit, AddPropertyState>(
          'show lost data warning modal on screen addPropertyType when user interacted on the screen',
          build: () => AddPropertyCubit(),
          seed: () => const PageViewNavigationState(0),
          act: (bloc) {
            bloc.isAddPropertyFlowInteracted = true;
            bloc.onShowLostDataModal();
          },
          expect: () => [isA<OpenLostDataWarningModal>()]);

      blocTest<AddPropertyCubit, AddPropertyState>(
          'DO NOT show lost data warning modal on screen addPropertyType when user has NOT interacted on the screen',
          build: () => AddPropertyCubit(),
          seed: () => const PageViewNavigationState(0),
          act: (bloc) {
            bloc.onShowLostDataModal();
          },
          expect: () => [isA<ExitAddPropertyFlow>()]);

      blocTest<AddPropertyCubit, AddPropertyState>(
        'show lost data warning modal on screen addPropertyInfo',
        build: () => AddPropertyCubit(),
        seed: () => const PageViewNavigationState(1),
        act: (bloc) => bloc.onShowLostDataModal(),
        expect: () => [isA<OpenLostDataWarningModal>()],
      );

      blocTest<AddPropertyCubit, AddPropertyState>(
        'show lost data warning modal on screen addPropertyFeatures ',
        build: () => AddPropertyCubit(),
        seed: () => const PageViewNavigationState(2),
        act: (bloc) => bloc.onShowLostDataModal(),
        expect: () => [isA<OpenLostDataWarningModal>()],
      );

      blocTest<AddPropertyCubit, AddPropertyState>(
        'show lost data warning modal on screen addPropertyFeatures ',
        build: () => AddPropertyCubit(),
        seed: () => const PageViewNavigationState(3),
        act: (bloc) => bloc.onShowLostDataModal(),
        expect: () => [isA<OpenLostDataWarningModal>()],
      );

      blocTest<AddPropertyCubit, AddPropertyState>(
        'show lost data warning modal on screen addImageScreen ',
        build: () => AddPropertyCubit(),
        seed: () => const PageViewNavigationState(4),
        act: (bloc) => bloc.onShowLostDataModal(),
        expect: () => [isA<OpenLostDataWarningModal>()],
      );

      blocTest<AddPropertyCubit, AddPropertyState>(
        'show lost data warning modal on screen preview property',
        build: () => AddPropertyCubit(),
        seed: () => const PageViewNavigationState(5),
        act: (bloc) => bloc.onShowLostDataModal(),
        expect: () => [isA<OpenLostDataWarningModal>()],
      );

      blocTest<AddPropertyCubit, AddPropertyState>('close modal',
          build: () => AddPropertyCubit(),
          act: (bloc) => bloc.onCloseLostDataModal(),
          expect: () => [isA<NextButtonEnable>()]);

      blocTest<AddPropertyCubit, AddPropertyState>(
          'reset data and exit add property flow',
          build: () => AddPropertyCubit(),
          act: (bloc) => bloc.onResetData(),
          expect: () => [isA<ExitAddPropertyFlow>()]);
    });
  });

  test('test initial state', () {
    AddPropertyInitial addPropertyInitial = const AddPropertyInitial();
    expect(addPropertyInitial.props.length, 0);
  });
}
