import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatspace/data/data.dart';
import 'package:hatspace/data/member.dart';
import 'package:hatspace/models/authentication/authentication_exception.dart';
import 'package:hatspace/models/authentication/authentication_service.dart';
import 'package:hatspace/models/storage/storage_service.dart';
import 'package:hatspace/singleton/hs_singleton.dart';

part 'my_profile_state.dart';

class MyProfileCubit extends Cubit<MyProfileState> {
  final StorageService _storageService;
  final AuthenticationService _authenticationService =
      HsSingleton.singleton.get<AuthenticationService>();
  MyProfileCubit()
      : _storageService = HsSingleton.singleton.get<StorageService>(),
        super(const MyProfileInitialState());

  void getUserInformation() async {
    try {
      emit(const GettingUserInformationState());
      final UserDetail user = await _authenticationService.getCurrentUser();
      emit(GetUserInformationSucceedState(user));
    } catch (_) {
      emit(const GetUserInformationFailedState());
    }
  }

  CountryCallingCode? countryCode;

  String? _phoneNumber;
  String? get phoneNo => _phoneNumber;
  set phoneNumber(String? phoneNumber) {
    _phoneNumber = phoneNumber;
    //print('phonenuber $_phoneNumber');
  }

  Future<void> updateProfilePhoneNumber() async {
    // TODO: By default is Australia - Update in choosing country code story
    countryCode ??= CountryCallingCode.au;
    _phoneNumber = _phoneNumber?.trim();
    PhoneNumber phoneNumber =
        PhoneNumber(countryCode: countryCode!, phoneNumber: _phoneNumber!);
    try {
      UserDetail user = await _authenticationService.getCurrentUser();
      await _storageService.member.savePhoneNumberDetail(user.uid, phoneNumber);
    } on UserNotFoundException catch (_) {
      // TODO: Implement when there is no user
    }
  }
}
