import 'dart:developer';


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:makaihealth/data/user_profile_model.dart';



class HomeController extends GetxController {
  Rx<UserProfileModel> userProfileModel = UserProfileModel().obs;
  final GlobalKey<ScaffoldState> drawerKey = GlobalKey<ScaffoldState>();

  @override
  void onInit() {
    //userProfile();
    super.onInit();
  }

/*  Future<void> userProfile() async {
    try {
      userProfileModel.value = await AuthsService.userProfile();
      await SharedPrefs.setString(
          key: AppString.userId, value: userProfileModel.value.data?.id ?? '');
      log("userProfile response 00: ${userProfileModel.value.toJson()}");
    } catch (e, st) {
      log("userProfile Error Message: $e : $st");
    }
  }*/

  // Future<void> userProfile() async {
  //   try {
  //     String mobile = SharedPrefs.getString(key: AppString.userMobile);
  //     userProfileModel.value = await AuthsService.patientProfile(mobile);
  //     await SharedPrefs.setString(key: AppString.userId, value: userProfileModel.value.data?.id ?? '');
  //     log("userProfile response 00: ${userProfileModel.value.toJson()}");
  //   } catch (e, st) {
  //     log("userProfile Error Message: $e : $st");
  //   }
  // }
}
