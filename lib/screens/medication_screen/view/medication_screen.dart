import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:makaihealth/api/retriveData.dart';
import 'package:makaihealth/utility/colors.dart';
import 'package:makaihealth/utility/dimension.dart';
import 'package:makaihealth/utility/logger.dart';
import 'package:makaihealth/utility/sharedpref.dart';
import 'package:makaihealth/utility/text_styles.dart';
import 'package:makaihealth/utility/utility.dart';
import 'package:makaihealth/widget/space_vertical.dart';

class MedicationScreen extends StatefulWidget {
  const MedicationScreen({Key? key}) : super(key: key);

  @override
  State<MedicationScreen> createState() => _MedicationScreenState();
}

class _MedicationScreenState extends State<MedicationScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<String> nameList = [];
  List<Map<String, String>> medicines = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    retrieveDa();
  }

  Future<void> retrieveDa() async {
    String mobileNumber = await SharedPref.getStringPreference(SharedPref.MOBILE);
    ('mobileNumber => $mobileNumber').logD;

    retrieveData(mobileNumber, 'medicine').then((value) async {
      ('mobileNumber => $mobileNumber').logD;

      if (value == null || value.isEmpty) {
        Utility.showToast(msg: 'Please Fill Medicine Name Dosage From Profile Tab');
        return;
      }

      setState(() {
        medicines = parseMedicineData(value);
        ('medicines => $medicines').logD;
      });
    });
  }
  List<Map<String, String>> parseMedicineData(Map<String, dynamic> data) {
    List<String> names = data['Name'].split(',');
    List<String> dosages = data['Dosage'].split(',');
    List<String> frequencies = data['Frequency'].split(',');

    List<Map<String, String>> medicines = [];
    for (int i = 0; i < names.length; i++) {
      medicines.add({
        'name': names[i].trim(),
        'dosage': dosages[i].trim(),
        'frequency': frequencies[i].trim(),
      });
    }
    return medicines;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.go('/UserProfileHomeScreen');
                        },
                        child: SvgPicture.asset(
                          "assets/images/svgs/backArrow.svg",
                          color: AppColor.black,
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/images/svgs/drawerMedication.svg',
                              height: AppSize.h28,
                              color: Colors.black,
                            ),
                            SizedBox(
                                width:
                                    AppSize.w8), // Adjust the width as needed
                            Text(
                              'Drugs',
                              style: textSemiBold.copyWith(
                                color: AppColor.black,
                                fontSize: AppSize.sp18,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SpaceV(AppSize.h40),
                // Padding(
                //   padding: const EdgeInsets.only(left: 20),
                //   child: Column(
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Text(
                //         'Doctor name',
                //         style: textMedium.copyWith(
                //           color: AppColor.black,
                //           fontSize: AppSize.sp14,
                //         ),
                //         maxLines: 1,
                //         overflow: TextOverflow.ellipsis,
                //       ),
                //       SpaceV(AppSize.h10),
                //       Text(
                //         'Dr . K .T . SHARAM',
                //         style: textMedium.copyWith(
                //           color: AppColor.textBlueColor,
                //           fontSize: AppSize.sp14,
                //         ),
                //         maxLines: 1,
                //         overflow: TextOverflow.ellipsis,
                //       ),
                //     ],
                //   ),
                // ),
                SpaceV(AppSize.h20),
                Container(
                  decoration: BoxDecoration(
                      color: AppColor.textBlueColor,
                      borderRadius: BorderRadius.circular(0)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 12, top: 12, bottom: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Medication list',
                              style: textMedium.copyWith(
                                  color: AppColor.textColor,
                                  fontSize: AppSize.sp14),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              width: AppSize.w14,
                            ),
                            // SvgPicture.asset(
                            //   'assets/images/svgs/edit-line.svg',
                            // ),
                          ],
                        ),
                        // Text(
                        //   'Diabetes',
                        //   style: textMedium.copyWith(
                        //       color: AppColor.textColor,
                        //       fontSize: AppSize.sp14),
                        //   maxLines: 1,
                        //   overflow: TextOverflow.ellipsis,
                        // ),
                      ],
                    ),
                  ),
                ),
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
              itemCount: medicines.length,
              itemBuilder: (BuildContext context, int index) {
                final medicine = medicines[index];
                return MedicineItem(
                  name: medicine['name']!,
                  dosage: medicine['dosage']!,
                  frequency: medicine['frequency']!,
                );
              },
            ),),
                SpaceV(AppSize.h26),
                // Container(
                //   decoration: BoxDecoration(
                //       color: AppColor.textBlueColor,
                //       borderRadius: BorderRadius.circular(0)),
                //   child: Padding(
                //     padding: const EdgeInsets.only(
                //         left: 20, right: 12, top: 12, bottom: 12),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         Row(
                //           children: [
                //             Text(
                //               'Medication list',
                //               style: textMedium.copyWith(
                //                   color: AppColor.textColor,
                //                   fontSize: AppSize.sp14),
                //               maxLines: 1,
                //               overflow: TextOverflow.ellipsis,
                //             ),
                //             SizedBox(
                //               width: AppSize.w14,
                //             ),
                //             SvgPicture.asset(
                //               'assets/images/svgs/edit-line.svg',
                //             ),
                //           ],
                //         ),
                //         Text(
                //           'Blood presser',
                //           style: textMedium.copyWith(
                //               color: AppColor.textColor,
                //               fontSize: AppSize.sp14),
                //           maxLines: 1,
                //           overflow: TextOverflow.ellipsis,
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                // Container(
                //   color: AppColor.bordercolor,
                //   height: MediaQuery.of(context).size.height * 0.3,
                //   child: ListView.builder(
                //     itemCount: dataList.length,
                //     itemBuilder: (BuildContext context, int index) {
                //       var bankData = dataList[index];
                //       return Column(
                //         children: [
                //           Padding(
                //             padding: const EdgeInsets.only(left: 3, right: 3),
                //             child: Container(
                //               decoration: const BoxDecoration(
                //                 border: Border(
                //                   left: BorderSide(
                //                     color: AppColor.rediousfillcolot,
                //                     width: 1,
                //                   ),
                //                   right: BorderSide(
                //                     color: AppColor.rediousfillcolot,
                //                     width: 1,
                //                   ),
                //                   bottom: BorderSide(
                //                     color: AppColor.rediousfillcolot,
                //                     width: 1,
                //                   ),
                //                 ),
                //               ),
                //               child: ListTile(
                //                 leading: Text(
                //                   (index + 1)
                //                       .toString(), // Display index starting from 1
                //                   style: textMedium.copyWith(
                //                     fontSize: AppSize.sp14,
                //                     color: AppColor.black,
                //                   ),
                //                 ),
                //                 title: Text(
                //                   dataList[index] ?? "",
                //                   style: textMedium.copyWith(
                //                     fontSize: AppSize.sp14,
                //                     color: AppColor.black,
                //                   ),
                //                 ),
                //                 onTap: () {
                //                   // Handle onTap event
                //                 },
                //               ),
                //             ),
                //           ),
                //         ],
                //       );
                //     },
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class MedicineItem extends StatelessWidget {
  final String name;
  final String dosage;
  final String frequency;

  const MedicineItem({
    Key? key,
    required this.name,
    required this.dosage,
    required this.frequency,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.rediousfillcolot),
      ),
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Name: $name', style: textMedium.copyWith(fontSize: AppSize.sp14, color: AppColor.black)),
          Text('Dosage: $dosage', style: textMedium.copyWith(fontSize: AppSize.sp14, color: AppColor.black)),
          Text('Frequency: $frequency', style: textMedium.copyWith(fontSize: AppSize.sp14, color: AppColor.black)),
        ],
      ),
    );
  }
}