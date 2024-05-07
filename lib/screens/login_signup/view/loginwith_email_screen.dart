import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:makaihealth/utility/colors.dart';
import 'package:makaihealth/utility/dimension.dart';
import 'package:makaihealth/utility/string_constants.dart';
import 'package:makaihealth/utility/text_styles.dart';
import 'package:makaihealth/widget/app_button.dart';
import 'package:makaihealth/widget/space_vertical.dart';
import 'package:makaihealth/widget/text_form_filed.dart';

class LoginwithEmailScreen extends StatefulWidget {
  const LoginwithEmailScreen({super.key});

  @override
  State<LoginwithEmailScreen> createState() => _LoginwithEmailScreenState();
}

class _LoginwithEmailScreenState extends State<LoginwithEmailScreen> {
  bool mpinVisible = false;
  bool option1 = false;
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
                      welcomeBack,
                      style: textSemiBold.copyWith(
                          color: AppColor.black, fontSize: AppSize.sp22),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SpaceV(AppSize.h40),
                    Text(
                      letsBeHealthy,
                      style: textMedium.copyWith(
                          color: AppColor.black,
                          fontSize: AppSize.sp30,
                          fontWeight: FontWeight.w600),
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SpaceV(AppSize.h40),
                    AppTextField(
                      label: 'Email',
                      hint: 'Enter email',
                      prefixIcon: const Icon(Icons.email),
                      //controller: '',
                      // validators: (value) {
                      //   return null;
                      // },
                      textStyle: textRegular.copyWith(
                          fontSize: AppSize.sp12,
                          color: AppColor.colorHint,
                          fontWeight: FontWeight.w500),
                      keyboardType: TextInputType.emailAddress,
                    ),

                    SpaceV(AppSize.h20),
                    TextFormField(
                      obscureText: mpinVisible,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: AppColor.colorHint),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: AppColor.colorHint, width: 2)),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: AppColor.errorColor),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: AppColor.errorColor),
                        ),
                        errorStyle: const TextStyle(color: AppColor.errorColor),
                        labelText: "Password",
                        labelStyle: textRegular.copyWith(
                          fontSize: AppSize.sp12,
                          color: AppColor.colorHint,
                          fontWeight: FontWeight.w500,
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(mpinVisible
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              mpinVisible = !mpinVisible;
                            });
                          },
                        ),
                        alignLabelWithHint: false,
                        filled: true,
                        fillColor: AppColor.textColor,
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'please enter password';
                        }
                        return null;
                      },
                    ),
                    SpaceV(AppSize.h10),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            buildCheckboxRow('', option1, (value) {
                              setState(() {
                                option1 = value!;
                                updateSelectedOptions();
                              });
                            }),
                            Text(
                              rememberMe,
                              style: textRegular.copyWith(
                                  color: AppColor.textColorSecondary,
                                  fontSize: AppSize.sp12),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        Text(
                          forgetPassword,
                          style: textRegular.copyWith(
                              color: AppColor.textHintColor,
                              fontSize: AppSize.sp12),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    SpaceV(AppSize.h40),

                    AppButton(
                      loginButton,
                      () {
                        context.go('/PatientInfoFormScreen');
                      },
                      isDisabled: false,
                    ),
                    SpaceV(AppSize.h20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset("assets/images/svgs/googleImg.svg"),
                        SizedBox(width: AppSize.w12,),
                        Text(
                          continueWithGoogle
                          ,
                          style: textSemiBold.copyWith(
                              color: Colors.grey,
                              fontSize: AppSize.sp12),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),

                    SpaceV(AppSize.h40),

                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   crossAxisAlignment: CrossAxisAlignment.center,
                    //   children: [
                    //     Text(
                    //       dontHaveanAccount,
                    //       style: textRegular.copyWith(
                    //           color: AppColor.textColorSecondary,
                    //           fontSize: AppSize.sp12,
                    //           fontWeight: FontWeight.w400),
                    //       maxLines: 1,
                    //       overflow: TextOverflow.ellipsis,
                    //     ),
                    //     Text(
                    //       signup,
                    //       style: textMedium.copyWith(
                    //           color: AppColor.textHintColor,
                    //           fontSize: AppSize.sp12),
                    //       maxLines: 1,
                    //       overflow: TextOverflow.ellipsis,
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
        //   Positioned(
        //   top: 10,
        //   left: 15,
        //   child: GestureDetector(
        //    // onTap: ,
        //     child: SvgPicture.asset(
        //       'assets/images/svgs/backArrow.svg',
        //       color: AppColor.textHintColor,
        //       height: 20,
        //       width: 20,
        //     ),
        //   ),
        // ),
      ],
    );
  }

  void updateSelectedOptions() {
    // Add more options as needed
  }

  Row buildCheckboxRow(
      String label, bool value, ValueChanged<bool?> onChanged) {
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
          activeColor: AppColor.textGreenColor,
        ),
        //Text(label),
      ],
    );
  }
}
