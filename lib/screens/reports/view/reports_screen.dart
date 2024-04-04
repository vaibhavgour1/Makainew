import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:go_router/go_router.dart';
import 'package:makaihealth/screens/reports/controller/reports_controller.dart';
import 'package:makaihealth/utility/colors.dart';
import 'package:makaihealth/utility/dimension.dart';
import 'package:makaihealth/utility/text_styles.dart';
import 'package:makaihealth/widget/space_vertical.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({Key? key}) : super(key: key);

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ReportsController _reportsController = Get.put(ReportsController());
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(0),
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
                            Text(
                              'Reports',
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
                Center(
                  child: Text(
                    'Store reports',
                    style: textSemiBold.copyWith(
                      color: AppColor.black,
                      fontSize: AppSize.sp18,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SpaceV(AppSize.h40),
                Center(
                  child: GestureDetector(
                    onTap: () async {
                        await _reportsController.fileUpload();
                      },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset("assets/images/svgs/Cloud.svg"),
                                        SpaceV(AppSize.h20),
                         Text(
                          'Upload your reports',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                      ],
                    ),
                  ),
                ),
                SpaceV(AppSize.h20),
                
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: Align(
                    alignment: Alignment.center,
                    child: ListView.builder(
                      itemCount: _reportsController.reportsList.length,
                      itemBuilder: (BuildContext context, int index) {
                        var bankData = _reportsController.reportsList[index];
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 5.0),
                          child: ListTile(
                          //  contentPadding: EdgeInsets.symmetric(
                             //   horizontal: 16.0), 
                            //leading: Text(""),
                            title: Padding(
                              padding: const EdgeInsets.only(left: 15,right: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    _reportsController.reportsList[index] ?? "",
                                    style: textSemiBold.copyWith(
                                color: AppColor.textBlueColor,
                                fontSize: AppSize.sp14),
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                  ),
                                   SvgPicture.asset(
                                                      'assets/images/svgs/uploadReport.svg',
                                                    ),
                                ],
                              ),
                            ),

                            onTap: () {
                              // Handle onTap event
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),
                // ListTile(
                //   title: Padding(
                //     padding: const EdgeInsets.only(left: 15, right: 15),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         // SizedBox(
                //         //   width: AppSize.w18,
                //         // ),
                //         Text(
                //           'Reports',
                //           style: textSemiBold.copyWith(
                //               color: AppColor.textBlueColor,
                //               fontSize: AppSize.sp14),
                //           maxLines: 1,
                //           overflow: TextOverflow.ellipsis,
                //         ),
                //         SvgPicture.asset(
                //           'assets/images/svgs/uploadReport.svg',
                //         ),
                //       ],
                //     ),
                //   ),
                //   onTap: () {
                //     //   context.go('/ReportsScreen');
                //   },
                // ),
                // ListTile(
                //   title: Padding(
                //     padding: const EdgeInsets.only(left: 15, right: 15),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         Text(
                //           'Blood purses',
                //           style: textSemiBold.copyWith(
                //               color: AppColor.textBlueColor,
                //               fontSize: AppSize.sp14),
                //           maxLines: 1,
                //           overflow: TextOverflow.ellipsis,
                //         ),
                //         SvgPicture.asset(
                //           'assets/images/svgs/uploadReport.svg',
                //         ),
                //       ],
                //     ),
                //   ),
                //   onTap: () {
                //     //   context.go('/ReportsScreen');
                //   },
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
