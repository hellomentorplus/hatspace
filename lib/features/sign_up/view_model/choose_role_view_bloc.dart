import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatspace/data/data.dart';
import 'package:hatspace/features/sign_up/view_model/choose_role_view_event.dart';
import 'package:hatspace/features/sign_up/view_model/choose_role_view_state.dart';

class ChooseRoleViewBloc
    extends Bloc<ChooseRoleViewEvent, ChooseRoleViewState> {
  ChooseRoleViewBloc() : super(ChooseRoleViewInitial()) {
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
      print(listRoles);
      emit(UserRoleSelectedListState(listRoles));
    });
  }
}
