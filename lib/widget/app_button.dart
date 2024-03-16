import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:makaihealth/utility/colors.dart';
import 'package:makaihealth/utility/logger.dart';
import 'package:makaihealth/utility/text_styles.dart';
import 'package:makaihealth/widget/loading.dart';
import 'package:makaihealth/widget/space_vertical.dart';

import '../utility/dimension.dart';

/*app button is widget which used in entire app for button usage in this
you will get all properties of buttons like color size border*/

class AppButton extends StatelessWidget {
  const AppButton(
    this.label,
    this.callback, {
    this.elevation = 0.0,
    super.key,
    this.height,
    this.width,
    this.radius,
    this.borderColor,
    this.padding,
    this.paddingFromRight,
    this.isIcon = false,
    this.isDisabled = false,
    this.color,
    this.textStyle,
    this.isSecondaryBackground = false,
    this.isLoading = false,
    this.optionFeedIcon = false,
    this.leadingIcon = false,
    this.isCenterTextImage = false,
    this.isGradient = false,
    this.image,
    this.transform,
    this.disabledColor,
  });

  final String label;
  final VoidCallback callback;
  final double? elevation;
  final double? height;
  final double? width;
  final double? radius;
  final double? padding;
  final double? paddingFromRight;
  final bool isDisabled;
  final bool isIcon;
  final bool isSecondaryBackground;
  final Color? color;
  final Color? borderColor;
  final TextStyle? textStyle;
  final bool isLoading;
  final bool optionFeedIcon;
  final String? image;
  final bool leadingIcon;
  final bool isCenterTextImage;
  final bool isGradient;
  final Matrix4? transform;
  final Color? disabledColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (width != null) ? width : double.infinity,
      height: height,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(
              radius ?? AppSize.rButton,
            ),
          ),
          gradient: isGradient
              ? const LinearGradient(
                  colors: [Color(0xFFFE0257), Color(0xFFFF00FF)],
                  stops: [0.15, 0.68],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )
              : null,
        ),
        child: MaterialButton(
          elevation: elevation,
          disabledColor: disabledColor ?? AppColor.buttonSecondaryColor,
          padding: isLoading
              ? EdgeInsets.symmetric(vertical: AppSize.h4)
              : EdgeInsets.symmetric(
                  vertical: (padding != null) ? padding ?? 0 : AppSize.h16),
          onPressed: isDisabled || isLoading
              ? null
              : () {
                  HapticFeedback.mediumImpact();
                  if (isRedundantClick(DateTime.now()) ||
                      isDisabled ||
                      isLoading) {
                    return;
                  }
                  callback();
                },
          color: isGradient
              ? Colors.transparent
              : isSecondaryBackground
                  ? color
                  : (isDisabled
                      ? disabledColor ?? AppColor.buttonSecondaryColor
                      : AppColor.appBackgroundBlueColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(radius ?? AppSize.rButton),
            ),
            side: BorderSide(
              color: isSecondaryBackground
                  ? (borderColor != null ? borderColor! : Colors.transparent)
                  : Colors.transparent,
            ),
          ),
          child: Stack(
            children: [
              if (isLoading)
                LoadingIndicator(height: AppSize.h48)
              else
                optionFeedIcon
                    ? _buildOptionFeedUI()
                    : leadingIcon
                        ? _leadingIconRow()
                        : Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: AppSize.w6),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (isIcon)
                                  Padding(
                                    padding:
                                        EdgeInsets.only(right: AppSize.w10),
                                    child: SvgPicture.asset(image!,
                                        height: AppSize.h24),
                                  )
                                else
                                  const SizedBox(),
                                Flexible(
                                  child: FittedBox(
                                    child: Text(
                                      textStyle != null ? label : label,
                                      style: textStyle ??
                                          textMedium.copyWith(
                                              fontSize: AppSize.sp16),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionFeedUI() {
    return Column(
      children: [
        SvgPicture.asset(image!, height: AppSize.h24),
        SpaceV(AppSize.h16),
        Text(
          textStyle != null ? label : label.toUpperCase(),
          style: textStyle ?? textBold.copyWith(fontSize: AppSize.sp16),
        ),
      ],
    );
  }

  Widget _leadingIconRow() {
    return Row(
      mainAxisAlignment: isCenterTextImage
          ? MainAxisAlignment.center
          : MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(left: AppSize.w16),
          child: SvgPicture.asset(image!, height: AppSize.h24),
        ),
        if (isCenterTextImage) 5.w.horizontalSpace,
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(right: 25),
            child: FittedBox(
              child: Container(
                transform: transform,
                child: Text(
                  textStyle != null ? label : label.toUpperCase(),
                  style: textStyle ?? textBold.copyWith(fontSize: AppSize.sp16),
                ),
              ),
            ),
          ),
        ),
        const SizedBox()
      ],
    );
  }
}

DateTime? loginClickTime;

bool isRedundantClick(DateTime currentTime) {
  if (loginClickTime == null) {
    loginClickTime = currentTime;
    'first click'.logD;
    return false;
  }
  'diff is ${currentTime.difference(loginClickTime ?? DateTime.now()).inSeconds}'
      .logD;
  if (currentTime.difference(loginClickTime ?? DateTime.now()).inSeconds < 1) {
    //set this difference time in seconds
    return true;
  }

  loginClickTime = currentTime;
  return false;
}
