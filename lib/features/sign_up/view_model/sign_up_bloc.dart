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
  SignUpBloc()
      : _authenticationService =
            HsSingleton.singleton.get<AuthenticationService>(),
        _storageService = HsSingleton.singleton.get<StorageService>(),
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

    UserDetail userDetail;
    on<OnSignUp>((event, emit) async {
      try {
        emit(SignUpStart());
        userDetail =
            await _authenticationService.signUp(signUpType: event.signUpType);
        // check user roles availability
        List<Roles> listRole;
        listRole = await _storageService.member.getUserRoles(userDetail.uid);
        if (listRole.isEmpty) {
          emit(const UserRolesUnavailable());
        } else {
          emit(const UserRolesAvailable());
        }
      } on UserCancelException {
        emit(UserCancelled());
      } on UserNotFoundException {
        emit(AuthenticationFailed());
      } catch (_) {
        emit(AuthenticationFailed());
      }
    });
  }
}
