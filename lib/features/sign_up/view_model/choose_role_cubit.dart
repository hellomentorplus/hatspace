import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatspace/data/data.dart';
import 'package:hatspace/models/authentication/authentication_service.dart';
import 'package:hatspace/models/storage/storage_service.dart';
import 'package:hatspace/singleton/hs_singleton.dart';
import 'package:equatable/equatable.dart';

part 'choose_role_state.dart';

class ChooseRoleCubit extends Cubit<ChooseRoleState> {
  final StorageService _storageService =
      HsSingleton.singleton.get<StorageService>();
  final AuthenticationService _authenticationService =
      HsSingleton.singleton.get<AuthenticationService>();
  final Set<Roles> listRoles = {};

  ChooseRoleCubit() : super(const ChoosingRoleState());

  void changeRole(Roles role) {
    if (listRoles.contains(role)) {
      listRoles.remove(role);
    } else {
      listRoles.add(role);
    }
    emit(ChoosingRoleState(roles: Set.from(listRoles)));
  }

  Future<void> submitUserRoles() async {
    try {
      emit(const SubmittingRoleState());
      UserDetail user = await _authenticationService.getCurrentUser();
      await _storageService.member.saveUserRoles(user.uid, listRoles);
      emit(const SubmitRoleSucceedState());
    } catch (_) {
      emit(const SubmitRoleFailedState());
    }
  }
}
