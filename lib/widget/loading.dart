



import 'package:flutter/material.dart';
import 'package:makaihealth/gen/assets.gen.dart';
import 'package:makaihealth/utility/dimension.dart';
//this widget is used for loading in application
class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key, this.height});

  LoadingIndicator.small({super.key}) : height = AppSize.h64;

  final double? height;

  @override
  Widget build(BuildContext context) {
    return Center(child: Assets.json.loader.lottie(height: height ?? AppSize.h100));
  }
}
