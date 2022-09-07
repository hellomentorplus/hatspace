import 'package:flutter/material.dart';
import 'package:hatspace/Screen/VerificationScreen.dart';
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
                    child: const Text(
                      "Space App",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: Colors.white),
                    )),
                Container(
                    // color: Colors.amberAccent,
                    // color:Colors.amberAccent,
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Space",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 65,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: const Text(
                        "Please enter your email address",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                      child: TextField(
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 20),
                        decoration: const InputDecoration(
                          isCollapsed: true,
                          contentPadding: EdgeInsets.all(10),
                          filled: true,
                          fillColor: Color.fromRGBO(255, 255, 255, 0.4),
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 2.0)),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide:
                                BorderSide(color: Colors.white, width: 2.0),
                          ),
                          hintText: "Email address",
                          hintStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 20),
                        ),
                        onChanged: (value) {
                          setState(() {
                            if (value.length == 0) {
                              _isButtonDisable = false;
                            } else {
                              _isButtonDisable = true;
                            }
                          });
                          setState(() {
                            emailValue = value;
                          });
                        },
                      ),
                    )
                  ],
                )),
                Container(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  // color:Colors.amberAccent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: !_isButtonDisable
                                ? MaterialStateProperty.all<Color>(
                                    const Color.fromARGB(190, 255, 255, 255))
                                : MaterialStateProperty.all<Color>(
                                    const Color.fromRGBO(255, 255, 255, 1)),
                          ),
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return VerificationPage(emailValue: emailValue);
                            }));
                          },
                          child: const Text(
                            "Continue",
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        child: const Text.rich(
                          TextSpan(children: [
                            WidgetSpan(
                                child: Icon(Icons.add, color: Colors.black)),
                            TextSpan(text: "Sign in with Google"),
                          ]),
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                        onPressed: () {},
                      ),
                      const SizedBox(height: 10),
                      RichText(
                          textAlign: TextAlign.center,
                          text: const TextSpan(
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                              children: [
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
