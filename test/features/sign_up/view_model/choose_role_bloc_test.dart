import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/features/sign_up/view_model/choose_role_view_bloc.dart';
import 'package:hatspace/features/sign_up/view_model/choose_role_view_event.dart';
import 'package:hatspace/features/sign_up/view_model/choose_role_view_state.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group("Test choose role bloc", () {
    setUpAll(() {});

    blocTest<ChooseRoleViewBloc, ChooseRoleViewState>(
        "Given user select tenant role, then return state with user list have tenant role ",
        build: () => ChooseRoleViewBloc(),
        act: (bloc) {
          int position = 1;
          bloc.add(OnChangeUserRoleEvent(position));
        },
        expect: () =>
            [isA<StartListenRoleChange>(), isA<UserRoleSelectedListState>()]);
    test("initial test", () {
      expect(ChooseRoleViewBloc().state, ChooseRoleViewInitial());
    });

    test("test bloc initail", () {
      StartListenRoleChange startListenRoleChange =
          const StartListenRoleChange();
      expect(startListenRoleChange.props.length, 0);

      UserRoleSelectedListState userRoleSelectedChange =
          const UserRoleSelectedListState({});
      expect(userRoleSelectedChange.props.length, 0);

      OnChangeUserRoleEvent onChangeUserRoleEvent =
          const OnChangeUserRoleEvent(0);
      expect(onChangeUserRoleEvent.props.length, 0);
      
    });
  });
}
