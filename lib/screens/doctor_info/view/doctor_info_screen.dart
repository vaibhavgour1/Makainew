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
import 'package:makaihealth/utility/utility.dart';
import 'package:makaihealth/widget/app_button.dart';
import 'package:makaihealth/widget/space_horizontal.dart';
import 'package:makaihealth/widget/space_vertical.dart';

class DoctorInfoScreen extends StatefulWidget {
  const DoctorInfoScreen({super.key});

  @override
  State<DoctorInfoScreen> createState() => _DoctorInfoScreenState();
}

class _DoctorInfoScreenState extends State<DoctorInfoScreen> {
  TextEditingController searchDosage = TextEditingController();
  TextEditingController searchFrequency = TextEditingController();
  TextEditingController searchmediciesController = TextEditingController();

  String search = '', dosage = '', frequency = '';
  String putData = '';
  String doctorNamee = '';

  bool showMyMediacience = false;
  bool _buttonClicked = false;
  bool showTextfieldButtonDoctor = false;

  // final List<Map<String, String>> DoctorInfoScreen = [
  //   {"name": "Metformin"},
  //   {"name": "Victoza"},
  //   {"name": "Glipizide"},
  //   {"name": "Janumet"},
  //   {"name": "Lantus"},
  //   {"name": "Glimepiride"},
  //   {"name": "Insulin"},
  //   {"name": "Meglitinides"},
  //   {"name": "Sulfonylureas"},
  // ];

  final List<Map<String, String>> addmymedicalCondition = [];
  List<String> dosageList = [];
  List<String> frequencyList = [];
  Map<String, String> medicineData = {};

  //final List<Map<String, String>> doctorname = [];

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
                    // SpaceV(AppSize.h20),
                    // if (!showMyMediacience)
                    //   Column(
                    //     children: [
                    //       SpaceV(AppSize.h20),
                    //       Container(
                    //         decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(0),
                    //           border: Border.all(
                    //             color: Colors.grey,
                    //             width: 1.5,
                    //           ),
                    //         ),
                    //         padding: const EdgeInsets.symmetric(horizontal: 16),
                    //         child: Row(
                    //           children: [
                    //             Assets.images.svgs.docInfo.svg(),
                    //             SpaceH(AppSize.w10),
                    //             Expanded(
                    //               child: TextField(
                    //                 controller: searchdoctornameController,
                    //                 onChanged: (value) {
                    //                   setState(() {
                    //                     doctorNamee =
                    //                         searchdoctornameController.text
                    //                             .toString();
                    //                   });
                    //                 },
                    //                 decoration: InputDecoration(
                    //                   hintText: "Doctor name",
                    //                   hintStyle: TextStyle(
                    //                     fontWeight: FontWeight.w400,
                    //                     fontSize: AppSize.sp14,
                    //                     color: AppColor.black,
                    //                   ),
                    //                   border: InputBorder.none,
                    //                 ),
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //      SpaceV(AppSize.h40),
                    //     ],
                    //   ),
                    if (showMyMediacience)
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            doctorNamee,
                            style: textSemiBold.copyWith(
                                color: AppColor.black, fontSize: AppSize.sp16),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SpaceV(AppSize.h10),
                          Text(
                            myCondition,
                            style: textSemiBold.copyWith(
                                color: AppColor.black, fontSize: AppSize.sp22),
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                          ),
                          SpaceV(AppSize.h10),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.2,
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: dosageList.length,
                              itemBuilder: (BuildContext context, int index) {
                                var medicalCon = addmymedicalCondition[index];
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
                                        "${medicalCon["name"]!}, ${dosageList[index]}, ${frequencyList[index]}",
                                        style: textBold.copyWith(
                                            fontSize: AppSize.sp14,
                                            color: AppColor.black),
                                      ),
                                      onTap: () {},
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                          SpaceV(AppSize.h12),
                        ],
                      ),
                    SpaceV(AppSize.h40),
                    GestureDetector(
                      onTap: () {},
                      child: Center(
                        child: Text(
                          addMedication,
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
                          showTextfieldButtonDoctor = true;
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
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            // const Icon(
                            //   Icons.search,
                            //   color: AppColor.black,
                            // ),
                            SpaceH(AppSize.w10),
                            Expanded(
                              child: Column(
                                children: [
                                  TextField(
                                    controller: searchmediciesController,
                                    onChanged: (String? value) {
                                      setState(() {
                                        showTextfieldButtonDoctor = true;
                                        search = value.toString();
                                      });
                                    },
                                    decoration: InputDecoration(
                                      hintText: "Type your Medicine",
                                      hintStyle: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: AppSize.sp14,
                                        color: AppColor.black,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                  TextField(
                                    controller: searchDosage,
                                    onChanged: (String? value) {
                                      setState(() {
                                        showTextfieldButtonDoctor = true;
                                        dosage = value.toString();
                                      });
                                    },
                                    decoration: InputDecoration(
                                      hintText: "Type your Medicine Dosage",
                                      hintStyle: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: AppSize.sp14,
                                        color: AppColor.black,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                  TextField(
                                    controller: searchFrequency,
                                    onChanged: (String? value) {
                                      setState(() {
                                        showTextfieldButtonDoctor = true;
                                        frequency = value.toString();
                                      });
                                    },
                                    decoration: InputDecoration(
                                      hintText: "Type your Medicine Frequency",
                                      hintStyle: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: AppSize.sp14,
                                        color: AppColor.black,
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
                    if (showTextfieldButtonDoctor)
                      Column(
                        children: [
                          AppButton(
                            addCondition,
                            () {

                              if (search.isEmpty ||
                                  dosage.isEmpty ||
                                  frequency.isEmpty) {
                                Utility.showToast(
                                    msg: "Please fill All Text Field");
                              } else {
                                setState(() {
                                  // addmymedicalCondition.add({
                                  //   "name": putData,
                                  // });
                                  showMyMediacience = true;
                                  //_buttonClicked = true;
                                  searchmediciesController.clear();
                                  searchDosage.clear();
                                  searchFrequency.clear();
                                  addmymedicalCondition.add({
                                    "name": search,
                                  });
                                  dosageList.add(dosage);
                                  frequencyList.add(frequency);

                                  // DoctorInfoScreen.add({
                                  //   "name": search,
                                  // });
                                });
                              }
                              showTextfieldButtonDoctor = false;
                            },
                            isDisabled: false,
                          ),
                        ],
                      ),
                    SpaceV(AppSize.h20),
                    //   if(showMyMediacience)
                    // SizedBox(
                    //   height: MediaQuery.of(context).size.height * 0.24,
                    //   child: ListView.builder(
                    //     itemCount: DoctorInfoScreen.length,
                    //     itemBuilder: (BuildContext context, int index) {
                    //       var medicalCon = DoctorInfoScreen[index];
                    //       return Column(
                    //         children: [
                    //           ListTile(
                    //             leading: Assets.images.svgs.medicalCon.svg(),
                    //             iconColor: AppColor.black,
                    //             title: Text(
                    //               medicalCon["name"]!,
                    //               style: textBold.copyWith(
                    //                   fontSize: AppSize.sp14,
                    //                   color: AppColor.black),
                    //             ),
                    //             onTap: () {
                    //               setState(() {
                    //                 showMyMediacience = true;
                    //                 putData = medicalCon["name"]!;
                    //                 addmymedicalCondition.add({
                    //                   "name": putData,
                    //                 });
                    //                 showMyMediacience = true;
                    //                 _buttonClicked = true;
                    //                 searchmediciesController.clear();
                    //                 addmymedicalCondition.add({
                    //                   "name": search,
                    //                 });

                    //                 DoctorInfoScreen.add({
                    //                   "name": search,
                    //                 });
                    //               });
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
        if (showMyMediacience == false)
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.02,
            left: MediaQuery.of(context).size.width * 0.07,
            right: MediaQuery.of(context).size.width * 0.07,
            child: AppButton(
              selectCondition,
              () {
                setState(() {
                  showMyMediacience = false;
                });
                // context.go('/DoctorInfoScreen');
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
                //  List<String> valuesList = [];
                //
                // // Using forEach()
                // for (var map in addmymedicalCondition) {
                // for (var value in map.values) {
                // valuesList.add(value);
                // }
                // }

                // Using map() and expand()
                List<String> valuesList = addmymedicalCondition
                    .map((map) => map.values)
                    .expand((values) => values)
                    .toList();
                DateTime now = DateTime.now();
                String timestamp = now.microsecondsSinceEpoch.toString();
                 // Output: [value1, value2, value3, value4, value5, value6]
                setState(() {
                  showMyMediacience = false;
                });
                (await SharedPref.getStringPreference(SharedPref.MOBILE)).logD;
                medicineData['Name'] = valuesList.toString();
                medicineData['Frequency'] = frequencyList.toString();
                medicineData['Dosage'] = dosageList.toString();
                medicineData['MedicineId'] =  timestamp;
                medicineData.logD;
                storeData(
                    await SharedPref.getStringPreference(SharedPref.MOBILE),
                    medicineData);
                //Navigator.pop(context);
                 context.go('/PatientProfileScreen');
                // retrieveData(
                //         await SharedPref.getStringPreference(SharedPref.MOBILE))
                //     .then((value) {
                //   value.logD;
                //   context.go('/HomeView');
                // });
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
          .collection('medicine')
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
          .collection('medicine')
          .doc(mobileNumber)
          .set(data);
      ('Data stored successfully for mobile number: $mobileNumber').logD;

    } catch (e) {
      ('Error storing data: $e').logD;
    }
  }
}
