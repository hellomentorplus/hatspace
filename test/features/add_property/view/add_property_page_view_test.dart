import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:hatspace/features/add_property/view/add_property_page_view.dart';
import 'package:hatspace/features/add_property/view_model/bloc/add_property_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:intl/date_symbol_data_local.dart';
import '../../../widget_tester_extension.dart';
import 'select_property_type_test.mocks.dart';

@GenerateMocks([
  AddPropertyBloc
])
void main(){
    final MockAddPropertyBloc addPropertyBloc = MockAddPropertyBloc();
      initializeDateFormatting();
      setUp(() {
    when(addPropertyBloc.state)
        .thenAnswer((realInvocation) =>  AddPropertyInitial());
    when(addPropertyBloc.stream)
        .thenAnswer((realInvocation) => Stream.value(AddPropertyInitial()));
  });
    testWidgets('test ui for widget',
      (widgetTester) async {
    Widget widget = AddPropertyPageView();

    await widgetTester.blocWrapAndPump<AddPropertyBloc>(addPropertyBloc, widget);
   // expect(find.byType(BlocSelector<AddPropertyBloc, AddPropertyState,PropertyTypes>), findsOneWidget);
   expect(find.byType(BlocProvider<AddPropertyBloc>),findsWidgets);
  });
} 