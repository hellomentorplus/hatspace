import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/data/property_data.dart';
import 'package:hatspace/features/add_property/view/widgets/add_property_info_view/add_property_state_view.dart';
import 'package:hatspace/features/add_property/view/widgets/add_property_info_view/add_property_minimum_rent_view.dart';
import 'package:hatspace/features/add_property/view/widgets/add_property_info_view/add_property_info_form_view.dart';
import 'package:hatspace/features/add_property/view_model/add_property_cubit.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';
import 'package:hatspace/theme/widgets/hs_modal_selection_view.dart';
import 'package:hatspace/theme/widgets/hs_modal_view.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../../../widget_tester_extension.dart';
import '../add_property_screen_test.mocks.dart';

@GenerateMocks([AddPropertyCubit])
void main() {
  final MockAddPropertyCubit addPropertyCubit = MockAddPropertyCubit();

  testWidgets('Test AddPropertyView UI', (WidgetTester widgetTester) async {
    await HatSpaceStrings.load(const Locale.fromSubtags(languageCode: 'en'));
    Widget propertyInfoForm = AddPropertyInfoFormView();
    await widgetTester.wrapAndPump(propertyInfoForm);
    Text header = widgetTester.widget(find.text('Information'));
    expect(header.style, textTheme.displayLarge);

    Text addressHeader = widgetTester.widget(find.text('Your address'));
    expect(
        addressHeader.style, textTheme.displayLarge?.copyWith(fontSize: 18.0));
  });

  group('Select State and Minimum rent period interaciton', () {
    setUp(() {
      when(addPropertyCubit.stream).thenAnswer(
          (realInvocation) => Stream.value(const AddPropertyInitial()));
      when(addPropertyCubit.state)
          .thenAnswer((realInvocation) => const AddPropertyInitial());

      when(addPropertyCubit.australiaState).thenReturn(AustraliaStates.invalid);
      when(addPropertyCubit.rentPeriod).thenReturn(MinimumRentPeriod.invalid);
    });

    tearDown(() {
      reset(addPropertyCubit);
    });
    testWidgets(
        'Given when user taps on select state button, then shows the HsModalView with AustraliaState',
        (WidgetTester widgetTester) async {
      Widget addPropertyStateView = AddPropertyStateView();
      await widgetTester.blocWrapAndPump<AddPropertyCubit>(
          addPropertyCubit, addPropertyStateView);
      expect(
          find.byType(HsModalSelectionView<AustraliaStates>), findsOneWidget);

      // on tap value to display HsModalView
      await widgetTester.tap(find.byType(HsDropDownButton));
      await widgetTester.pump();
      expect(find.byType(HsModalView<AustraliaStates>), findsOneWidget);
    });
    testWidgets(
        'Given when user taps on select minimum button, then shows the HsModalView with Minimum Rent Period',
        (WidgetTester widgetTester) async {
      Widget minimumRentPeriod = AddPropertyMinimumRentView();
      await widgetTester.blocWrapAndPump<AddPropertyCubit>(
          addPropertyCubit, minimumRentPeriod);
      expect(
          find.byType(HsModalSelectionView<MinimumRentPeriod>), findsOneWidget);

      // on tap value to display HsModalView
      await widgetTester.tap(find.byType(HsDropDownButton));
      await widgetTester.pump();
      expect(find.byType(HsModalView<MinimumRentPeriod>), findsOneWidget);
    });
  });
}
