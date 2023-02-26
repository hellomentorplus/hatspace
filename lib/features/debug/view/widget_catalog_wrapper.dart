import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatspace/features/debug/view/widget_catalog.dart';
import 'package:hatspace/features/debug/view_model/bloc/widget_catalog_bloc.dart';

class WidgetCatalogWrapper extends StatelessWidget {
  const WidgetCatalogWrapper({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider<WidgetCatalogBloc>(
      create: (context) {
        return WidgetCatalogBloc();
      },
      child: WidgetCatalogScreen(),
    );
  }
}
