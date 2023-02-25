import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'widget_catalog_event.dart';
part 'widget_catalog_state.dart';

class WidgetCatalogBloc extends Bloc<WidgetCatalogEvent, WidgetCatalogState> {
  WidgetCatalogBloc() : super(WidgetCatalogInitial()) {
    on<WidgetCatalogEvent>((event, emit) {
      // TODO: implement event handler
    });
  }

  
}
