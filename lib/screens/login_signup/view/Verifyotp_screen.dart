import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:makaihealth/utility/colors.dart';
import 'package:makaihealth/utility/dimension.dart';
import 'package:makaihealth/utility/string_constants.dart';
import 'package:makaihealth/utility/text_styles.dart';
import 'package:makaihealth/widget/app_button.dart';
import 'package:makaihealth/widget/space_vertical.dart';

class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({super.key});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(AppSize.w36),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_back,color: AppColor.black,)),
                      SpaceV(AppSize.h40),
                      Text(
                        verification,
                        style: textSemiBold.copyWith(
                            color: AppColor.textHintColor, fontSize: AppSize.sp22),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SpaceV(AppSize.h40),
                      Text(
                        verifyOtpDes,
                        style: textMedium.copyWith(
                            color: AppColor.textHintColor, fontSize: AppSize.sp18),
                        maxLines: 3,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SpaceV(AppSize.h40),
                    
                      SizedBox(
                          height: 50,
                          child: OtpTextField(
                          
                            cursorColor: AppColor.black,
                            focusedBorderColor: AppColor.textFieldColor,
                            borderRadius: BorderRadius.circular(10),
                            fieldWidth: 50,
                            numberOfFields: 4,
                            filled: true,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            fillColor: Colors.white,
                            enabledBorderColor: AppColor.textFieldColor,

                           
                            showFieldAsBox: true,
                            
                            onCodeChanged: (String code) {
                            
                            },
                            
                          ),
                        ),
                      SpaceV(AppSize.h40),
                      
                      AppButton(
                        submitButton,
                        () {
                           context.go('/LoginwithEmailScreen');
                        },
                        isDisabled: false,
                      ),
                      SpaceV(AppSize.h14),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            donGetCode,
                            style: textRegular.copyWith(
                                color: AppColor.textHintColor, fontSize: AppSize.sp14),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            tryAgain,
                            style: textRegular.copyWith(
                                color: AppColor.black, fontSize: AppSize.sp14),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      
                    ],
                  ),
                ),
              ),
              
            ),
            )
            ,
         Positioned(
          top: AppSize.h80,
          left: AppSize.w16,
          child:SvgPicture.asset("assets/images/svgs/backArrow.svg",color: AppColor.black,),),

            
      ],
    );
  }
}
