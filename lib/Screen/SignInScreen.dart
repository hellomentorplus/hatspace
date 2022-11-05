import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hatspace/theme/buttons/buttonTheme.dart';
import 'package:hatspace/theme/buttons/sharedButtons.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});
  // DECLARE METHOD
  // Note: When signInWithCredential Success => firebase create new account for that email. If the account already used => firebase WILL NOT dublicate another one
  Future<UserCredential> signInWithGoogle() async {
    UserCredential user;

    GoogleSignInAccount? googleSignInAccount = await GoogleSignIn().signIn();
    GoogleSignInAuthentication? googleAuth =
        await googleSignInAccount?.authentication;
    // SHOULD BE VALIDATE IF googleAuth.accessToken == null
    // This happens when user cancel the authentication form
    // MORE ACTION HERE
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    user = await FirebaseAuth.instance.signInWithCredential(credential);
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 60, 16, 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: DefaulSecondaryLeftIconButton(text: "Sign in with Google", onClick: (){
                    signInWithGoogle();
                  },iconURL: "assets/images/flat-color-icons_google.png",)
                  ),
              Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: ElevatedButton(
                    child: Row(
                      children: [
                        Image.asset('assets/images/logo_facebook.png'),
                        Container(
                          margin: const EdgeInsets.only(left: 44),
                          child: const Text("Sign in with Facebook"),
                        )
                      ],
                    ),
                    onPressed: () {
                      // Do something here
                    },
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: ElevatedButton(
                  style: Theme.of(context).elevatedButtonTheme.style,
                  child: 
                  Container(
                    width: 343,
                    child: Row(
                    children: [
                      Image.asset(
                        "assets/images/sms.png",
                        width: 24,
                        height: 24,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 44),
                        child: const Text("Sign in with Email"),
                      ),
                    ],
                  ),),
                 
                  onPressed: () {
                    // Do something here
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 55),
                child: TextButton(
                  onPressed: () {
                    // SKIP funtion
                  },
                  child: const Text(
                    "Skip",
                    style: TextStyle(
                        color: Color(0xff282828),
                        decoration: TextDecoration.underline),
                  ),
                ),
              ),
              DefaultPrimaryTextOnlyButton(child: const Text("Child"), onClick: (){
                print("object");
              }),
              DisablePrimaryTextOnlyButton(child: const Text("Disable")),
              DefaultSecondaryTextOnlyButton(child: const Text("Outline"), onClick: (){
                print("Outline Clicked");
              }),
              DefaultTextOnlyButton(child: Text("ABC"),onPressed: (){},),
              DefaulSecondaryLeftIconButton(text: "Sign in with Google",iconURL:                             'assets/images/flat-color-icons_google.png',onClick: (){
                print("Icon Click");
              },)

            
            ],
          ),
        ));
  }
}
