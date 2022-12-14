/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/calendar.svg
  String get calendar => 'assets/images/calendar.svg';

  /// File path: assets/images/close_icon.svg
  String get closeIcon => 'assets/images/close_icon.svg';

  /// File path: assets/images/envelope.svg
  String get envelope => 'assets/images/envelope.svg';

  /// File path: assets/images/facebook.svg
  String get facebook => 'assets/images/facebook.svg';

  /// File path: assets/images/facebookround.svg
  String get facebookround => 'assets/images/facebookround.svg';

  /// File path: assets/images/google.svg
  String get google => 'assets/images/google.svg';

  /// File path: assets/images/messages.svg
  String get messages => 'assets/images/messages.svg';

  /// File path: assets/images/profile-circle.svg
  String get profileCircle => 'assets/images/profile-circle.svg';

  /// File path: assets/images/search-normal.svg
  String get searchNormal => 'assets/images/search-normal.svg';

  /// List of all assets
  List<String> get values => [
        calendar,
        closeIcon,
        envelope,
        facebook,
        facebookround,
        google,
        messages,
        profileCircle,
        searchNormal
      ];
}

class Assets {
  Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider() => AssetImage(_assetName);

  String get path => _assetName;

  String get keyName => _assetName;
}
