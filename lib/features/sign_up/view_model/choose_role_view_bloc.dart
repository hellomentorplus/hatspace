import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatspace/data/data.dart';
import 'package:hatspace/features/sign_up/view_model/choose_role_view_event.dart';
import 'package:hatspace/features/sign_up/view_model/choose_role_view_state.dart';
import 'package:hatspace/models/authentication/authentication_service.dart';
import 'package:hatspace/models/storage/storage_service.dart';
import 'package:hatspace/models/storage/storage_service_exception.dart';
import 'package:hatspace/singleton/hs_singleton.dart';

class ChooseRoleViewBloc
    extends Bloc<ChooseRoleViewEvent, ChooseRoleViewState> {
  final StorageService _storageService;
  final AuthenticationService _authenticationService;
  ChooseRoleViewBloc()
      : _storageService = HsSingleton.singleton.get<StorageService>(),
        _authenticationService =
            HsSingleton.singleton.get<AuthenticationService>(),
        super(ChooseRoleViewInitial()) {
    on<ChooseRoleViewEvent>((event, emit) {
      // TODO: implement event handler
    });

    final Set<Roles> listRoles = {};
    on<OnChangeUserRoleEvent>((event, emit) {
      emit(const StartListenRoleChange());
      if (listRoles.contains(Roles.values[event.position])) {
        listRoles.remove(Roles.values[event.position]);
      } else {
        listRoles.add(Roles.values[event.position]);
      }
      emit(UserRoleSelectedListState(listRoles));
    });

    on<OnSubmitRoleEvent>((event, emit) async {
      List<Roles> listRoles = event.listRoles.toList();
      try {
        UserDetail user = await _authenticationService.getCurrentUser();
        await _storageService.member.saveUserRoles(user.uid, listRoles);
        emit(ChoosingRoleSuccessState());
      } on SaveDataFailureException {
        emit(ChoosingRoleFail());
      }
    });
  }
}
