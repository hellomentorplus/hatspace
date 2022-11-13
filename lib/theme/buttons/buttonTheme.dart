import 'package:flutter/material.dart';
import 'package:hatspace/theme/color_theme/hs_theme.dart';

ElevatedButtonThemeData defaultPrimaryButtonTheme =
    ElevatedButtonThemeData(
        style: ButtonStyle(
  alignment: Alignment.center,
  foregroundColor: MaterialStateProperty.resolveWith((states){
    if(states.contains(MaterialState.disabled)){
      return HSColor.onPrimary;
    }
    return HSColor.primary;
  }),
  textStyle: MaterialStatePropertyAll(textTheme.titleMedium),
  backgroundColor:
      MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
    if (states.contains(MaterialState.hovered)) {
      return HSColor.primary;
    } else if (states.contains(MaterialState.disabled)) {
      return HSColor.neutral3;
    } else {
      return HSColor.primary;
    }
  }),
  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
      const EdgeInsets.only(top: 17, bottom: 17)),
  shape: MaterialStateProperty.resolveWith<OutlinedBorder>((_) {
    return RoundedRectangleBorder(borderRadius: BorderRadius.circular(16));
  }),
));

OutlinedButtonThemeData defaultSecondaryButtonTheme =
    OutlinedButtonThemeData(
        style: ButtonStyle(
            textStyle:  MaterialStateProperty.resolveWith((Set<MaterialState> state){
              if (state.contains(MaterialState.disabled)){
                print("title disable");
                return textTheme.titleMedium?.copyWith(color: HSColor.neutral3);
              }else if(state.contains(MaterialState.hovered)){
                return textTheme.titleMedium?.copyWith(color: Colors.black);
              }else{
                print("title normal");
                return textTheme.titleMedium?.copyWith(color: Colors.red);
              }
              
            }),
            alignment: Alignment.center,
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                const EdgeInsets.only(left: 17,top: 17, bottom: 17)),
            shape: MaterialStateProperty.resolveWith<OutlinedBorder>((_) {
              return RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16));
            }),
            side:
                MaterialStateBorderSide.resolveWith((Set<MaterialState> state) {
              if (state.contains(MaterialState.hovered)) {
                return const BorderSide(color: HSColor.primary);
              } else if (state.contains(MaterialState.disabled)) {
                return const BorderSide(color: HSColor.neutral3);
              }else{
                return const BorderSide(color: HSColor.primary);
              }
            })));

TextButtonThemeData defaultTextOnlyButtonTheme = TextButtonThemeData(
    style: ButtonStyle(
        textStyle: MaterialStateProperty.resolveWith(((Set<MaterialState> state) {
            return TextStyle(
            color:  state.contains(MaterialState.hovered) ? HSColor.primary: state.contains(MaterialState.disabled) ? HSColor.neutral3 : HSColor.primary ,
            fontSize: 17,
            fontWeight: FontWeight.w700,
            decoration: TextDecoration.underline);
        }))));
