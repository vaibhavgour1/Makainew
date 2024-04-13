import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:makaihealth/utility/colors.dart';
import 'package:makaihealth/utility/dimension.dart';
import 'package:makaihealth/utility/logger.dart';
import 'package:makaihealth/utility/sharedpref.dart';
import 'package:makaihealth/utility/string_constants.dart';
import 'package:makaihealth/utility/text_styles.dart';
import 'package:makaihealth/utility/utility.dart';
import 'package:makaihealth/widget/app_button.dart';
import 'package:makaihealth/widget/space_vertical.dart';

class VerifyOtpScreen extends StatefulWidget {
  final String verify, mobile;

  const VerifyOtpScreen(
      {super.key, required this.verify, required this.mobile});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  String code = '';

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
                          color: AppColor.textHintColor,
                          fontSize: AppSize.sp22),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SpaceV(AppSize.h40),
                    Text(
                      verifyOtpDes + widget.mobile,
                      style: textMedium.copyWith(
                          color: AppColor.textHintColor,
                          fontSize: AppSize.sp18),
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
                        borderRadius: BorderRadius.circular(5),
                        fieldWidth: 40,
                        numberOfFields: 6,
                        filled: true,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        fillColor: Colors.white,
                        enabledBorderColor: AppColor.textFieldColor,
                        showFieldAsBox: true,
                        onSubmit: (String codex) {
                          code = codex;
                          code.logD;
                        },
                      ),
                    ),
                    SpaceV(AppSize.h40),

                    AppButton(
                      submitButton,
                      () async {
                        try {
                          '=====>'.logD;
                          widget.verify.logD;
                          code.logD;
                          PhoneAuthCredential credential =
                              PhoneAuthProvider.credential(
                                  verificationId: widget.verify, smsCode: code);

                          // Sign the user in (or link) with the credential

                          await auth.signInWithCredential(credential);
                          SharedPref.setBooleanPreference(
                              SharedPref.LOGIN, true);
                          SharedPref.setStringPreference(
                              SharedPref.MOBILE, widget.mobile);
                          context.go('/PatientInfoFormScreen');
                        } catch (e) {
                          Utility.showToast(
                              msg: e.toString());
                          SharedPref.setBooleanPreference(
                              SharedPref.LOGIN, false);
                          e.logD;
                        }

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
                              color: AppColor.textHintColor,
                              fontSize: AppSize.sp14),
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
        ),
        Positioned(
          top: AppSize.h80,
          left: AppSize.w16,
          child: SvgPicture.asset(
            "assets/images/svgs/backArrow.svg",
            color: AppColor.black,
          ),
        ),
      ],
    );
  }
}
