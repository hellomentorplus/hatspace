import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hatspace/data/data.dart';
import 'package:hatspace/models/authentication/authentication_exception.dart';
import 'package:hatspace/models/authentication/authentication_service.dart';
import 'package:hatspace/models/storage/storage_service.dart';
import 'package:hatspace/singleton/hs_singleton.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'sign_up_event.dart';
part 'sign_up_state.dart';

const isFirstLaunchConst = "isFirstLaunch";

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthenticationService _authenticationService;
  final StorageService _storageService;
  SignUpBloc()
      : _authenticationService =
            HsSingleton.singleton.get<AuthenticationService>(),
        _storageService = HsSingleton.singleton.get<StorageService>(),
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
        await signUp(emit, SignUpType.googleService);
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
        await signUp(emit, SignUpType.facebookService);
      } on UserCancelException {
        emit(UserCancelled());
      } on UserNotFoundException {
        emit(AuthenticationFailed());
      } catch (_) {
        emit(AuthenticationFailed());
      }
    });
  }

  Future<UserDetail> signUp(Emitter emitter, SignUpType type) async {
    UserDetail userDetail;
    userDetail = await _authenticationService.signUp(signUpType: type);
    List<Roles> listRoles = [];
    listRoles = await _storageService.member.getUserRoles(userDetail.uid);
    if (listRoles.isEmpty) {
      emitter(const UserRolesUnavailable());
    } else {
      //Change state name from "UserRoleAvailable" to SignUpSuccess to make logic flow clearer
      emitter(const SignUpSuccess());
    }
    return userDetail;
  }
}
