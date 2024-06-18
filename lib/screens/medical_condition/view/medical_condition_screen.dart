import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:makaihealth/gen/assets.gen.dart';
import 'package:makaihealth/utility/colors.dart';
import 'package:makaihealth/utility/dimension.dart';
import 'package:makaihealth/utility/logger.dart';
import 'package:makaihealth/utility/sharedpref.dart';
import 'package:makaihealth/utility/string_constants.dart';
import 'package:makaihealth/utility/text_styles.dart';
import 'package:makaihealth/widget/app_button.dart';
import 'package:makaihealth/widget/space_horizontal.dart';
import 'package:makaihealth/widget/space_vertical.dart';

class MedicalConditionScreen extends StatefulWidget {
  const MedicalConditionScreen({super.key});

  @override
  State<MedicalConditionScreen> createState() => _MedicalConditionScreenState();
}

class _MedicalConditionScreenState extends State<MedicalConditionScreen> {
  bool showMyCondition = false;
  bool showTextfieldButton = false;
  bool showPastDisease = false;
  bool showPastSurgery = false;
  Map<String, String> medicalConditionData = {};
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController pastDiseaseController = TextEditingController();
  final TextEditingController pastSurgeryController = TextEditingController();
  String search = '';
  String pastDisease = '';
  String pastSurgery = '';
  final List<Map<String, String>> addmymedicalCondition = [];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(AppSize.w8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            context.go('/PatientProfileScreen');
                          },
                          child: const Icon(
                            Icons.arrow_back,
                            color: AppColor.appbarBgColor,
                          ),
                        ),
                        SpaceH(AppSize.w40),
                        Text(
                          medicalCondition,
                          style: textSemiBold.copyWith(
                            color: AppColor.black,
                            fontSize: AppSize.sp22,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    SpaceV(AppSize.h40),
                    if (showMyCondition)
                      SizedBox(
                        height: (MediaQuery.of(context).size.width * 0.40),
                        child: ListView.builder(
                          shrinkWrap: true,

                          padding: EdgeInsets.zero,
                          itemCount: addmymedicalCondition.length,
                          itemBuilder: (BuildContext context, int index) {
                            var medicalCon = addmymedicalCondition[index];
                            return ListTile(
                              tileColor:
                              AppColor.chatBlueBgColor.withOpacity(.3),
                              leading:
                              Assets.images.svgs.medicalconditionMyconImg
                                  .svg(),
                              iconColor: AppColor.black,
                              title: Text(
                                medicalCon["name"]!,
                                style: textBold.copyWith(
                                  fontSize: AppSize.sp16,
                                  color: AppColor.black,
                                ),
                              ),
                              onTap: () {},
                            );
                          },
                        ),
                      ),
                    Center(
                      child: Text(
                        addCondition,
                        style: textBold.copyWith(
                          fontSize: AppSize.sp18,
                          color: AppColor.black,
                        ),
                      ),
                    ),
                    SpaceV(AppSize.h10),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          showTextfieldButton = true;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(0),
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.5,
                          ),
                        ),
                        child: TextFormField(
                          controller: _searchController,
                          onChanged: (String? value) {
                            setState(() {
                              showTextfieldButton = true;
                              search = value.toString();
                            });
                          },
                          decoration: const InputDecoration(
                            hintText: "Add your condition",
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14.0,
                              color: Colors.black,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 4,
                              horizontal: 8,
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (showTextfieldButton)
                      AppButton(
                        addCondition,
                            () {
                          setState(() {
                            showMyCondition = true;
                            addmymedicalCondition.add({"name": search});
                            _searchController.clear();
                            showTextfieldButton = false;
                          });
                        },
                        isDisabled: false,
                      ),
                    if (pastDisease.isNotEmpty)
                      ListTile(
                        leading:
                        Assets.images.svgs.medicalconditionMyconImg.svg(),
                        iconColor: AppColor.black,
                        title: Text(
                          pastDisease,
                          style: textBold.copyWith(
                            fontSize: AppSize.sp16,
                            color: AppColor.black,
                          ),
                        ),
                        onTap: () {},
                      ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          showPastDisease = true;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(0),
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.5,
                          ),
                        ),
                        child: TextFormField(
                          controller: pastDiseaseController,
                          onChanged: (String? value) {
                            setState(() {
                              showPastDisease = true;
                              pastDisease = value.toString();
                            });
                          },
                          decoration: const InputDecoration(
                            hintText: "Add your Past Disease",
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14.0,
                              color: Colors.black,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 4,
                              horizontal: 8,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    if (showPastDisease)
                      AppButton(
                        addCondition,
                            () {
                          setState(() {
                            showPastDisease = true;
                            pastDiseaseController.clear();
                            showPastDisease = false;
                          });
                        },
                        isDisabled: false,
                      ),
                    if (pastSurgery.isNotEmpty)
                      ListTile(
                        leading:
                        Assets.images.svgs.medicalconditionMyconImg.svg(),
                        iconColor: AppColor.black,
                        title: Text(
                          pastSurgery,
                          style: textBold.copyWith(
                            fontSize: AppSize.sp16,
                            color: AppColor.black,
                          ),
                        ),
                        onTap: () {},
                      ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          showPastSurgery = true;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(0),
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.5,
                          ),
                        ),
                        child: TextFormField(
                          controller: pastSurgeryController,
                          onChanged: (String? value) {
                            setState(() {
                              showPastSurgery = true;
                              pastSurgery = value.toString();
                            });
                          },
                          decoration: const InputDecoration(
                            hintText: "Add your Past Surgery",
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14.0,
                              color: Colors.black,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 4,
                              horizontal: 8,
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (showPastSurgery)
                      AppButton(
                        addCondition,
                            () {
                          setState(() {
                            showPastSurgery = true;
                            pastSurgeryController.clear();
                            showPastSurgery = false;
                          });
                        },
                        isDisabled: false,
                      ),
                    SpaceV(AppSize.h20),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: MediaQuery.of(context).size.height * 0.02,
          left: MediaQuery.of(context).size.width * 0.07,
          right: MediaQuery.of(context).size.width * 0.07,
          child: AppButton(
            showMyCondition ? submitButton : selectCondition,
                () async {
              if (showMyCondition) {
                List<String> valuesList = addmymedicalCondition
                    .map((map) => map["name"]!)
                    .toList();
                DateTime now = DateTime.now();
                String timestamp = now.microsecondsSinceEpoch.toString();
                setState(() {
                  showTextfieldButton = false;
                  showMyCondition = false;
                });
                medicalConditionData['ConditionType'] = valuesList.join(', ');
                medicalConditionData['PastDisease'] = pastDisease;
                medicalConditionData['SurgeryInformation'] = pastSurgery;
                medicalConditionData['ConditionId'] = timestamp;
                await storeData(
                  await SharedPref.getStringPreference(SharedPref.MOBILE),
                  medicalConditionData,
                );
                retrieveData(
                  await SharedPref.getStringPreference(SharedPref.MOBILE),
                ).then((value) {
                  value.logD;
                  context.go('/HomeView');
                });
              } else {
                setState(() {
                  showMyCondition = true;
                });
              }
            },
            isDisabled: false,
          ),
        ),
      ],
    );
  }

  Future<Map<String, dynamic>?> retrieveData(String mobileNumber) async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('medicalCondition')
          .doc(mobileNumber)
          .get();
      if (snapshot.exists) {
        snapshot.data().logD;
        return snapshot.data() as Map<String, dynamic>;
      } else {
        ('No data found for mobile number: $mobileNumber').logD;
        return null;
      }
    } catch (e) {
      ('Error retrieving data: $e').logD;
      return null;
    }
  }

  Future<void> storeData(String mobileNumber, Map<String, dynamic> data) async {
    try {
      await FirebaseFirestore.instance
          .collection('medicalCondition')
          .doc(mobileNumber)
          .set(data);
      ('Data stored successfully for mobile number: $mobileNumber').logD;
    } catch (e) {
      ('Error storing data: $e').logD;
    }
  }
}
