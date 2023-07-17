import 'package:flutter/material.dart';
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

  Finder byTextWithColor(String hintText, Color hintColor) =>
      byWidgetPredicate((widget) {
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

  Finder findHatSpaceInputTextWithLabel(String label) =>
      byWidgetPredicate((widget) {
        if (widget is! HatSpaceInputText) {
          return false;
        }

        if (widget.label != label) {
          return false;
        }

        return true;
      });

  Finder containerWithImageFile(String path) => byWidgetPredicate((widget) {
    if (widget is! Container) {
      return false;
    }

    final Decoration? decoration = widget.decoration;

    if (decoration == null) {
      return false;
    }

    if (decoration is! BoxDecoration) {
      return false;
    }

    DecorationImage? decorationImage = decoration.image;

    if (decorationImage == null) {
      return false;
    }

    if (decorationImage.image is! FileImage) {
      return false;
    }

    ImageProvider imageProvider = decorationImage.image;

    if (imageProvider is! FileImage) {
      return false;
    }

    if (imageProvider.file.path != path) {
      return false;
    }

    return true;
  });
}
