import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/data/data.dart';
import 'package:hatspace/features/add_property/view/date_picker_view.dart';
import 'package:hatspace/features/add_property/view/select_property_type.dart';
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
    testWidgets('verify that on press button to show calendar',
      (widgetTester) async {
    const Widget widget = DatePickerView();
    await widgetTester.blocWrapAndPump<AddPropertyBloc>(addPropertyBloc, widget);
    OutlinedButton btn = widgetTester.widget(find.byType(OutlinedButton));
    await widgetTester.tap(find.byType(OutlinedButton));
     await widgetTester.pump();
       Dialog dialog = widgetTester.widget(find.byType(Dialog));
    expect(find.byType(Dialog), findsOneWidget );
  });
} 