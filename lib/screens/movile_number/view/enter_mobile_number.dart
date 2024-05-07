import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:makaihealth/extensions/extensions.dart';
import 'package:makaihealth/screens/login_signup/view/Verifyotp_screen.dart';
import 'package:makaihealth/utility/colors.dart';
import 'package:makaihealth/utility/dimension.dart';
import 'package:makaihealth/utility/logger.dart';
import 'package:makaihealth/utility/string_constants.dart';
import 'package:makaihealth/utility/text_styles.dart';
import 'package:makaihealth/utility/utility.dart';
import 'package:makaihealth/widget/app_button.dart';
import 'package:makaihealth/widget/space_vertical.dart';

class EnterMobileNUmber extends StatefulWidget {
  const EnterMobileNUmber({super.key});

  @override
  State<EnterMobileNUmber> createState() => _EnterMobileNUmberState();
}

class _EnterMobileNUmberState extends State<EnterMobileNUmber> {
  String phoneNumber = "";
  TextEditingController countryController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
bool check=false;
  @override
  void initState() {
    // TODO: implement initState
    countryController.text = "+91";
    super.initState();
  }

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
                  // Container(
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(AppSize.r16),
                  //     boxShadow: [
                  //       BoxShadow(
                  //         color: Colors.grey.withOpacity(0.5),
                  //         spreadRadius: 1,
                  //         blurRadius: 1,
                  //         offset: const Offset(0, 1),
                  //       ),
                  //     ],
                  //   ),
                  //   child: IntlPhoneField(
                  //     flagsButtonPadding: const EdgeInsets.only(left: 8),
                  //     dropdownIconPosition: IconPosition.trailing,
                  //     decoration: InputDecoration(
                  //         labelStyle: const TextStyle(color: Colors.blue),
                  //         suffixStyle: const TextStyle(color: Colors.blue),
                  //         floatingLabelStyle:
                  //             const TextStyle(color: Colors.blue),
                  //         helperStyle: const TextStyle(color: Colors.blue),
                  //         prefixStyle: const TextStyle(color: Colors.blue),
                  //         hintText: enterMobileNumber,
                  //         hintStyle: textRegular.copyWith(
                  //             color: AppColor.textHintColor,
                  //             fontSize: AppSize.sp14),
                  //         filled: true,
                  //         fillColor: Colors.grey.shade100,
                  //         border: OutlineInputBorder(
                  //           borderSide: BorderSide.none,
                  //           borderRadius:
                  //               BorderRadius.circular(AppSize.rTextField),
                  //         ),
                  //         counterText: ''),
                  //     initialCountryCode: 'IN',
                  //     style: textRegular.copyWith(
                  //         color: AppColor.textHintColor,
                  //         fontSize: AppSize.sp14),
                  //     onChanged: (phone) {
                  //       (phone.completeNumber).logD;
                  //     },
                  //   ),
                  // ),
                  Container(
                    height: 55,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          width: 40,
                          child: TextField(
                            controller: countryController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: InputBorder.none,

                            ),
                            readOnly: true,
                          ),
                        ),
                        const Text(
                          "|",
                          style: TextStyle(fontSize: 33, color: Colors.grey),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: TextField(
                          onChanged: (value) {
                            phoneNumber = value;
                          },
                          keyboardType: TextInputType.phone,
                          decoration:  InputDecoration(
                            border: InputBorder.none,
                            hintText: "Phone",
                            hintStyle:  textRegular.copyWith(
                              color: AppColor.black,
                            ),
                          ),
                        ))
                      ],
                    ),
                  ),
                  SpaceV(AppSize.h10),
                  Row(
                    children: [
                      Checkbox(
                        value: check,
                        activeColor: AppColor.primaryColor,
                        checkColor: AppColor.textColor,
                        onChanged: (value) {
                          setState(() {
                            check= value!;
                          });
                        },
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
                  SpaceV(context.height*0.10),
                  AppButton(
                    continueButton,
                        () async {
                     if(phoneNumber.isNotEmpty&&phoneNumber.length>=9) {
                       if(check) {
                         await FirebaseAuth.instance.verifyPhoneNumber(
                           phoneNumber: countryController.text + phoneNumber,
                           verificationCompleted:
                               (PhoneAuthCredential credential) async {
                             // ANDROID ONLY!

                             // Sign the user in (or link) with the auto-generated credential
                             // await auth.signInWithCredential(credential);
                           },
                           verificationFailed: (FirebaseAuthException e) {
                             if (e.code == 'invalid-phone-number') {
                               Utility.showToast(
                                   msg: 'The provided phone number is not valid.');
                             }

                             // Handle other errors
                           },
                           codeSent: (String verificationId, int? resendToken) {
                             Navigator.push(
                                 context,
                                 MaterialPageRoute(
                                     builder: (context) =>
                                         VerifyOtpScreen(
                                           verify: verificationId,
                                           mobile: phoneNumber,
                                         )));
                             // context.goNamed(
                             //   'VerifyOtpScreen?verify=$verificationId',
                             // );
                           },
                           codeAutoRetrievalTimeout: (String verificationId) {},
                         );
                       }else{
                         Utility.showToast(
                             msg: 'Please Select checkbox');
                       }
                     }else{
                       Utility.showToast(
                           msg: 'Please fill 10 digit mobile number');
                     }
                    },
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
