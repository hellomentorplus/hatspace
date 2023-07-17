import 'package:flutter/material.dart';
import 'package:hatspace/features/add_property/view/add_property_view.dart';
import 'package:hatspace/features/debug/view/widget_list/widget_catalog_screen.dart';
import 'package:hatspace/features/home/view/home_view.dart';
import 'package:hatspace/features/sign_up/choose_roles/view/choose_roles_screen.dart';
import 'package:hatspace/features/sign_up/view/sign_up_screen.dart';

extension RouteExtension on BuildContext {
  void goToSignup() {
    Navigator.of(this).push(MaterialPageRoute(builder: ((context) {
      return const SignUpScreen();
    })));
  }

  void goToHome() {
    Navigator.of(this).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomePageView()));
  }

  void goToChooseRole() {
    Navigator.of(this).pushReplacement(
        MaterialPageRoute(builder: (context) => const ChooseRolesScreen()));
  }

  void goToWidgetCatalog() {
    Navigator.push(this, MaterialPageRoute(builder: (context) {
      // detector.stopListening();
      return WidgetCatalogScreen();
    }));
  }

  void goToAddProperty() {
    Navigator.push(
        this,
        MaterialPageRoute(
          builder: (context) => const AddPropertyView(),
        ));
  }

  void pop() {
    Navigator.of(this).pop();
  }

  void popToRootHome() {
    Navigator.of(this).popUntil((route) => route.isFirst);
  }
}
