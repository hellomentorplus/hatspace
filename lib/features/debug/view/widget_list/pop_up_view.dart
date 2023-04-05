import 'package:flutter/material.dart';

class PopupView extends StatelessWidget {
  const PopupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:  TextButton(
      onPressed: () => showDialog<String>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) =>  AlertDialog(
          iconPadding: EdgeInsets.all(40.0),
          icon:  Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                Text("Loading...")
              ],
            
          ),
          // actions: <Widget>[

          //   const CircularProgressIndicator(
             
          //   ),
          //   TextButton(
          //     onPressed: () => Navigator.pop(context, 'Cancel'),
          //     child: const Text('Cancel'),
          //   ),
          // ],
        ),
      ),
      child: const Text('Show Dialog'),
    ),
      )
    );
  }
}


// class ProgressIndicatorExample extends StatefulWidget {
//   const ProgressIndicatorExample({super.key});

//   @override
//   State<ProgressIndicatorExample> createState() =>
//       _ProgressIndicatorExampleState();
// }

// class _ProgressIndicatorExampleState extends State<ProgressIndicatorExample>
//     with TickerProviderStateMixin {
//   late AnimationController controller;
//   bool determinate = false;

//   @override
//   void initState() {
//     controller = AnimationController(
//       /// [AnimationController]s can be created with `vsync: this` because of
//       /// [TickerProviderStateMixin].
//       vsync: this,
//       duration: const Duration(seconds: 2),
//     )..addListener(() {
//         setState(() {});
//       });
//     controller.repeat();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }
  
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Scaffold(
//       body: Center(
//         child:  TextButton(
//       onPressed: () => showDialog<String>(
//         context: context,
//         builder: (BuildContext context) => Dialog(
//           child: 
//               Center(
//                 child:     CircularProgressIndicator(
//               value: controller.value,
//               // semanticsLabel: 'Circular progress indicator',
//             ),
//               )
      
//         ),
//       ),
//       child: const Text('Show Dialog'),
//     ),
//       )
//     );
//   }
  
//   }
