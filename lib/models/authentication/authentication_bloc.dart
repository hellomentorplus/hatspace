import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hatspace/models/authentication/authentication_service.dart';


part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationService _authenticationService;
  AuthenticationBloc({AuthenticationService? authenticationService})
      : _authenticationService =
      authenticationService ?? AuthenticationService(),
        super(AuthenticationInitial()) {
    on<AuthenticationEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<SignUpWithGoolge>((event, emit) async {
      try {
        UserDetail? user = await _authenticationService.signUpWithGoogle();
        if (user != null) {
          print('ok');
          return emit(const AuthenticateSuccess());
        }
      } on PlatformException {
        // TODO: SHOW TOAST
        emit(
            AuthenticateFailed(SignUpStatusMessage.authenticationFaildMessage));
      }
    });
  }
}
