import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hatspace/data/data.dart';
import 'package:hatspace/models/authentication/authentication_service.dart';
import 'package:hatspace/models/storage/storage_service.dart';
import 'package:hatspace/singleton/hs_singleton.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../models/authentication/authentication_exception.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

const isFirstLaunchConst = "isFirstLaunch";

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthenticationService _authenticationService;
  final StorageService _storageService;
  UserDetail user;
  // final MemberService _memberService;
  SignUpBloc()
      : _authenticationService =
            HsSingleton.singleton.get<AuthenticationService>(),
        _storageService = HsSingleton.singleton.get<StorageService>(),
        user = UserDetail(uid: "initial"),
        // _memberService = StorageService().member ,
        super(const SignUpInitial()) {
    on<CheckFirstLaunchSignUp>((event, emit) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool? isLaunchFirstTime = prefs.getBool(isFirstLaunchConst);
      if (isLaunchFirstTime == null) {
        emit(const FirstLaunchScreen(true));
      }
    });
    on<CloseSignUpScreen>((event, emit) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool(isFirstLaunchConst, false);
      emit(const FirstLaunchScreen(false));
    });

    on<SignUpWithGoogle>((event, emit) async {
      try {
        emit(SignUpStart());
        user = await _authenticationService.signUpWithGoogle();
        emit(const SignUpSuccess());
      } on UserCancelException {
        emit(UserCancelled());
      } on UserNotFoundException {
        emit(AuthenticationFailed());
      } catch (_) {
        emit(AuthenticationFailed());
      }
    });

    on<SignUpWithFacebook>((event, emit) async {
      try {
        emit(SignUpStart());
        user = await _authenticationService.signUpWithFacebook();
        emit(const SignUpSuccess());
      } on UserCancelException {
        emit(UserCancelled());
      } on UserNotFoundException {
        emit(UserCancelled());
      } on AuthenticationFailed {
        emit(UserCancelled());
      } catch (_) {
        emit(AuthenticationFailed());
      }
    });

    on<CheckUserRolesEvent>((event, emit) async {
      try {
        List<Roles> listRole = [];
        listRole = await _storageService.member.getUserRoles(user.uid);
        if (listRole.isEmpty) {
          emit(const UserRolesUnavailable());
        } else {
          // Assumption: user already has roles
          emit(const UserRolesAvailable());
        }
      } catch (e) {
        emit(AuthenticationFailed());
      }
    });
  }
}
