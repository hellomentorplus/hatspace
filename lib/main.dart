import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primaryColor: Color(0xff006606),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
  // This widget is the root of your application.
  class _MyHomePageState extends State<MyHomePage> {
  bool _isButtonDisable = false;

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
          // resizeToAvoidBottomInset: false,
          backgroundColor: Theme.of(context).primaryColor,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Text(
                          "Space App",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: Colors.white),
                        )
                      ],
                    )),

                // color: Colors.orangeAccent,
                Container(
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
                                borderSide: BorderSide(
                                    color: Colors.white, width: 2.0)),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 2.0),
                            ),
                            hintText: "Email address",
                            hintStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 20),
                          ),
                          onChanged: (value) => {
                            setState(() {
                              if (value.length == 0) {
                                _isButtonDisable = false;
                              } else {
                                _isButtonDisable = true;
                              }
                            })
                          },
                        ),
                      )
                    ],
                  ),
                ),

                Container(
                  padding: EdgeInsets.fromLTRB(30, 0, 30, 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: !_isButtonDisable
                                ? MaterialStateProperty.all<Color>(
                                    const Color.fromRGBO(255, 255, 255, 0.5))
                                : MaterialStateProperty.all<Color>(
                                    const Color.fromRGBO(255, 255, 255, 1)),
                          ),
                          onPressed: () => {
                                
                              },
                          child: const Text(
                            "Continue",
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton.icon(
                          icon: const Icon(Icons.add,
                              color: Colors.black, size: 30),
                          onPressed: () => {},
                          label: const Text(
                            "Sign in with Google",
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          )),
                      const SizedBox(height: 20),
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
              ],
            ),
          ), // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }
}