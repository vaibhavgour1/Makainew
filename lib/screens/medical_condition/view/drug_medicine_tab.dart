
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:makaihealth/utility/colors.dart';
import 'package:makaihealth/utility/dimension.dart';
import 'package:makaihealth/utility/text_styles.dart';
import 'package:makaihealth/widget/space_horizontal.dart';
import 'package:makaihealth/widget/space_vertical.dart';

class DrugMedicineTabScreen extends StatefulWidget {
  const DrugMedicineTabScreen({Key? key}) : super(key: key);

  @override
  State<DrugMedicineTabScreen> createState() => _DrugMedicineTabScreenState();
}

class _DrugMedicineTabScreenState extends State<DrugMedicineTabScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.white,
       // leadingWidth: 120,
        leading: GestureDetector(
            onTap: () {
              context.go('/PatientProfileScreen');
            },
            child: const Icon(Icons.arrow_back,
                color: AppColor.appbarBgColor)),
        actions: [
          GestureDetector(
            onTap: () {
              context.go('/NotificationScreen');
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 0, right: 15),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(
                  'assets/images/svgs/homeBellImg.svg',
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
      //***********************Drawer*********************
      drawer: Drawer(
        backgroundColor: Colors.white,
        width: AppSize.w200,

        // Add your drawer content here
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SpaceV(AppSize.h80),
            // ListTile(
            //   title: Column(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       // Row(
            //       //   children: [
            //       //     SizedBox(
            //       //       width: AppSize.w42,
            //       //     ),
            //       //     // Container(
            //       //     //   child: ClipRRect(
            //       //     //     borderRadius: BorderRadius.circular(20),
            //       //     //     child: Image.asset(
            //       //     //       "assets/images/png/profileImagee.png",
            //       //     //       fit: BoxFit.contain,
            //       //     //       width: MediaQuery.of(context).size.width * 0.14,
            //       //     //     ),
            //       //     //   ),
            //       //     // ),
            //       //     GestureDetector(
            //       //       onTap: () {
            //       //         _userHomeMenuController.pickImage().then((value) {
            //       //           setState(() {});
            //       //         });
            //       //       },
            //       //       child: _userHomeMenuController.imageFile != null
            //       //           ? Container(
            //       //               height:
            //       //                   MediaQuery.of(context).size.width * 0.15,
            //       //               width: MediaQuery.of(context).size.width * 0.15,
            //       //               decoration: BoxDecoration(
            //       //                 borderRadius: BorderRadius.circular(
            //       //                   MediaQuery.of(context).size.width * 0.115,
            //       //                 ),
            //       //                 //border: Border.all(color: AppColor.black),
            //       //               ),
            //       //               child: ClipRRect(
            //       //                 borderRadius: BorderRadius.circular(
            //       //                   MediaQuery.of(context).size.width * 0.115,
            //       //                 ),
            //       //                 child: InteractiveViewer(
            //       //                   maxScale: 3.6,
            //       //                   child: Image.file(
            //       //                     File(_userHomeMenuController.imagePath!),
            //       //                     fit: BoxFit.cover,
            //       //                   ),
            //       //                 ),
            //       //               ),
            //       //             )
            //       //           : Container(
            //       //               child: ClipRRect(
            //       //                 borderRadius: BorderRadius.circular(20),
            //       //                 child: Image.asset(
            //       //                   "assets/images/png/profileImagee.png",
            //       //                   fit: BoxFit.contain,
            //       //                   width: MediaQuery.of(context).size.width *
            //       //                       0.14,
            //       //                 ),
            //       //               ),
            //       //             ),
            //       //     ),
            //       //   ],
            //       // ),
            //       SizedBox(
            //         height: AppSize.h10,
            //       ),
            //       Row(
            //         children: [
            //           SizedBox(
            //             width: AppSize.w42,
            //           ),
            //           Text(
            //             'Profile',
            //             style: textSemiBold.copyWith(
            //                 color: AppColor.black, fontSize: AppSize.sp14),
            //             maxLines: 1,
            //             overflow: TextOverflow.ellipsis,
            //           ),
            //         ],
            //       ),
            //     ],
            //   ),
            //   onTap: () {
            //     // Update the UI based on drawer item click
            //   },
            // ),
            ListTile(

              title: Row(
                children: [
                  SvgPicture.asset(
                    'assets/images/svgs/drawerMedication.svg',
                    height: AppSize.h28,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: AppSize.w14,
                  ),
                  Text(
                    'Drugs',
                    style: textSemiBold.copyWith(
                        color: AppColor.black, fontSize: AppSize.sp14),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              onTap: () {
                context.go('/MedicationScreen');
              },
            ),
            ListTile(
              title: Row(
                children: [
                  SvgPicture.asset(
                    'assets/images/svgs/drawerAssement.svg',
                    height: AppSize.h28,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: AppSize.w14,
                  ),
                  Text(
                    'Assessments',
                    style: textSemiBold.copyWith(
                        color: AppColor.black, fontSize: AppSize.sp14),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              onTap: () {
                context.go('/AssessmentScreen');
              },
            ),
            ListTile(
              title: Row(
                children: [
                  SvgPicture.asset(
                    'assets/images/svgs/summary.svg',
                    height: AppSize.h28,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: AppSize.w14,
                  ),
                  Text(
                    'Summary',
                    style: textSemiBold.copyWith(
                        color: AppColor.black, fontSize: AppSize.sp14),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              onTap: () {
                context.go('/SummeryScreen');
              },
            ),
            ListTile(
              title: Row(
                children: [
                  SvgPicture.asset(
                    'assets/images/svgs/reports.svg',
                    height: AppSize.h28,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: AppSize.w14,
                  ),
                  Text(
                    'Reports',
                    style: textSemiBold.copyWith(
                        color: AppColor.black, fontSize: AppSize.sp14),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              onTap: () {
                context.go('/ReportsScreen');
              },
            ),
            ListTile(
              title: Row(
                children: [
                  SvgPicture.asset(
                    'assets/images/svgs/logOut.svg',
                    height: AppSize.h28,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: AppSize.w14,
                  ),
                  Text(
                    'log out',
                    style: textSemiBold.copyWith(
                        color: AppColor.black, fontSize: AppSize.sp14),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              onTap: () {
                // Update the UI based on drawer item click
              },
            ),
          ],
        ),
      ),

      //***Drawer End*****************************/
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                InkWell(
                  onTap: (){
                    context.go('/MedicalConditionScreen');

                  },
                  child: Card(
                    color: Colors.white,
                    elevation: 4,
                    shadowColor: AppColor.textColor,
                    child:  Padding(
                      padding: EdgeInsets.all(AppSize.w16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.bed_sharp,color: AppColor.black,),
                          SpaceH(AppSize.w14),
                          Text(
                            'Conditions',
                            style: textRegular.copyWith(
                                fontSize: AppSize.sp16,
                                color: AppColor.black),
                          )
                        ],
                      ),
                    ),


                  ),
                ),
                SpaceV(AppSize.w14),
                InkWell(
                  onTap: (){
                    context.go('/DoctorInfoScreen');
                  },
                  child: Card(
                    color: Colors.white,
                    elevation: 4,
                    shadowColor: AppColor.textColor,
                    child:  Padding(
                      padding: EdgeInsets.all(AppSize.w16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.local_hospital,color: AppColor.black,),
                          SpaceH(AppSize.w14),
                          Text(
                            'Drugs',
                            style: textRegular.copyWith(
                                fontSize: AppSize.sp16,
                                color: AppColor.black),
                          )
                        ],
                      ),
                    ),


                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}