import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:makaihealth/extensions/extensions.dart';
import 'package:makaihealth/gen/assets.gen.dart';
import 'package:makaihealth/utility/colors.dart';
import 'package:makaihealth/utility/dimension.dart';
import 'package:makaihealth/utility/text_styles.dart';
import 'package:makaihealth/widget/app_button.dart';
import 'package:makaihealth/widget/space_vertical.dart';

class LoginSignupScreen extends StatelessWidget {
  const LoginSignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(AppSize.w36),
        child: Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              Assets.images.svgs.makaiLogo.svg(
                  height: context.height * 0.20, width: context.height * 0.20),
              Text(
                'MAKAI',
                style: textSemiBold.copyWith(
                    color: AppColor.black, fontSize: AppSize.sp28),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SpaceV(AppSize.h20),
              Text(
                'Monitor your Health',
                style: textSemiBold.copyWith(
                    color: AppColor.black, fontSize: AppSize.sp32),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),

              Assets.json.womenDoingYoga.lottie(),
              // SpaceV(context.height * 0.10),
              AppButton(
                "Sign with number",
                () {
                  context.go('/EnterMobileNUmber');
                },
                textStyle: textSemiBold.copyWith(fontSize: AppSize.sp16),
                isDisabled: false,
              ),
              SpaceV(AppSize.h26),
              // RichText(
              //   text: TextSpan(
              //     children: [
              //       TextSpan(
              //         text: 'Dont have an account ? ',
              //         style: textSemiBold.copyWith(
              //           fontSize: AppSize.sp16,
              //           color: AppColor.black,
              //         ),
              //       ),
              //       TextSpan(
              //         text: 'sigh up',
              //         style: textSemiBold.copyWith(
              //             fontSize: AppSize.sp16,
              //             color: AppColor.textBlueColor),
              //       ),
              //     ],
              //   ),
              // )
            ])),
      ),
    );
  }
}
