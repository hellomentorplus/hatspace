import 'package:flutter/material.dart';
import 'package:hatspace/features/booking/add_inspection_booking.dart';

class BookingView extends StatelessWidget {
  const BookingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Center(
        child: ElevatedButton(onPressed: (){
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context){
              return AddInspectionBooking();
            })
          );
        }, child: Text("Go to Add")),
      );
}
