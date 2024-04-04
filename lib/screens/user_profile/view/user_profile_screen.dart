import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:go_router/go_router.dart';
import 'package:makaihealth/extensions/extensions.dart';
import 'package:makaihealth/utility/colors.dart';
import 'package:makaihealth/utility/dimension.dart';
import 'package:makaihealth/utility/string_constants.dart';
import 'package:makaihealth/utility/text_styles.dart';
import 'package:makaihealth/widget/app_button.dart';
import 'package:makaihealth/widget/space_vertical.dart';
import 'package:makaihealth/widget/text_form_filed.dart';

class PatientProfileScreen extends StatefulWidget {
  const PatientProfileScreen({super.key});

  @override
  State<PatientProfileScreen> createState() => _PatientProfileScreenState();
}

class _PatientProfileScreenState extends State<PatientProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                children: [
                  SizedBox(
                    height: AppSize.h260,
                  ),
                  Center(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                             
                              context.go('/EditProfileScreen');
                          
                          },
                          child: SvgPicture.asset(
                            "assets/images/svgs/editProfileimg.svg",
                          ),
                        ),
                        Text(
                          "sahil chaure",
                          style: textBold.copyWith(
                              fontSize: AppSize.sp18, color: AppColor.black),
                        ),
                        Text(
                          "sahilchaurr1999@gmai.com| +91 234 ",
                          style: textRegular.copyWith(
                              fontSize: AppSize.sp14, color: AppColor.black),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: AppSize.h16,
                  ),
                  Card(
                    color: Colors.white,
                    elevation: 4,
                    shadowColor: AppColor.textColor,
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                               context.go('/UserProfileHomeScreen');
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SvgPicture.asset(
                                    "assets/images/svgs/profile-line.svg"),
                                SizedBox(
                                  width: AppSize.w14,
                                ),
                                Text(
                                  "Edit profile information",
                                  style: textRegular.copyWith(
                                      fontSize: AppSize.sp12,
                                      color: AppColor.black),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: AppSize.h12,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                   context.go('/NotificationScreen');
                                },
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SvgPicture.asset(
                                        "assets/images/svgs/notification-line.svg"),
                                    SizedBox(
                                      width: AppSize.w14,
                                    ),
                                    Text(
                                      "Notifications",
                                      style: textRegular.copyWith(
                                          fontSize: AppSize.sp12,
                                          color: AppColor.black),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                "ON",
                                style: textRegular.copyWith(
                                    fontSize: AppSize.sp12,
                                    color: AppColor.textBlueColor),
                              )
                            ],
                          ),
                          SizedBox(
                            height: AppSize.h12,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SvgPicture.asset(
                                      "assets/images/svgs/translateLanguage.svg"),
                                  SizedBox(
                                    width: AppSize.w14,
                                  ),
                                  Text(
                                    "Language",
                                    style: textRegular.copyWith(
                                        fontSize: AppSize.sp12,
                                        color: AppColor.black),
                                  ),
                                ],
                              ),
                              Text(
                                "English",
                                style: textRegular.copyWith(
                                    fontSize: AppSize.sp12,
                                    color: AppColor.textBlueColor),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: AppSize.h10,
                  ),
                  Card(
                    color: Colors.white,
                    elevation: 4,
                    shadowColor: AppColor.textColor,
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                  "assets/images/svgs/securitmg.svg"),
                              SizedBox(
                                width: AppSize.w14,
                              ),
                              Text(
                                "Security",
                                style: textRegular.copyWith(
                                    fontSize: AppSize.sp12,
                                    color: AppColor.black),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: AppSize.h10,
                  ),
                  Card(
                    color: Colors.white,
                    elevation: 4,
                    shadowColor: AppColor.textColor,
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                  "assets/images/svgs/contacts-line.svg"),
                              SizedBox(
                                width: AppSize.w14,
                              ),
                              Text(
                                "Help & Support",
                                style: textRegular.copyWith(
                                    fontSize: AppSize.sp12,
                                    color: AppColor.black),
                              )
                            ],
                          ),
                          SizedBox(
                            height: AppSize.h12,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                  "assets/images/svgs/chat-quote-line.svg"),
                              SizedBox(
                                width: AppSize.w14,
                              ),
                              Text(
                                "Contact us",
                                style: textRegular.copyWith(
                                    fontSize: AppSize.sp12,
                                    color: AppColor.black),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: AppSize.h12,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                  "assets/images/svgs/lock-2-line.svg"),
                              SizedBox(
                                width: AppSize.w14,
                              ),
                              Text(
                                "Privacy policy",
                                style: textRegular.copyWith(
                                    fontSize: AppSize.sp12,
                                    color: AppColor.black),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )),
          ),
        ),
        Positioned(
          child: SvgPicture.asset(
            "assets/images/svgs/profileConImg.svg",
          ),
        ),
        Positioned(
          top: AppSize.h80,
          left: AppSize.w16,
          child: GestureDetector(
            onTap: () {
               context.go('/PatientInfoFormScreen');
            },
            child: SvgPicture.asset(
              "assets/images/svgs/backArrow.svg",
              color: AppColor.black,
            ),
          ),
        ),
        Positioned(
            top: AppSize.h86,
            right: AppSize.w16,
            child: Row(
              children: [
                SvgPicture.asset(
                  "assets/images/svgs/historyFill.svg",
                  color: AppColor.black,
                ),
                SizedBox(
                  width: AppSize.w16,
                ),
                SvgPicture.asset(
                  "assets/images/svgs/threeDottedprofile.svg",
                  color: AppColor.black,
                ),
              ],
            ))
      ],
    );
  }
}
