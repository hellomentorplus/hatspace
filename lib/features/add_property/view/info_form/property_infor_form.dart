import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/theme/hs_theme.dart';

InputDecoration inputTextTheme = InputDecoration(
    contentPadding: const EdgeInsets.fromLTRB(16, 13, 12, 13),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: HSColor.black,
        )),
    hintText: "confirm by PO",
    hintStyle:
        textTheme.bodyMedium?.copyWith(height: 1.0, color: HSColor.neutral5));

class PropertyInforForm extends StatelessWidget {
  PropertyInforForm({super.key});

  List<Widget> itemList = [
    const Text("Information",
        style: TextStyle(
            fontSize: 24,
            color: HSColor.onSurface,
            fontWeight: FontWeight.w700)),
    const PropertyName(),
    const PropertyPrice(),
    const PropertyRentPeriod()
  ];
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 16, top: 33, right: 16),
          child: ListView.separated(
          
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(
              height: 16,
            ),
            itemCount: itemList.length,
            itemBuilder: (context, index) {
              return itemList[index];
            },
          ),
        ));
  }
}

class PropertyName extends StatelessWidget {
  const PropertyName({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Text("Property name"),
        TextField(
            style:
                Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.5),
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(16, 13, 12, 13),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: HSColor.black,
                    )),
                hintText: "confirm by PO",
                hintStyle: textTheme.bodyMedium
                    ?.copyWith(height: 1.0, color: HSColor.neutral5)))
      ],
    );
  }
}

class PropertyPrice extends StatelessWidget {
  const PropertyPrice({super.key});
  @override
  Widget build(BuildContext context) {
    return 
      Wrap(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Price"),
 Card(
        color: Colors.white,
        elevation: 4.0,
        shadowColor: HSColor.black.withOpacity(0.2),
        shape: RoundedRectangleBorder(
            side: BorderSide(color: HSColor.black),
            borderRadius: BorderRadius.circular(8.0)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: TextField(
                decoration: inputTextTheme.copyWith(border:OutlineInputBorder(borderSide: BorderSide.none)),
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(height: 1.0),
              ),
            ),
            Padding(padding: const EdgeInsets.only(
              right: 7,
              left: 16
            ),
            child: 
      Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                
                borderRadius: BorderRadius.circular(4),
                color: HSColor.neutral2
              ),
              
              child: const Text("USD (\$)",
                style: TextStyle(
 
                ),
              )
            )
            
            )
      
          ],
        ))
        ],
      );
   
  }
}

class PropertyRentPeriod extends StatelessWidget{
  const PropertyRentPeriod({super.key});
  @override
  Widget build(context){
    return Wrap(
      children: [
        Text("Minimum rent period"),
        TextField(
          decoration: inputTextTheme,
        )
      ],
    );
  }
}
