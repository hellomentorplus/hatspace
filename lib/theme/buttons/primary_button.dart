import 'package:flutter/material.dart';

import 'buttonTheme.dart';

class DefaultPrimaryButton extends StatelessWidget{
  final String? label;
  final String? icon;
  final String? iconPosition;
  final VoidCallback? onPressed;

  const DefaultPrimaryButton(
    {Key? key, this.label, this.icon, this.iconPosition, this.onPressed})
    : assert(label ==null || icon ==null, "label or icon is required" ),
    super(key:key);

  @override
  Widget build(BuildContext context){
    // FOR TEXT ONLY BUTTON
    if(icon == null && label !=null){
        return  ElevatedButton(
          onPressed:onPressed,
          style:  defaultPrimaryButtonTheme.style,
          child: Text(label!)
        );
    }
    if(icon != null && label != null ){
        return OutlinedButton(
          onPressed: onPressed!,
          child: Row(
              children: [
                Image.asset(icon!),
                Container(
                  margin:  const EdgeInsets.only(left: 44),
                  child: Text(label!) 
                )
              ],
            ),
          );
    }
    return Row(
    );
  }
      
}