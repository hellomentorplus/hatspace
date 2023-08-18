import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatspace/data/data.dart';
import 'package:hatspace/models/authentication/authentication_service.dart';
import 'package:hatspace/models/storage/storage_service.dart';
import 'package:hatspace/singleton/hs_singleton.dart';
import 'package:equatable/equatable.dart';

part 'choose_roles_state.dart';

class ChooseRolesCubit extends Cubit<ChooseRolesState> {
  final StorageService _storageService =
      HsSingleton.singleton.get<StorageService>();
  final AuthenticationService _authenticationService =
      HsSingleton.singleton.get<AuthenticationService>();
  final Set<Roles> listRoles = {};

  ChooseRolesCubit() : super(const ChoosingRolesState());

  void changeRole(Roles role) {
    if (listRoles.contains(role)) {
      listRoles.remove(role);
    } else {
      listRoles.add(role);
    }
    emit(ChoosingRolesState(roles: Set.from(listRoles)));
  }

  void onCancelRole() {
    _authenticationService.signOut();
  }

  Future<void> submitUserRoles() async {
    try {
      emit(const SubmittingRoleState());
      UserDetail user = await _authenticationService.getCurrentUser();
      await _storageService.member
          .saveUserRoles(user.uid, listRoles);
      emit(const SubmitRoleSucceedState());
    } catch (e) {
      emit(const SubmitRoleFailedState());
    }
  }
}
