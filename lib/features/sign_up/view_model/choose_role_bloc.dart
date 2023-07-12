import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatspace/data/data.dart';
import 'package:hatspace/models/authentication/authentication_service.dart';
import 'package:hatspace/models/storage/storage_service.dart';
import 'package:hatspace/singleton/hs_singleton.dart';
import 'package:equatable/equatable.dart';

part 'choose_role_event.dart';
part 'choose_role_state.dart';

class ChooseRoleBloc
    extends Bloc<ChooseRoleEvent, ChooseRoleState> {
  final StorageService _storageService;
  final AuthenticationService _authenticationService;

  ChooseRoleBloc()
      : _storageService = HsSingleton.singleton.get<StorageService>(),
        _authenticationService =
            HsSingleton.singleton.get<AuthenticationService>(),
        super(const ChoosingRoleState()) {
    final Set<Roles> listRoles = {};
    on<ChangeRoleEvent>((event, emit) {
      if (listRoles.contains(event.role)) {
        listRoles.remove(event.role);
      } else {
        listRoles.add(event.role);
      }
      emit(ChoosingRoleState(roles: Set.from(listRoles)));
    });

    on<SubmitRoleEvent>((event, emit) async {
      try {
        emit(const SubmittingRoleState());
        UserDetail user = await _authenticationService.getCurrentUser();
        await _storageService.member.saveUserRoles(user.uid, listRoles);
        emit(const SubmitRoleSucceedState());
      } catch (_) {
        emit(const SubmitRoleFailedState());
      }
    });
  }
}

