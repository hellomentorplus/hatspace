import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatspace/data/data.dart';
import 'package:hatspace/models/authentication/authentication_service.dart';
import 'package:hatspace/models/storage/storage_service.dart';
import 'package:hatspace/singleton/hs_singleton.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final AuthenticationService _authenticationService =
      HsSingleton.singleton.get<AuthenticationService>();
  final StorageService _storageService =
      HsSingleton.singleton.get<StorageService>();

  ProfileCubit() : super(const ProfileInitialState());

  void getUserInformation() async {
    try {
      emit(const GettingUserDetailState());
      final UserDetail user = await _authenticationService.getCurrentUser();
      final List<Roles> roles = await _storageService.member.getUserRoles(user.uid);
      emit(GetUserDetailSucceedState(user, roles));
    } catch (_) {
      emit(const GetUserDetailFailedState());
    }
  }

  void deleteAccount() async {
    // todo: will update when requirement changed
    await _authenticationService.signOut();
    emit(const DeleteAccountSucceedState());
  }

  void logOut() async {
    await _authenticationService.signOut();
    emit(const LogOutAccountSucceedState());
  }
}
