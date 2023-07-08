import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/theme/widgets/hs_text_field.dart';

extension HsFindExtension on CommonFinders {
  Finder svgPictureWithAssets(String assetName) => find.byWidgetPredicate(
      (widget) => _validateSvgPictureWithAssets(widget, assetName));

  bool _validateSvgPictureWithAssets(Widget widget, String assetName) {
    if (widget is! SvgPicture) {
      return false;
    }

    final BytesLoader bytesLoader = widget.bytesLoader;
    if (bytesLoader is! SvgAssetLoader) {
      return false;
    }

    if (bytesLoader.assetName != assetName) {
      return false;
    }

    return true;
  }

  Finder byTextWithColor(String hintText, Color hintColor) => byWidgetPredicate((widget) {
    if (widget is! Text) {
      return false;
    }

    if (widget.data != hintText) {
      return false;
    }

    if (widget.style?.color != hintColor) {
      return false;
    }

    return true;
  });

  Finder findHatSpaceInputTextWithLabel(String label) => byWidgetPredicate((widget) {
    if (widget is! HatSpaceInputText) {
      return false;
    }

    if (widget.label != label) {
      return false;
    }

    return true;
  });
}
