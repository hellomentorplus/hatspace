import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/strings/l10n.dart';

enum Feature {
  fridge,
  washingMachine,
  swimmingPool,
  airConditioners,
  electricStove,
  tv,
  wifi,
  securityCameras,
  kitchen,
  portableFans;

  String get displayName {
    switch (this) {
      case Feature.fridge:
        return HatSpaceStrings.current.fridge;
      case Feature.swimmingPool:
        return HatSpaceStrings.current.swimmingPool;
      case Feature.washingMachine:
        return HatSpaceStrings.current.washingMachine;
      case Feature.airConditioners:
        return HatSpaceStrings.current.airConditioners;
      case Feature.electricStove:
        return HatSpaceStrings.current.electricStove;
      case Feature.tv:
        return HatSpaceStrings.current.tv;
      case Feature.wifi:
        return HatSpaceStrings.current.wifi;
      case Feature.securityCameras:
        return HatSpaceStrings.current.securityCameras;
      case Feature.kitchen:
        return HatSpaceStrings.current.kitchen;
      case Feature.portableFans:
        return HatSpaceStrings.current.portableFans;
    }
  }

  String get iconSvgPath {
    switch (this) {
      case Feature.fridge:
        return Assets.icons.fridge;
      case Feature.swimmingPool:
        return Assets.icons.swimmingPool;
      case Feature.washingMachine:
        return Assets.icons.washingMachine;
      case Feature.airConditioners:
        return Assets.icons.airConditioners;
      case Feature.electricStove:
        return Assets.icons.electricStove;
      case Feature.tv:
        return Assets.icons.tv;
      case Feature.wifi:
        return Assets.icons.wifi;
      case Feature.securityCameras:
        return Assets.icons.securityCameras;
      case Feature.kitchen:
        return Assets.icons.kitchen;
      case Feature.portableFans:
        return Assets.icons.portableFans;
    }
  }
}
