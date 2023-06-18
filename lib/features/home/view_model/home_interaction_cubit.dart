import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hatspace/data/data.dart';
import 'package:hatspace/models/authentication/authentication_exception.dart';
import 'package:hatspace/models/authentication/authentication_service.dart';
import 'package:hatspace/models/storage/storage_service.dart';
import 'package:hatspace/singleton/hs_singleton.dart';

part 'home_interaction_state.dart';

class HomeInteractionCubit extends Cubit<HomeInteractionState> {
  HomeInteractionCubit() : super(HomeInitial());

  final StorageService storageService =
      HsSingleton.singleton.get<StorageService>();
  final AuthenticationService authenticationService =
      HsSingleton.singleton.get<AuthenticationService>();

  void onAddPropertyPressed() async {
    emit(StartValidateRole());
    try {
      final UserDetail detail = await authenticationService.getCurrentUser();

      final List<Roles> roles =
          await storageService.member.getUserRoles(detail.uid);

      if (!isClosed) {
        if (roles.contains(Roles.homeowner)) {
          emit(StartAddPropertyFlow());
        } else {
          // TODO handle when user is not a homeowner
          emit(ShowModalLogin());
        }
      }
    } on UserNotFoundException catch (_) {
      // TODO handle case when user is not login
    }
  }
}
