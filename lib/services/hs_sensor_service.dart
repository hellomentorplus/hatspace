// import 'dart:async';

// import 'package:sensors_plus/sensors_plus.dart';

// // class SensorService {
// //   static final SensorService _instance = SensorService._internal();

// //   factory SensorService() {
// //     return _instance;
// //   }

// //   late StreamSubscription<AccelerometerEvent> _accelerometerSubscription;

// //   double _x = 0.0, _y = 0.0, _z = 0.0;

// //   double get x => _x;

// //   double get y => _y;

// //   double get z => _z;

// //   SensorService._internal() {
// //     var sensor = Sensors();
// //     _accelerometerSubscription = sensor.accelerometerEvents.listen((AccelerometerEvent event) {
// //       _x = event.x;
// //       _y = event.y;
// //       _z = event.z;
// //     });
// //   }

// //   void dispose() {
// //     _accelerometerSubscription.cancel();
// //   }
// // }

// import 'package:sensors_plus/sensors_plus.dart';

// class SensorsSingleton {
//   static final SensorsSingleton _singleton = SensorsSingleton._internal();

//   AccelerometerEvent? accelerometerEvent;
//   List<double>?  accelerometerValue;
//   StreamSubscription? subcription;

//   SensorsSingleton._internal(){
//   subcription =
//     accelerometerEvents.listen((event) {
//       print(event);
//       accelerometerValue = [event.x,event.y,event.z];
//     });
//   }

//   final Sensors _sensorsPlus = Sensors();

//   static SensorsSingleton get instance {
//     return _singleton;
//   }

//   Sensors get sensorsPlus {
//     return _sensorsPlus;
//   }
//   void dispose(){
//     subcription?.cancel();
//   }
// }
