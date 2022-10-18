import 'package:flutter/material.dart';
import 'package:hatspace/Screen/HomeScreen.dart';

class VerificationPage extends StatelessWidget {
  final emailValue;
  const VerificationPage({super.key, required this.emailValue});
  final bool _isButtonDisable = false;
  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ButtonStyle(
          fixedSize: MaterialStateProperty.all<Size>(
            const Size.fromHeight(45),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(
              const Color.fromRGBO(255, 255, 255, 1)),
        ))),
        child: Scaffold(
           resizeToAvoidBottomInset: false,
            backgroundColor: Theme.of(context).primaryColor,
            body: Padding(
              //
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                        margin: const EdgeInsets.only(top: 60.0, bottom: 20.0),
                        child: Text(
                          "Space App",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleMedium,
                        )),
                    Column(children: [
                      Container(
                        padding: const EdgeInsets.only(left: 100, right: 100),
                        child: Text(
                          "We've send a pin to $emailValue",
                          softWrap: true,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        margin: const EdgeInsets.only(top: 15, bottom: 15),
                        child: Text(
                          "Check your spam folder if you don't receive it",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      TextField(
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
                          hintText: "Enter Pin",
                          hintStyle: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontSize: 20.0),
                        ),
                      )
                    ]),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:MaterialStateProperty.resolveWith((states) {
                                const Set<MaterialState> buttonState = <MaterialState>{
                                  MaterialState.disabled
                                };
                                if (states.any(buttonState.contains)){
                                    return const Color.fromARGB(190, 255, 255, 255);
                                }
                                return const Color.fromRGBO(255, 255, 255, 1);
                            })
                            ),
                            onPressed: !_isButtonDisable? null : () => {},
                            child: const Text(
                              "Sign In",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        TextButton(
                            onPressed: () => {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return MyHomePage();
                                  }))
                                },
                            child: const Text(
                              "I need another pin",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            )),
                        const SizedBox(height: 10),
                        RichText(
                            textAlign: TextAlign.center,
                            text: const TextSpan(
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                                children: [
                                  TextSpan(text: "Made with "),
                                  TextSpan(
                                      text: "Glide",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold))
                                ]))
                      ],
                    ),
                  ]),
            )));
  }
}
