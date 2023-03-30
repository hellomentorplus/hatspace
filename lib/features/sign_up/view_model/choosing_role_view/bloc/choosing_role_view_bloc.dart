import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hatspace/data/data.dart';

part 'choosing_role_view_event.dart';
part 'choosing_role_view_state.dart';

class ChoosingRoleViewBloc
    extends Bloc<ChoosingRoleViewEvent, ChoosingRoleViewState> {
  ChoosingRoleViewBloc() : super(ChoosingRoleViewInitial()) {
    on<ChoosingRoleViewEvent>((event, emit) {
      // TODO: implement event handler
    });

    final List<Roles> listRoles = [];
    on<OnChangeUserRoleEvent>((event, emit) {
      emit(const StartListenRoleChange());
      if (listRoles.contains(Roles.values[event.position])) {
        listRoles.remove(Roles.values[event.position]);
      } else {
        listRoles.add(Roles.values[event.position]);
      }
      emit(UserRoleSelectedListState(listRoles));
    });
  }
}
