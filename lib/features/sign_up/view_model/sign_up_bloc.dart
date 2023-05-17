import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hatspace/data/data.dart';
import 'package:hatspace/data/property_data.dart';
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
      // try {
      //   emit(SignUpStart());
      //   await signUp(emit, SignUpType.facebookService);
      // } on UserCancelException {
      //   emit(UserCancelled());
      // } on UserNotFoundException {
      //   emit(AuthenticationFailed());
      // } catch (_) {
      //   emit(AuthenticationFailed());
      // }
      // _storageService.property.addProperty(Property(
      //   type: PropertyTypes.house, 
      //   name: "Property name 3", 
      //   price: Price(rentPrice: 5000.0), 
      //   description: "Property 3 description", 
      //   address: AddressDetail(streetName: "street name", streetNo: "23", postcode: 3020,  
      //   suburb: "ABC suburb", 
      //   state: AustraliaStates.vic, unitNo: "2"), 
      //   additionalDetail: AdditionalDetail(), 
      //   photos: [], 
      //   minimumRentPeriod: MinimumRentPeriod.sixMonths, 
      //   country: CountryCode.au, 
      //   location: GeoPoint(60, 50), 
      //   createdTime: Timestamp.now(), 
      //   availableDate: Timestamp.now()));
    // Property? prop = await  _storageService.property.getProperty("3kuSXz8kIkWxGn5T8BG5");
    //   print(prop);
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
