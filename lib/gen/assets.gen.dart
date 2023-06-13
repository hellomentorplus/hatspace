/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/add.svg
  String get add => 'assets/icons/add.svg';

  /// File path: assets/icons/booking.svg
  String get booking => 'assets/icons/booking.svg';

  /// File path: assets/icons/explore.svg
  String get explore => 'assets/icons/explore.svg';

  /// File path: assets/icons/filter.svg
  String get filter => 'assets/icons/filter.svg';

  /// File path: assets/icons/ic_agent.svg
  String get icAgent => 'assets/icons/ic_agent.svg';

  /// File path: assets/icons/message.svg
  String get message => 'assets/icons/message.svg';

  /// File path: assets/icons/notification.svg
  String get notification => 'assets/icons/notification.svg';

  /// File path: assets/icons/profile.svg
  String get profile => 'assets/icons/profile.svg';

  /// File path: assets/icons/search.svg
  String get search => 'assets/icons/search.svg';

  /// List of all assets
  List<String> get values => [
        add,
        booking,
        explore,
        filter,
        icAgent,
        message,
        notification,
        profile,
        search
      ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/calendar.svg
  String get calendar => 'assets/images/calendar.svg';

  /// File path: assets/images/chevron_left.svg
  String get chevronLeft => 'assets/images/chevron_left.svg';

  /// File path: assets/images/chevron_right.svg
  String get chevronRight => 'assets/images/chevron_right.svg';

  /// File path: assets/images/close-clear.svg
  String get closeClear => 'assets/images/close-clear.svg';

  /// File path: assets/images/close-dark.svg
  String get closeDark => 'assets/images/close-dark.svg';

  /// File path: assets/images/close_icon.svg
  String get closeIcon => 'assets/images/close_icon.svg';

  /// File path: assets/images/decrement.svg
  String get decrement => 'assets/images/decrement.svg';

  /// File path: assets/images/email.svg
  String get email => 'assets/images/email.svg';

  /// File path: assets/images/envelope.svg
  String get envelope => 'assets/images/envelope.svg';

  /// File path: assets/images/error.svg
  String get error => 'assets/images/error.svg';

  /// File path: assets/images/facebook.svg
  String get facebook => 'assets/images/facebook.svg';

  /// File path: assets/images/facebookround.svg
  String get facebookround => 'assets/images/facebookround.svg';

  /// File path: assets/images/google.svg
  String get google => 'assets/images/google.svg';

  /// File path: assets/images/increment.svg
  String get increment => 'assets/images/increment.svg';

  /// File path: assets/images/messages.svg
  String get messages => 'assets/images/messages.svg';

  /// File path: assets/images/profile-circle.svg
  String get profileCircle => 'assets/images/profile-circle.svg';

  /// File path: assets/images/search-normal.svg
  String get searchNormal => 'assets/images/search-normal.svg';

  /// List of all assets
  List<String> get values => [
        calendar,
        chevronLeft,
        chevronRight,
        closeClear,
        closeDark,
        closeIcon,
        decrement,
        email,
        envelope,
        error,
        facebook,
        facebookround,
        google,
        increment,
        messages,
        profileCircle,
        searchNormal
      ];
}

class Assets {
  Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
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

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
