import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatspace/data/data.dart';
import 'package:hatspace/models/authentication/authentication_service.dart';
import 'package:hatspace/models/storage/storage_service.dart';
import 'package:hatspace/singleton/hs_singleton.dart';

part 'get_user_detail_state.dart';

class GetUserDetailCubit extends Cubit<GetUserDetailState> {
  final AuthenticationService _authenticationService =
      HsSingleton.singleton.get<AuthenticationService>();
  final StorageService _storageService =
      HsSingleton.singleton.get<StorageService>();
  GetUserDetailCubit() : super(const GetUserDetailInitialState());

  void getUserInformation() async {
    try {
      emit(const GettingUserDetailState());
      final UserDetail user = await _authenticationService.getCurrentUser();
      final roles = await _storageService.member.getUserRoles(user.uid);
      emit(GetUserDetailSucceedState(user, roles));
    } catch (_) {
      emit(const GetUserDetailFailedState());
    }
  }
}
