import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/features/sign_up/view_model/choosing_role_view/choosing_role_view_bloc.dart';

void main() {
  group("Test choose role bloc", () {
    setUpAll(() {});

    blocTest<ChoosingRoleViewBloc, ChoosingRoleViewState>(
        "Given user select tenant role, then return state with user list have tenant role ",
        build: () => ChoosingRoleViewBloc(),
        act: (bloc) => bloc.add(const OnChangeUserRoleEvent(1)),
        expect: () =>
            [isA<StartListenRoleChange>(), isA<UserRoleSelectedListState>()]);
    test("initial test", () {
      expect(ChoosingRoleViewBloc().state, ChoosingRoleViewInitial());
    });

    test("test bloc initail", () {
      StartListenRoleChange startListenRoleChange =
          const StartListenRoleChange();
      expect(startListenRoleChange.props.length, 0);

      UserRoleSelectedListState userRoleSelectedChange =
          const UserRoleSelectedListState([]);
      expect(userRoleSelectedChange.props.length, 0);

      OnChangeUserRoleEvent onChangeUserRoleEvent =
          const OnChangeUserRoleEvent(0);
      expect(onChangeUserRoleEvent.props.length, 0);
    });
  });
}
