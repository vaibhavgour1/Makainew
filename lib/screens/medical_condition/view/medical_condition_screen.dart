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
  Map<String, String> medicalConditionData = {};
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController pastDiseaseController = TextEditingController();
  final TextEditingController pastSurgeryController = TextEditingController();
  String search = '', pastDisease = '', pastSurgery = '';
  String putData = '';

  final List<Map<String, String>> addmymedicalCondition = [];

  @override
  Widget build(BuildContext context) {
    String filterText = '';

    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(AppSize.w36),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SpaceV(AppSize.h40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                            onTap: () {
                              context.go('/PatientProfileScreen');
                            },
                            child: const Icon(Icons.arrow_back,
                                color: AppColor.appbarBgColor)),
                        SpaceH(AppSize.w40),
                        Text(
                          medicalCondition,
                          style: textSemiBold.copyWith(
                              color: AppColor.black, fontSize: AppSize.sp22),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    SpaceV(AppSize.h40),
                    if (showMyCondition)
                      Column(
                        children: [
                          Text(
                            myCondition,
                            style: textSemiBold.copyWith(
                                color: AppColor.black, fontSize: AppSize.sp22),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                          ),
                          SpaceV(AppSize.h10),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.18,
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: addmymedicalCondition.length,
                              itemBuilder: (BuildContext context, int index) {
                                var medicalCon = addmymedicalCondition[index];

                                // if (filterText.isEmpty ||
                                //     medicalCon["name"]!
                                //         .toLowerCase()
                                //         .contains(filterText)) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ListTile(
                                      leading: Assets
                                          .images.svgs.medicalconditionMyconImg
                                          .svg(),
                                      iconColor: AppColor.black,
                                      title: Text(
                                        medicalCon["name"]!,
                                        style: textBold.copyWith(
                                            fontSize: AppSize.sp14,
                                            color: AppColor.black),
                                      ),
                                      onTap: () {},
                                    ),
                                  ],
                                );
                                // } else {
                                //   return Container();
                                // }
                              },
                            ),
                          ),
                          SpaceV(AppSize.h12),
                        ],
                      ),
                    GestureDetector(
                      onTap: () {},
                      child: Center(
                        child: Text(
                          addCondition,
                          style: textBold.copyWith(
                            fontSize: AppSize.sp18,
                            color: AppColor.black,
                          ),
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
                        child: Row(
                          children: [
                            // Padding(
                            //   padding: const EdgeInsets.only(left: 10),
                            //   child: Icon(
                            //     Icons.search,
                            //     color: Colors.black,
                            //   ),
                            // ),
                            SpaceH(AppSize.w10),
                            Expanded(
                              child: Column(
                                children: [
                                  TextFormField(
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
                                    ),
                                  ),
                                  TextFormField(
                                    controller: pastDiseaseController,
                                    onChanged: (String? value) {
                                      setState(() {
                                        showTextfieldButton = true;
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
                                      border: InputBorder.none,
                                    ),
                                  ),
                                  TextFormField(
                                    controller: pastSurgeryController,
                                    onChanged: (String? value) {
                                      setState(() {
                                        showTextfieldButton = true;
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
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SpaceV(AppSize.h20),
                    if (showTextfieldButton)
                      Column(
                        children: [
                          AppButton(
                            addCondition,
                            () {
                              setState(() {
                                showMyCondition = true;

                                addmymedicalCondition.add({
                                  "name": search,
                                });

                                _searchController.clear();

                                showTextfieldButton = false;
                              });
                            },
                            isDisabled: false,
                          ),
                        ],
                      ),
                    SpaceV(AppSize.h20),
                    // if(showMyCondition)
                    // SizedBox(
                    //   height: MediaQuery.of(context).size.height * 0.27,
                    //   child: ListView.builder(
                    //     itemCount: addmedicalCondition.length,
                    //     itemBuilder: (BuildContext context, int index) {
                    //       var medicalCon = addmedicalCondition[index];
                    //       return Column(
                    //         children: [
                    //           ListTile(
                    //             leading: Assets.images.svgs.medicalCon.svg(),
                    //             iconColor: AppColor.black,
                    //             title: Text(
                    //               medicalCon["name"]!,
                    //               style: textBold.copyWith(
                    //                 fontSize: AppSize.sp14,
                    //                 color: AppColor.black,
                    //               ),
                    //             ),
                    //             onTap: () {
                    //                setState(() {
                    //                 putData = medicalCon["name"]!;

                    //                 addmymedicalCondition.add({
                    //                   "name": medicalCon["name"]!,
                    //                 });
                    //                 addmymedicalCondition.add({
                    //                   "name": search,
                    //                 });
                    //                 addmedicalCondition.add({
                    //                   "name": search,
                    //                 });
                    //                 _searchController.clear();
                    //                });
                    //             },
                    //           ),
                    //         ],
                    //       );
                    //     },
                    //   ),
                    // ),
                    SpaceV(AppSize.h40),
                  ],
                ),
              ),
            ),
          ),
        ),
        if (showMyCondition == false)
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.02,
            left: MediaQuery.of(context).size.width * 0.07,
            right: MediaQuery.of(context).size.width * 0.07,
            child: AppButton(
              selectCondition,
              () {
                setState(() {
                  showMyCondition = false;
                });
              },
              isDisabled: false,
            ),
          )
        else
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.02,
            left: MediaQuery.of(context).size.width * 0.07,
            right: MediaQuery.of(context).size.width * 0.07,
            child: AppButton(
              submitButton,
              () async {
                addmymedicalCondition.toString().logD;
                List<String> valuesList = addmymedicalCondition
                    .map((map) => map.values)
                    .expand((values) => values)
                    .toList();
                DateTime now = DateTime.now();
                String timestamp = now.microsecondsSinceEpoch.toString();
                setState(() {
                  showTextfieldButton = false;
                  showMyCondition = false;
                });
                pastSurgeryController.text=pastDisease;
                pastDiseaseController.text = pastDisease;
                medicalConditionData['ConditionType'] = valuesList.toString();
                medicalConditionData['PastDisease'] = pastDisease.toString();
                medicalConditionData['SurgeryInformation'] =
                    pastSurgery.toString();
                medicalConditionData['ConditionId'] = timestamp.toString();
                storeData(
                    await SharedPref.getStringPreference(SharedPref.MOBILE),
                    medicalConditionData); //  context.go('/PatientProfileScreen');
                retrieveData(
                        await SharedPref.getStringPreference(SharedPref.MOBILE))
                    .then((value) {
                  value.logD;
                  context.go('/HomeView');
                });
                // context.go('/PatientProfileScreen');
              },
              isDisabled: false,
            ),
          )
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

  void storeData(String mobileNumber, Map<String, dynamic> data) async {
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
