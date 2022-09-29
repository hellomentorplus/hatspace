import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatspace/bloc/bloc/authentication_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailAddressController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  bool submit = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: ((context, state) {
      return Scaffold(
        backgroundColor: const Color(0xFF006607),
        body: Center(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Text(
                    'Space App',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Text('Space',
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .displayMedium
                                  ?.copyWith(color: Colors.white)),
                          Text("Please enter your email address",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(color: Colors.white)),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 16.0, left: 16.0, bottom: 10.0, top: 10.0),
                        child: TextField(
                          controller: _emailAddressController,
                          onChanged: (email) => context
                              .read<AuthenticationBloc>()
                              .add(SignUpEmailChanged(email)),
                          decoration: InputDecoration(
                              fillColor: Colors.white.withOpacity(0.3),
                              filled: true,
                              hintText: 'Your email address',
                              hintStyle: const TextStyle(color: Colors.white),
                              errorText: (_hasEmailError(state as SignUpState))
                                  ? 'Email address is invalid'
                                  : null,
                              errorStyle: const TextStyle(
                                  color: Color(0xffff6352), fontSize: 16),
                              enabledBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.white, width: 2),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.white, width: 2),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)))),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 16.0, left: 16.0),
                        child: TextField(
                          controller: _passwordController,
                          onChanged: (password) => context
                              .read<AuthenticationBloc>()
                              .add(SignUpPasswordChanged(password)),
                          decoration: InputDecoration(
                              fillColor: Colors.white.withOpacity(0.3),
                              filled: true,
                              hintText: 'Enter your password',
                              errorText: (_hasPasswordError(state))
                                  ? 'Password is invalid'
                                  : null,
                              errorStyle: const TextStyle(
                                  color: Color(0xffff6352), fontSize: 16),
                              hintStyle: const TextStyle(color: Colors.white),
                              enabledBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.white, width: 2),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.white, width: 2),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)))),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0, right: 8.0, bottom: 40.0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextButton(
                            onPressed: () {
                              // context.read<AuthenticationBloc>().add(
                              //     ValidatelEvent(_emailAddressController.text,
                              //         _passwordController.text));
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.white)),
                            child: const Text(
                              'Sign In',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          TextButton.icon(
                              onPressed: () => {},
                              icon: const Icon(
                                Icons.add_a_photo,
                                color: Colors.black,
                              ),
                              label: const Text(
                                'Sign in with Google',
                                style: TextStyle(color: Colors.black),
                              ))
                        ],
                      ),
                    ))
              ]),
        ),
      );
    }));
  }
}

bool _hasEmailError(SignUpState state) => state.emailStatus != FieldError.Valid;
bool _hasPasswordError(SignUpState state) =>
    state.passwordStatus != FieldError.Valid;
