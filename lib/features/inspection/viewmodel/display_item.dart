import 'package:hatspace/data/property_data.dart';

abstract class DisplayItem {
  final int viewType;

  DisplayItem(this.viewType);
}

// Subclasses for different view types
class Header extends DisplayItem {
  Header() : super(ViewType.header.index);
}

class NumberOfInspectionItem extends DisplayItem {
  final int number;

  NumberOfInspectionItem(this.number)
      : super(ViewType.numberOfInspection.index);
}

class TenantBookingItem extends DisplayItem {
  final String id;
  final String propertyImage;
  final String propertyName;
  final PropertyTypes propertyType;
  final double price;
  final Currency currency;
  final String timeRenting;
  final AustraliaStates state;
  final String timeBooking; // todo: need to update after demo
  final String? ownerName;
  final String? ownerAvatar;

  TenantBookingItem(
      this.id,
      this.propertyImage,
      this.propertyName,
      this.propertyType,
      this.price,
      this.currency,
      this.timeRenting,
      this.state,
      this.timeBooking,
      this.ownerName,
      this.ownerAvatar)
      : super(ViewType.tenantBooking.index);
}

class HomeOwnerBookingItem extends DisplayItem {
  final String id;
  final String propertyImage;
  final String propertyName;
  final PropertyTypes propertyType;
  final double price;
  final Currency currency;
  final String timeRenting;
  final AustraliaStates state;
  final int numberOfBookings; // todo: need to update after demo

  HomeOwnerBookingItem(
    this.id,
    this.propertyImage,
    this.propertyName,
    this.propertyType,
    this.price,
    this.currency,
    this.timeRenting,
    this.state,
    this.numberOfBookings,
  ) : super(ViewType.homeOwnerBooking.index);
}

// Enum for ViewType
enum ViewType {
  header,
  numberOfInspection,
  tenantBooking,
  homeOwnerBooking,
}
