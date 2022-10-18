import 'package:flutter/material.dart';
import 'package:hatspace/Screen/VerificationScreen.dart';
import 'package:hatspace/SignUpScreen/signup.dart';
import 'package:hatspace/main.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isButtonDisable = false;
  String emailValue = "";

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          fixedSize: MaterialStateProperty.all<Size>(
            const Size.fromHeight(45),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(
              const Color.fromRGBO(255, 255, 255, 1)),
        ))),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Theme.of(context).primaryColor,
          body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                    // color:Colors.amberAccent,
                    margin: const EdgeInsets.only(top: 60.0, bottom: 20.0),
                    child: Text("Space App",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleMedium)),
                Column(
                  children: [
                    Text(
                      "Space",
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Text("Please enter your email address",
                          style: Theme.of(context).textTheme.titleMedium),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                      child: TextField(
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontSize: 20.0),
                        decoration: InputDecoration(
                          isCollapsed: true,
                          contentPadding: const EdgeInsets.all(10),
                          filled: true,
                          fillColor: const Color.fromRGBO(255, 255, 255, 0.4),
                          enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 2.0)),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide:
                                BorderSide(color: Colors.white, width: 2.0),
                          ),
                          hintText: "Email address",
                          hintStyle: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontSize: 20.0),
                        ),
                        onChanged: (value) {
                          if (value.length != 0) {
                            setState(() {
                              _isButtonDisable = true;
                            });
                          } else {
                            setState(() {
                              _isButtonDisable = false;
                            });
                          }
                          setState(() {
                            emailValue = value;
                          });
                        },
                      ),
                    ),
                    Container(
                        padding: const EdgeInsets.fromLTRB(30, 0, 30, 20),
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          child: Text(
                            "Sign Up",
                              style:  Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal)
                              ),
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return SigUpScreen();
                            }));
                          },
                        )),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  // color:Colors.amberAccent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      ElevatedButton(
                          style: ButtonStyle(backgroundColor:
                              MaterialStateProperty.resolveWith((states) {
                            const Set<MaterialState> buttonState =
                                <MaterialState>{MaterialState.disabled};
                            if (states.any(buttonState.contains)) {
                              return const Color.fromARGB(190, 255, 255, 255);
                            }
                            return const Color.fromRGBO(255, 255, 255, 1);
                          })),
                          onPressed: !_isButtonDisable
                              ? null
                              : () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return VerificationPage(
                                        emailValue: emailValue);
                                  }));
                                },
                          child: Text(
                            "Continue",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(color: Colors.black),
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        child: Text.rich(
                          const TextSpan(children: [
                            WidgetSpan(
                                child: Icon(Icons.add, color: Colors.black)),
                            TextSpan(text: "Sign in with Google"),
                          ]),
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(color: Colors.black),
                        ),
                        onPressed: () {},
                      ),
                      const SizedBox(height: 10),
                      RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal),
                              children: const [
                                TextSpan(text: "Made with "),
                                TextSpan(
                                    text: "Glide",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold))
                              ]))
                    ],
                  ),
                )
              ]), // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }
}
