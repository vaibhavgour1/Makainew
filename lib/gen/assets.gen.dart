/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

class $AssetsGifGen {
  const $AssetsGifGen();

  /// File path: assets/gif/yoga.gif
  AssetGenImage get yoga => const AssetGenImage('assets/gif/yoga.gif');

  /// List of all assets
  List<AssetGenImage> get values => [yoga];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  $AssetsImagesSvgsGen get svgs => const $AssetsImagesSvgsGen();
}

class $AssetsJsonGen {
  const $AssetsJsonGen();

  /// File path: assets/json/loader.json
  LottieGenImage get loader => const LottieGenImage('assets/json/loader.json');

  /// File path: assets/json/women-doing-yoga.json
  LottieGenImage get womenDoingYoga => const LottieGenImage('assets/json/women-doing-yoga.json');

  /// List of all assets
  List<LottieGenImage> get values => [loader, womenDoingYoga];
}

class $AssetsImagesSvgsGen {
  const $AssetsImagesSvgsGen();

  /// File path: assets/images/svgs/Vector.svg
  SvgGenImage get vector => const SvgGenImage('assets/images/svgs/Vector.svg');

  /// File path: assets/images/svgs/amico.svg
  SvgGenImage get amico => const SvgGenImage('assets/images/svgs/amico.svg');

  /// File path: assets/images/svgs/capsul.svg
  SvgGenImage get capsul => const SvgGenImage('assets/images/svgs/capsul.svg');

  /// File path: assets/images/svgs/cycleSplash.svg
  SvgGenImage get cycleSplash => const SvgGenImage('assets/images/svgs/cycleSplash.svg');

  /// File path: assets/images/svgs/doctor.svg
  SvgGenImage get doctor => const SvgGenImage('assets/images/svgs/doctor.svg');

  /// File path: assets/images/svgs/doctorSplash.svg
  SvgGenImage get doctorSplash => const SvgGenImage('assets/images/svgs/doctorSplash.svg');

  /// File path: assets/images/svgs/makaiLogo.svg
  SvgGenImage get makaiLogo => const SvgGenImage('assets/images/svgs/makaiLogo.svg');

  /// File path: assets/images/svgs/rafiki.svg
  SvgGenImage get rafiki => const SvgGenImage('assets/images/svgs/rafiki.svg');

  /// File path: assets/images/svgs/robot.svg
  SvgGenImage get robot => const SvgGenImage('assets/images/svgs/robot.svg');

  /// File path: assets/images/svgs/running.svg
  SvgGenImage get running => const SvgGenImage('assets/images/svgs/running.svg');

  /// List of all assets
  List<SvgGenImage> get values =>
      [vector, amico, capsul, cycleSplash, doctor, doctorSplash, makaiLogo, rafiki, robot, running];
}

class Assets {
  Assets._();

  static const $AssetsGifGen gif = $AssetsGifGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsJsonGen json = $AssetsJsonGen();
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

class SvgGenImage {
  const SvgGenImage(this._assetName);

  final String _assetName;

  SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    SvgTheme theme = const SvgTheme(),
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    return SvgPicture.asset(
      _assetName,
      key: key,
      matchTextDirection: matchTextDirection,
      bundle: bundle,
      package: package,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      theme: theme,
      colorFilter: colorFilter,
      color: color,
      colorBlendMode: colorBlendMode,
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class LottieGenImage {
  const LottieGenImage(this._assetName);

  final String _assetName;

  LottieBuilder lottie({
    Animation<double>? controller,
    bool? animate,
    FrameRate? frameRate,
    bool? repeat,
    bool? reverse,
    LottieDelegates? delegates,
    LottieOptions? options,
    void Function(LottieComposition)? onLoaded,
    LottieImageProviderFactory? imageProviderFactory,
    Key? key,
    AssetBundle? bundle,
    Widget Function(BuildContext, Widget, LottieComposition?)? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    double? width,
    double? height,
    BoxFit? fit,
    AlignmentGeometry? alignment,
    String? package,
    bool? addRepaintBoundary,
    FilterQuality? filterQuality,
    void Function(String)? onWarning,
  }) {
    return Lottie.asset(
      _assetName,
      controller: controller,
      animate: animate,
      frameRate: frameRate,
      repeat: repeat,
      reverse: reverse,
      delegates: delegates,
      options: options,
      onLoaded: onLoaded,
      imageProviderFactory: imageProviderFactory,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      package: package,
      addRepaintBoundary: addRepaintBoundary,
      filterQuality: filterQuality,
      onWarning: onWarning,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
