import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_test/flutter_test.dart';

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
}
