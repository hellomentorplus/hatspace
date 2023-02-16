import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hatspace/strings/intl/messages_en.dart';
import 'package:shake/shake.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  late ShakeDetector detector;

  HomeBloc() : super(HomeInitial()) {
    on<HomeEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<ShowWidgetCatalogEvent>(((event, emit) {
      try {
        emit(const ShowWidgetCatalogState(true));
      } catch (e) {}
    }));
  }
}
