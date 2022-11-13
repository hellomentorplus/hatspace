import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:hatspace/theme/hs_button.dart';
class PrimaryButton extends StatelessWidget{
  final String? label;
  final String? iconUrl;
  final VoidCallback? onPressed;

  const PrimaryButton(
    {Key? key, this.label, this.iconUrl, this.onPressed})
    : assert(label !=null || iconUrl ==null, "label or icon is required" ),
    super(key:key);

  @override
  Widget build(BuildContext context){
    // FOR TEXT ONLY BUTTON
    if(iconUrl == null && label !=null){
        return  ElevatedButton(
          onPressed:onPressed,
          style:  primaryButtonTheme.style,
          child: Text(label!)
        );
    }
    // Button with icon
    if(iconUrl !=null && label != null){
      return ElevatedButton(
        onPressed: onPressed,
        style: buttonWithIconTheme.style,
        child: Row(
          children: [
            Expanded(
              flex: 0,
              child: Container(
                padding: EdgeInsets.only(left: 16, right: 16),
                alignment: Alignment.center,
                  child:SvgPicture.asset(iconUrl!,width:24,height: 24, alignment: Alignment.center, ),
              ),
            ),
            Expanded(
              flex: 4,
              child:Container(

                  alignment: Alignment.center,
                  child: Text(label!) 
                )),
        ],));
    }
    return Row();
  }
      
}

class SecondaryButton extends StatelessWidget{
  final String? label;
  final String? iconURL;
  final VoidCallback? onPressed;
  const SecondaryButton({Key? key, this.label, this.iconURL, this.onPressed})
  :assert(label !=null || iconURL != null, "either are required"),
  super(key:key);
  @override
  Widget build (BuildContext context){
    if (iconURL == null && label != null ){
      return OutlinedButton(
        onPressed: onPressed,
        style: secondaryButtonTheme.style, 
        child: Text(label!));
    }
    return Text("Secondary Button");
  }
}

class TextOnlyButton extends StatelessWidget{
  final String label;
  final VoidCallback? onPressed;
  const TextOnlyButton({Key? key, required this.label,required this.onPressed})
  :super(key:key);
  @override
  Widget build (BuildContext context){
    return TextButton(onPressed: onPressed, child: Text(label),style: textOnlyButtonTheme.style,);
  }
}