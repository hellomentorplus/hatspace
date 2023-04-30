import 'dart:math';

import 'package:bloc_test/bloc_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/data/data.dart';
import 'package:hatspace/features/sign_up/view_model/choose_role_view_bloc.dart';
import 'package:hatspace/features/sign_up/view_model/choose_role_view_event.dart';
import 'package:hatspace/features/sign_up/view_model/choose_role_view_state.dart';
import 'package:hatspace/models/authentication/authentication_service.dart';
import 'package:hatspace/models/storage/member_service/member_storage_service.dart';
import 'package:hatspace/models/storage/storage_service.dart';
import 'package:hatspace/models/storage/storage_service_exception.dart';
import 'package:hatspace/singleton/hs_singleton.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'choose_role_bloc_test.mocks.dart';

@GenerateMocks([
  AuthenticationService,
  StorageService,
  FirebaseFirestore,
  MemberService,
  UserDetail
])
void main() {
  final MockAuthenticationService authenticationService =
      MockAuthenticationService();
  final MockStorageService storageServiceMock = MockStorageService();
  final MockMemberService memberService = MockMemberService();
  final MockUserDetail mockUserDetail = MockUserDetail();
  TestWidgetsFlutterBinding.ensureInitialized();
  group("Test choose role bloc", () {
    setUpAll(() {
      HsSingleton.singleton
          .registerSingleton<AuthenticationService>(authenticationService);
      HsSingleton.singleton
          .registerSingleton<StorageService>(storageServiceMock);
    });

    blocTest<ChooseRoleViewBloc, ChooseRoleViewState>(
        "Given user select tenant role, then return state with user list have tenant role ",
        build: () => ChooseRoleViewBloc(),
        act: (bloc) {
          int position = 1;
          bloc.add(OnChangeUserRoleEvent(position));
        },
        expect: () =>
            [isA<StartListenRoleChange>(), isA<UserRoleSelectedListState>()]);
    group("Test uploading user roles", (){
      blocTest<ChooseRoleViewBloc, ChooseRoleViewState>(
          "Given when user select role and submit, then return to succes state",
          build: () => ChooseRoleViewBloc(),
          setUp: () {
            when(authenticationService.getCurrentUser())
                .thenAnswer((realInvocation) {
              return Future<UserDetail>.value(mockUserDetail);
            });
            when(storageServiceMock.member).thenAnswer((realInvocation) {
              return memberService;
            });
            when(mockUserDetail.uid).thenReturn('uid');
            when(memberService.saveUserRoles(mockUserDetail.uid, any))
                .thenAnswer((realInvocation) => Future<void>.value());
          },
          act: (bloc) {
            bloc.add(const OnSubmitRoleEvent({Roles.tenant}));
          },
          expect: () => [isA<ChoosingRoleSuccessState>()]);

      blocTest("Given when user select role and submit, when user id is invalid, then return unsuccessful state", 
      build: ()=>ChooseRoleViewBloc(),
      setUp: (){
          when(authenticationService.getCurrentUser())
                .thenAnswer((realInvocation) {
              return Future<UserDetail>.value(mockUserDetail);
            });
            when(storageServiceMock.member).thenAnswer((realInvocation) {
              return memberService;
            });
            when(mockUserDetail.uid).thenThrow(SaveDataFailureException("code", "message"));
            when(memberService.saveUserRoles(mockUserDetail.uid, any))
                .thenAnswer((realInvocation) => Future<void>.value());
      },
      act: (bloc) => bloc.add(const OnSubmitRoleEvent({Roles.tenant})),
      expect: ()=> [isA<ChoosingRoleFail>()]
      );
    });

    test("initial test", () {
      expect(ChooseRoleViewBloc().state, ChooseRoleViewInitial());
    });

    test("test bloc initail", () {
      StartListenRoleChange startListenRoleChange =
          const StartListenRoleChange();
      expect(startListenRoleChange.props.length, 0);

      UserRoleSelectedListState userRoleSelectedChange =
          const UserRoleSelectedListState({});
      expect(userRoleSelectedChange.props.length, 1);

      OnChangeUserRoleEvent onChangeUserRoleEvent =
          const OnChangeUserRoleEvent(0);
      expect(onChangeUserRoleEvent.props.length, 1);
      OnSubmitRoleEvent onSubmitRoleEvent = const OnSubmitRoleEvent({Roles.tenant});
      expect(onSubmitRoleEvent.listRoles.length,1 );
    });
  });
}
