import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:makaihealth/utility/colors.dart';
import 'package:makaihealth/utility/dimension.dart';
import 'package:makaihealth/utility/string_constants.dart';
import 'package:makaihealth/utility/text_styles.dart';
import 'package:makaihealth/widget/app_button.dart';
import 'package:makaihealth/widget/space_vertical.dart';

class EnterMobileNUmber extends StatefulWidget {
  const EnterMobileNUmber({super.key});

  @override
  State<EnterMobileNUmber> createState() => _EnterMobileNUmberState();
}

class _EnterMobileNUmberState extends State<EnterMobileNUmber> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    sendCode,
                    style: textSemiBold.copyWith(
                        color: AppColor.black, fontSize: AppSize.sp22),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SpaceV(AppSize.h40),
                  Text(
                    pleaseEnterYour,
                    style: textMedium.copyWith(
                        color: AppColor.black, fontSize: AppSize.sp18),
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SpaceV(AppSize.h40),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSize.r16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: IntlPhoneField(
                      flagsButtonPadding: const EdgeInsets.only(left: 8),
                      dropdownIconPosition: IconPosition.trailing,

                      decoration: InputDecoration(
                          labelStyle: const TextStyle(color: Colors.blue),
                          suffixStyle: const TextStyle(color: Colors.blue),
                          floatingLabelStyle: const TextStyle(color: Colors.blue),
                          helperStyle:  const TextStyle(color: Colors.blue),
                          prefixStyle:  const TextStyle(color: Colors.blue),



                          hintText: enterMobileNumber,
                          hintStyle: textRegular.copyWith(
                              color: AppColor.textHintColor,
                              fontSize: AppSize.sp14),
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.circular(AppSize.rTextField),
                          ),
                          counterText: ''),
                      initialCountryCode: 'IN',
                      style: textRegular.copyWith(
                          color: AppColor.textHintColor,
                          fontSize: AppSize.sp14),
                      onChanged: (phone) {
                        print(phone.completeNumber);
                      },
                    ),
                  ),
                  SpaceV(AppSize.h40),
                  Row(
                    children: [
                      Checkbox(
                        value: false,
                        activeColor: AppColor.primaryColor,
                        checkColor: AppColor.textColor,
                        onChanged: (value) {},
                      ),
                      Text(
                        termCondition,
                        style: textRegular.copyWith(
                          color: AppColor.black,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  AppButton(
                    continueButton,
                    () {},
                    isDisabled: false,
                  ),
                  Text(
                    youWillReceive,
                    style: textRegular.copyWith(
                        color: AppColor.black, fontSize: AppSize.sp14),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
