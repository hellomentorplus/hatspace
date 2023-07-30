import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hatspace/data/data.dart';
import 'package:hatspace/models/authentication/authentication_service.dart';
import 'package:hatspace/models/storage/storage_service.dart';
import 'package:hatspace/singleton/hs_singleton.dart';
import 'package:hatspace/models/authentication/authentication_exception.dart';

part 'add_home_owner_role_state.dart';

class AddHomeOwnerRoleCubit extends Cubit<AddHomeOwnerRoleState> {
  AddHomeOwnerRoleCubit() : super(AddHomeOwnerRoleInitial());

  final AuthenticationService _authenticationService =
      HsSingleton.singleton.get<AuthenticationService>();
  final StorageService _storageService =
      HsSingleton.singleton.get<StorageService>();

  void addHomeOwnerRole() async {
    try {
      final UserDetail userDetail =
          await _authenticationService.getCurrentUser();

      final List<Roles> currentRoles =
          await _storageService.member.getUserRoles(userDetail.uid);

      currentRoles.add(Roles.homeowner);
      await _storageService.member
          .saveUserRoles(userDetail.uid, currentRoles.toSet());

      emit(AddHomeOwnerRoleSucceeded());
    } on UserNotFoundException catch (_) {
      // TODO handle error when user sign out during this call
      emit(AddHomeOwnerRoleError());
    } catch (_) {
      emit(AddHomeOwnerRoleError());
    }
  }
}
