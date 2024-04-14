import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:makaihealth/gen/assets.gen.dart';
import 'package:makaihealth/utility/colors.dart';
import 'package:makaihealth/utility/dimension.dart';
import 'package:makaihealth/utility/string_constants.dart';
import 'package:makaihealth/utility/text_styles.dart';
import 'package:makaihealth/widget/space_horizontal.dart';
import 'package:makaihealth/widget/space_vertical.dart';

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
                  SpaceV(AppSize.h160),
                  Center(
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/images/png/EditProfileImage.png",
                          fit: BoxFit.contain,
                          // width:
                          //     MediaQuery.of(context).size.width * 0.14,
                        ),
                        SpaceV(AppSize.h10),
                        Text(
                          sahilChaure,
                          style: textBold.copyWith(
                              fontSize: AppSize.sp18, color: AppColor.black),
                        ),
                        Text(
                          sahilChaureEmail,
                          style: textRegular.copyWith(
                              fontSize: AppSize.sp14, color: AppColor.black),
                        )
                      ],
                    ),
                  ),
                  SpaceV(AppSize.h16),
                  Card(
                    color: Colors.white,
                    elevation: 4,
                    shadowColor: AppColor.textColor,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              context.go('/UserProfileHomeScreen');
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Assets.images.svgs.profileLine.svg(),
                                SpaceH(AppSize.w14),
                                Text(
                                  editProfileInformation,
                                  style: textRegular.copyWith(
                                      fontSize: AppSize.sp12,
                                      color: AppColor.black),
                                )
                              ],
                            ),
                          ),
                          SpaceV(AppSize.h12),
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
                                    Assets.images.svgs.notificationLine.svg(),
                                    SpaceH(AppSize.w14),
                                    Text(
                                      notifications,
                                      style: textRegular.copyWith(
                                          fontSize: AppSize.sp12,
                                          color: AppColor.black),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                on,
                                style: textRegular.copyWith(
                                    fontSize: AppSize.sp12,
                                    color: AppColor.textBlueColor),
                              )
                            ],
                          ),
                          SpaceV(AppSize.h12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Assets.images.svgs.translateLanguage.svg(),
                                  SpaceH(AppSize.w14),
                                  Text(
                                    language,
                                    style: textRegular.copyWith(
                                        fontSize: AppSize.sp12,
                                        color: AppColor.black),
                                  ),
                                ],
                              ),
                              Text(
                                english,
                                style: textRegular.copyWith(
                                    fontSize: AppSize.sp12,
                                    color: AppColor.textBlueColor),
                              )
                            ],
                          ),
                          SpaceV(AppSize.h12),
                          GestureDetector(
                            onTap: () {
                              context.go('/MedicalConditionScreen');
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Assets.images.svgs.translateLanguage.svg(),
                                SpaceH(AppSize.w14),
                                Text(
                                  medicalCondition,
                                  style: textRegular.copyWith(
                                      fontSize: AppSize.sp12,
                                      color: AppColor.black),
                                ),
                              ],
                            ),
                          ),
                          SpaceV(AppSize.h12),
                          GestureDetector(
                            onTap: () {
                              context.go('/DoctorInfoScreen');
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Assets.images.svgs.translateLanguage.svg(),
                                SpaceH(AppSize.w14),
                                Text(
                                  medicinesName,
                                  style: textRegular.copyWith(
                                      fontSize: AppSize.sp12,
                                      color: AppColor.black),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SpaceV(AppSize.h10),
                  Card(
                    color: Colors.white,
                    elevation: 4,
                    shadowColor: AppColor.textColor,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Assets.images.svgs.securitmg.svg(),
                              SpaceH(AppSize.w14),
                              Text(
                                security,
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
                  SpaceV(AppSize.h10),
                  Card(
                    color: Colors.white,
                    elevation: 4,
                    shadowColor: AppColor.textColor,
                    child: Padding(
                      padding: EdgeInsets.all(
                        AppSize.w16,
                      ),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Assets.images.svgs.contactsLine.svg(),
                              SpaceH(AppSize.w14),
                              Text(
                                helpSupport,
                                style: textRegular.copyWith(
                                    fontSize: AppSize.sp12,
                                    color: AppColor.black),
                              )
                            ],
                          ),
                          SpaceV(AppSize.h12),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Assets.images.svgs.chatQuoteLine.svg(),
                              SpaceH(AppSize.w14),
                              Text(
                                contactUs,
                                style: textRegular.copyWith(
                                    fontSize: AppSize.sp12,
                                    color: AppColor.black),
                              ),
                            ],
                          ),
                          SpaceV(AppSize.h12),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Assets.images.svgs.lock2Line.svg(),
                              SpaceV(AppSize.h14),
                              Text(
                                privacyPolicy,
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
          child: Assets.images.svgs.profileConImg.svg(),
        ),
        Positioned(
          top: AppSize.h80,
          left: AppSize.w16,
          child: GestureDetector(
              onTap: () {
                context.go('/PatientInfoFormScreen');
              },
              child:
                  const Icon(Icons.arrow_back, color: AppColor.appbarBgColor)),
        ),
        Positioned(
            top: AppSize.h86,
            right: AppSize.w16,
            child: Row(
              children: [
                Assets.images.svgs.historyFill.svg(),
                SpaceH(AppSize.w16),
                Assets.images.svgs.threeDottedprofile.svg(),
              ],
            )),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.32,
          right: MediaQuery.of(context).size.height * 0.15,
          child: GestureDetector(
              onTap: () {
                context.go('/EditProfileScreen');
              },
              child: Assets.images.svgs.editProfileimg.svg()),
        )
      ],
    );
  }
}
