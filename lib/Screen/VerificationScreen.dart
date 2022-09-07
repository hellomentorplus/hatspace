import 'package:flutter/material.dart';
import 'package:hatspace/Screen/HomeScreen.dart';

class VerificationPage extends StatelessWidget {
  
  final emailValue;
  const VerificationPage( {super.key, required this.emailValue});
  
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
                        child: const Text(
                          "Space App",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: Colors.white),
                        )),
                    Column(children: [
                      Container(
                        padding: const EdgeInsets.only(left: 100, right:100),
                        child:  Text(
                          "We've send a pin to $emailValue",
                          softWrap: true,
                          textAlign: TextAlign.center,
                          style:const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 20,right:20),
                        margin: const EdgeInsets.only(top: 15, bottom: 15),
                        child: const Text(
                          "Check your spam folder if you don't receive it",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                      ),
                      const TextField(
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 20),
                        decoration: InputDecoration(
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
                          hintText: "Enter Pin",
                          hintStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 20),
                        ),
                      )
                    ]),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: !_isButtonDisable
                                    ? MaterialStateProperty.all<Color>(
                                        const Color.fromRGBO(
                                            255, 255, 255, 0.5))
                                    : MaterialStateProperty.all<Color>(
                                        const Color.fromRGBO(255, 255, 255, 1)),
                              ),
                              onPressed: () => {
                                
                              },
                              child: const Text(
                                "Sign In",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20),
                              )),
                          const SizedBox(
                            height: 10,
                          ),
                          TextButton(
                              onPressed: () => {
                                Navigator.push(context, MaterialPageRoute(builder: (context){
                                    return MyHomePage();
                                }))
                              },
                              child: const Text(
                                "I need another pin",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
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
                    )
                  ]),
            )));
  }
}
