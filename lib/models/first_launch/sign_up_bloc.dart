import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class FirstLaunchBloc extends Bloc<FirstLaunchEvent, FirstLaunchAppState> {
  FirstLaunchBloc() : super(FirstLaunchAppInitState()) {
    on<FirstLoad>((event, emit) async {
      bool? isFirstLaunch;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      isFirstLaunch = prefs.getBool("isFirstLaunch");
      if (isFirstLaunch == null) {
        await prefs.setBool("isFirstLaunch", true);
        emit(ShowFirstSignUp());
      } else {
        emit(ShowHomeView());
      }
    });
  }
}
