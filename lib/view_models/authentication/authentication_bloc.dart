import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hatspace/models/authentication/authentication_exception.dart';
import 'package:hatspace/singleton/hs_singleton.dart';

import '../../models/authentication/authentication_service.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {

  final AuthenticationService authenticationService = HsSingleton.singleton.get<AuthenticationService>();

  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<ValidateAuthentication>(_validateAuthentication);
  }

  void _validateAuthentication(ValidateAuthentication event, Emitter<AuthenticationState> emit) {
    try {
      authenticationService.getCurrentUser();
      emit(AuthenticatedState());
    } on UserNotFoundException catch (_) {
      emit(AnonymousState());
    }
  }
}
