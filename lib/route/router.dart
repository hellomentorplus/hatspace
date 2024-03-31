import 'package:flutter/material.dart';
import 'package:hatspace/features/add_property/view/add_property_screen.dart';
import 'package:hatspace/features/booking/add_inspection_booking_screen.dart';
import 'package:hatspace/features/booking/add_inspection_success_booking_screen.dart';
import 'package:hatspace/features/inspection_confirmation_detail/inspection_confirmation_detail_screen.dart';
import 'package:hatspace/features/inspection_confirmation_list/inspection_confirmation_list_screen.dart';
import 'package:hatspace/features/inspection_detail/inspection_detail_screen.dart';
import 'package:hatspace/features/debug/view/widget_list/widget_catalog_screen.dart';
import 'package:hatspace/features/property_detail/property_detail_screen.dart';
import 'package:hatspace/features/sign_up/choose_roles/view/choose_roles_screen.dart';
import 'package:hatspace/features/sign_up/view/sign_up_screen.dart';
import 'package:hatspace/features/dashboard/dashboard_screen.dart';

extension RouteExtension on BuildContext {
  Future<T?> goToSignup<T extends Object?>() {
    return Navigator.of(this).push(MaterialPageRoute(builder: ((context) {
      return const SignUpScreen();
    })));
  }

  void goToHome() {
    Navigator.of(this).pushReplacement(
        MaterialPageRoute(builder: (context) => const DashboardScreen()));
  }

  Future<T?> goToChooseRole<T extends Object?>() {
    return Navigator.of(this).push(
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

  void goToPropertyDetail({required String id, bool replacement = false}) {
    if (replacement) {
      Navigator.pushReplacement(
          this,
          MaterialPageRoute(
            builder: (context) => PropertyDetailScreen(id: id),
          ));
    } else {
      Navigator.push(
          this,
          MaterialPageRoute(
            builder: (context) => PropertyDetailScreen(id: id),
          ));
    }
  }

  void goToInspectionDetail({required String id}) {
    Navigator.push(
        this,
        MaterialPageRoute(
          builder: (context) => InspectionDetailScreen(id: id),
        ));
  }

  void goToInspectionConfirmationDetail({required String id}) {
    Navigator.push(
        this,
        MaterialPageRoute(
          builder: (context) => InspectionConfirmationDetailScreen(id: id),
        ));
  }

  void goToInspectionConfirmationListDetail({required String id}) {
    Navigator.push(
        this,
        MaterialPageRoute(
          builder: (context) => InspectionConfirmationListScreen(id: id),
        ));
  }

  void pop<T>({T? result}) {
    Navigator.of(this).pop<T>(result);
  }

  void popToRootHome() {
    Navigator.of(this).popUntil((route) => route.isFirst);
  }

  // BOOKING INSPECTION FLOW
  void pushToBookInspectionSuccessScreen({required String inspectionId}) {
    Navigator.of(this).pushReplacement(MaterialPageRoute(
        builder: (context) => AddInspectionSuccessScreen(inspectionId)));
  }

  Future<T?> goToBookInspectionScreen<T extends Object?>(
      {required String propertyId}) {
    return Navigator.pushReplacement(this,
        MaterialPageRoute(builder: (context) {
      return AddInspectionBookingScreen(id: propertyId);
    }));
  }
}
