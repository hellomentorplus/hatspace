import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_interaction_state.dart';

class HomeInteractionCubit extends Cubit<HomeInteractionState> {
  HomeInteractionCubit() : super(HomeInitial());

  void onAddPropertyPressed() {
  }
}
