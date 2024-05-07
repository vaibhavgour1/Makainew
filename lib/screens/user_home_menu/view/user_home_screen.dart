import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:go_router/go_router.dart';
import 'package:makaihealth/extensions/extensions.dart';
import 'package:makaihealth/screens/user_home_menu/Controller/user_homemenu_controller.dart.dart';
import 'package:makaihealth/utility/colors.dart';
import 'package:makaihealth/utility/dimension.dart';
import 'package:makaihealth/utility/text_styles.dart';
import 'package:makaihealth/widget/space_horizontal.dart';
import 'package:makaihealth/widget/space_vertical.dart';

class UserProfileHomeScreen extends StatefulWidget {
  const UserProfileHomeScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileHomeScreen> createState() => _UserProfileHomeScreenState();
}

class _UserProfileHomeScreenState extends State<UserProfileHomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  UserHomeMenuController _userHomeMenuController =
  Get.put(UserHomeMenuController());
  int selectedTimingIndex = 2;
  int selectedDuarationIndex = 4;
  int foddSelected = 0;
  int addfoodSelected = -1;

  final List<String> dataList = [
    "Metformin",
    "Victoza",
    "lipizideza",
    "Victoza",
    "lipizideza"
  ];
  final List<Map<String, String>> timingList = [
    {
      "name": "4h",
      "type": "Once",
    },
    {
      "name": "8h",
      "type": "Twice",
    },
    {
      "name": "12h",
      "type": "Thrice",
    },
    {
      "name": "14h",
      "type": "Times",
    },
    {
      "name": "48h",
      "type": "a day",
    },
  ];
  final List<Map<String, String>> duarationList = [
    {
      "name": "1d",
      "type": "10d",
    },
    {
      "name": "2d",
      "type": "2w",
    },
    {
      "name": "3d",
      "type": "4w",
    },
    {
      "name": "4d",
      "type": "1m",
    },
    {
      "name": "5d",
      "type": "2m",
    },
  ];

  final List<String> foodList = [
    "Before food",
    "After food",
    "with food",
  ];

  final List<String> addfoodList = [
    "Empty stomach",
    "Bedtime",
  ];

  int selectedIndex = 4; // Initially, no item is selected

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leadingWidth: 100,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15, right: 0),
          child: Row(
            children: [
              GestureDetector(
                onTap: _openDrawer,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    'assets/images/svgs/homeDrawerImg.svg',
                    color: Colors.black,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  context.go('/HomeView');
                },
                child: SvgPicture.asset(
                  "assets/images/svgs/backArrow.svg",
                  color: AppColor.black,
                ),
              ),
            ],
          ),
        ),
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
            ListTile(
              title: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: AppSize.w42,
                      ),
                      // Container(
                      //   child: ClipRRect(
                      //     borderRadius: BorderRadius.circular(20),
                      //     child: Image.asset(
                      //       "assets/images/png/profileImagee.png",
                      //       fit: BoxFit.contain,
                      //       width: MediaQuery.of(context).size.width * 0.14,
                      //     ),
                      //   ),
                      // ),
                      GestureDetector(
                        onTap: () {
                          _userHomeMenuController.pickImage().then((value) {
                            setState(() {});
                          });
                        },
                        child: _userHomeMenuController.imageFile != null
                            ? Container(
                          height:
                          MediaQuery.of(context).size.width * 0.15,
                          width: MediaQuery.of(context).size.width * 0.15,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              MediaQuery.of(context).size.width * 0.115,
                            ),
                            //border: Border.all(color: AppColor.black),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                              MediaQuery.of(context).size.width * 0.115,
                            ),
                            child: InteractiveViewer(
                              maxScale: 3.6,
                              child: Image.file(
                                File(_userHomeMenuController.imagePath!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        )
                            : Container(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              "assets/images/png/profileImagee.png",
                              fit: BoxFit.contain,
                              width: MediaQuery.of(context).size.width *
                                  0.14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: AppSize.h10,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: AppSize.w42,
                      ),
                      Text(
                        'Profile',
                        style: textSemiBold.copyWith(
                            color: AppColor.black, fontSize: AppSize.sp14),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ],
              ),
              onTap: () {
                // Update the UI based on drawer item click
              },
            ),
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
                    'Medication',
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
                    'Summery',
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
            padding: EdgeInsets.all(AppSize.w16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // Container(
                    //   child: ClipRRect(
                    //     borderRadius: BorderRadius.circular(20),
                    //     child: Image.asset(
                    //       "assets/images/png/profileImagee.png",
                    //       fit: BoxFit.contain,
                    //       width: MediaQuery.of(context).size.width * 0.14,
                    //     ),
                    //   ),
                    // ),
                    GestureDetector(
                      onTap: () {
                        _userHomeMenuController.pickImage().then((value) {
                          setState(() {});
                        });
                      },
                      child: _userHomeMenuController.imageFile != null
                          ? Container(
                        height: MediaQuery.of(context).size.width * 0.15,
                        width: MediaQuery.of(context).size.width * 0.15,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            MediaQuery.of(context).size.width * 0.115,
                          ),
                          //border: Border.all(color: AppColor.black),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                            MediaQuery.of(context).size.width * 0.115,
                          ),
                          child: InteractiveViewer(
                            maxScale: 3.6,
                            child: Image.file(
                              File(_userHomeMenuController.imagePath!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      )
                          : Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            "assets/images/png/profileImagee.png",
                            fit: BoxFit.contain,
                            width:
                            MediaQuery.of(context).size.width * 0.14,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: AppSize.w20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Akshay sing',
                          style: textMedium.copyWith(
                              color: AppColor.black, fontSize: AppSize.sp14),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'MALE, 28',
                          style: textMedium.copyWith(
                              color: AppColor.black, fontSize: AppSize.sp14),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'Dicones - Diabetes',
                          style: textMedium.copyWith(
                              color: AppColor.black, fontSize: AppSize.sp14),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ],
                ),

                SizedBox(
                  height: AppSize.h16,
                ),
                Text(
                  'Mediacies',
                  style: textSemiBold.copyWith(
                      color: AppColor.black, fontSize: AppSize.sp16),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: AppSize.h12,
                ),
                SizedBox(
                  height: AppSize.h42 * ((dataList.length / 3).ceil()),
                  child: Column(
                    children:
                    List.generate((dataList.length / 3).ceil(), (rowIndex) {
                      return Row(
                        children: List.generate(3, (columnIndex) {
                          final index = rowIndex * 3 + columnIndex;
                          if (index < dataList.length) {
                            return Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  // Do nothing on tap
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 10, bottom: 10),
                                  child: SizedBox(
                                    width:
                                    MediaQuery.of(context).size.width / 3 -
                                        20, // Adjust width here
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: AppColor.rediousfillcolot,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: AppColor.rediousfillcolot,
                                        ), // Add borders if needed
                                      ),
                                      child: Text(
                                        dataList[index],
                                        style: textSemiBold.copyWith(
                                          fontSize: AppSize.sp14,
                                          // height: AppSize.h1,
                                          color: AppColor.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          } else if (index == dataList.length) {
                            // Display plus icon for the last item
                            return Padding(
                              padding:
                              const EdgeInsets.only(right: 10, bottom: 10),
                              child: GestureDetector(
                                onTap: () {
                                  // Handle the tap on the plus icon
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      width: 2,
                                      color: AppColor.black,
                                    ), // Add borders if needed
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    size: AppSize
                                        .sp16, // Adjust the size as needed
                                    color: AppColor
                                        .black, // Adjust the color as needed
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return SpaceH(AppSize.w10);
                          }
                        }),
                      );
                    }),
                  ),
                ),
                SizedBox(
                  height: AppSize.h8,
                ),
                //*******Dose Table */
                Container(
                  decoration: BoxDecoration(
                      color: AppColor.textBlueColor,
                      borderRadius: BorderRadius.circular(4)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 12, right: 12, top: 8, bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Tablet',
                          style: textSemiBold.copyWith(
                              color: AppColor.textColor,
                              fontSize: AppSize.sp16),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'metfo(500)',
                          style: textSemiBold.copyWith(
                              color: AppColor.textColor,
                              fontSize: AppSize.sp14),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Dose 1',
                            style: textSemiBold.copyWith(
                                color: AppColor.black, fontSize: AppSize.sp14),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Container(
                            width: AppSize.w24,
                            height: AppSize.h24,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColor.black,
                            ),
                            child: Center(
                              child: Container(
                                width: AppSize.w32,
                                height: AppSize.h32,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: Center(
                                  child: Text(
                                    '',
                                    style: TextStyle(
                                      color: AppColor.rediousfillcolot,
                                      fontSize: 12, // Adjust size as needed
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: AppSize.w24,
                            height: AppSize.h24,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColor.black,
                            ),
                            child: Center(
                              child: Container(
                                width: AppSize.w32,
                                height: AppSize.h32,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: Center(
                                  child: Text(
                                    '1',
                                    style: TextStyle(
                                      color: AppColor.rediousfillcolot,
                                      fontSize: 12, // Adjust size as needed
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: AppSize.w24,
                            height: AppSize.h24,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColor.black,
                            ),
                            child: Center(
                              child: Container(
                                width: AppSize.w32,
                                height: AppSize.h32,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: Center(
                                  child: Text(
                                    '1/2',
                                    style: TextStyle(
                                      color: AppColor.rediousfillcolot,
                                      fontSize: 12, // Adjust size as needed
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: AppSize.w24,
                            height: AppSize.h24,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColor.black,
                            ),
                            child: Center(
                              child: Container(
                                width: AppSize.w32,
                                height: AppSize.h32,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: Center(
                                  child: Text(
                                    '',
                                    style: TextStyle(
                                      color: AppColor.rediousfillcolot,
                                      fontSize: 12, // Adjust size as needed
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: AppColor.textBlueColor),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 14, right: 14, top: 5, bottom: 5),
                              child: Text(
                                "Done",
                                style: textSemiBold.copyWith(
                                  fontSize: AppSize.sp14,
                                  color: AppColor.textColor,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Dose 2',
                            style: textSemiBold.copyWith(
                                color: AppColor.black, fontSize: AppSize.sp14),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Container(
                            width: AppSize.w24,
                            height: AppSize.h24,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColor.black,
                            ),
                            child: Center(
                              child: Container(
                                width: AppSize.w32,
                                height: AppSize.h32,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: Center(
                                  child: Text(
                                    '',
                                    style: TextStyle(
                                      color: AppColor.rediousfillcolot,
                                      fontSize: 12, // Adjust size as needed
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: AppSize.w24,
                            height: AppSize.h24,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColor.black,
                            ),
                            child: Center(
                              child: Container(
                                width: AppSize.w32,
                                height: AppSize.h32,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: Center(
                                  child: Text(
                                    '1',
                                    style: TextStyle(
                                      color: AppColor.rediousfillcolot,
                                      fontSize: 12, // Adjust size as needed
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: AppSize.w24,
                            height: AppSize.h24,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColor.black,
                            ),
                            child: Center(
                              child: Container(
                                width: AppSize.w32,
                                height: AppSize.h32,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: Center(
                                  child: Text(
                                    '1/2',
                                    style: TextStyle(
                                      color: AppColor.rediousfillcolot,
                                      fontSize: 12, // Adjust size as needed
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: AppSize.w24,
                            height: AppSize.h24,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColor.black,
                            ),
                            child: Center(
                              child: Container(
                                width: AppSize.w32,
                                height: AppSize.h32,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: Center(
                                  child: Text(
                                    '',
                                    style: TextStyle(
                                      color: AppColor.rediousfillcolot,
                                      fontSize: 12, // Adjust size as needed
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: AppColor.textBlueColor),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 14, right: 14, top: 5, bottom: 5),
                              child: Text(
                                "Done",
                                style: textSemiBold.copyWith(
                                  fontSize: AppSize.sp14,
                                  color: AppColor.textColor,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Dose 3',
                            style: textSemiBold.copyWith(
                                color: AppColor.black, fontSize: AppSize.sp14),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Container(
                            width: AppSize.w24,
                            height: AppSize.h24,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColor.black,
                            ),
                            child: Center(
                              child: Container(
                                width: AppSize.w32,
                                height: AppSize.h32,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: Center(
                                  child: Text(
                                    '',
                                    style: TextStyle(
                                      color: AppColor.rediousfillcolot,
                                      fontSize: 12, // Adjust size as needed
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: AppSize.w24,
                            height: AppSize.h24,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColor.black,
                            ),
                            child: Center(
                              child: Container(
                                width: AppSize.w32,
                                height: AppSize.h32,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: Center(
                                  child: Text(
                                    '1',
                                    style: TextStyle(
                                      color: AppColor.rediousfillcolot,
                                      fontSize: 12, // Adjust size as needed
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: AppSize.w24,
                            height: AppSize.h24,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColor.black,
                            ),
                            child: Center(
                              child: Container(
                                width: AppSize.w32,
                                height: AppSize.h32,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: Center(
                                  child: Text(
                                    '1/2',
                                    style: TextStyle(
                                      color: AppColor.rediousfillcolot,
                                      fontSize: 12, // Adjust size as needed
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: AppSize.w24,
                            height: AppSize.h24,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColor.black,
                            ),
                            child: Center(
                              child: Container(
                                width: AppSize.w32,
                                height: AppSize.h32,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: Center(
                                  child: Text(
                                    '',
                                    style: TextStyle(
                                      color: AppColor.rediousfillcolot,
                                      fontSize: 12, // Adjust size as needed
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: AppColor.textBlueColor),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 14, right: 14, top: 5, bottom: 5),
                              child: Text(
                                "Done",
                                style: textSemiBold.copyWith(
                                  fontSize: AppSize.sp14,
                                  color: AppColor.textColor,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                //****************** */
                SizedBox(
                  height: AppSize.h16,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: AppColor.textBlueColor,
                      borderRadius: BorderRadius.circular(4)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12, top: 8, bottom: 8),
                    child: Text(
                      'Timing',
                      style: textSemiBold.copyWith(
                          color: AppColor.textColor, fontSize: AppSize.sp16),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                SizedBox(
                  height: AppSize.h16,
                ),
                SizedBox(
                  height: AppSize.h50,
                  child: ListView.separated(
                    itemCount: timingList.length,
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (BuildContext context, int index) {
                      var userData = timingList[index];

                      return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                            MediaQuery.of(context).size.width * 0.02),
                        child: Container(
                          height: AppSize.h40,
                          width: AppSize.w2,
                          color: AppColor.textBlueColor, // Color of the divider
                        ),
                      );
                    },
                    itemBuilder: (context, index) {
                      var userData = timingList[index];
                      bool isSelected = selectedTimingIndex ==
                          index; // Determine if the current item is selected

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedTimingIndex =
                                        index; // Update the selected index
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? AppColor.textBlueColor
                                        : Colors
                                        .white, // Conditional background color
                                    borderRadius: BorderRadius.circular(
                                        8.0), // Add border radius for a rounded look
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                        MediaQuery.of(context).size.width *
                                            0.045,
                                        vertical: MediaQuery.of(context)
                                            .size
                                            .width *
                                            0.01), // 10% padding on both sides
                                    child: Text(
                                      userData["name"]!,
                                      style: textSemiBold.copyWith(
                                        color: isSelected
                                            ? Colors.white
                                            : AppColor.black,
                                        fontSize: AppSize.sp14,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                userData["type"]!,
                                style: textSemiBold.copyWith(
                                    color: AppColor.black,
                                    fontSize: AppSize.sp14),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 15),
                  child: Container(
                    height: AppSize.h2,
                    width: MediaQuery.of(context).size.width,
                    color: AppColor.textBlueColor,
                  ),
                ),
                //////////
                SizedBox(
                  height: AppSize.h20,
                  child: ListView.builder(
                    itemCount: foodList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      // var foodData = foodList[index];
                      bool isSelected = foddSelected ==
                          index; // Determine if the current item is selected

                      return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                            MediaQuery.of(context).size.width * 0.022),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              foddSelected = index;
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                foodList[index],
                                style: textSemiBold.copyWith(
                                    color: AppColor.black,
                                    fontSize: AppSize.sp14),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(
                                width: AppSize.w6,
                              ),
                              Container(
                                width: AppSize.w28,
                                height: AppSize.h28,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isSelected
                                      ? AppColor.textBlueColor
                                      : Colors.white,
                                  border: Border.all(
                                    color: AppColor.bordercolor,
                                    width: 1, // Set the width of the border
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                ////////////

                Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 15),
                  child: Container(
                    height: AppSize.h2,
                    width: MediaQuery.of(context).size.width,
                    color: AppColor.textBlueColor,
                  ),
                ),
                SizedBox(
                  height: AppSize.h20,
                  child: ListView.builder(
                    itemCount: addfoodList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      // var foodData = foodList[index];
                      bool isSelected = addfoodSelected ==
                          index; // Determine if the current item is selected

                      return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                            MediaQuery.of(context).size.width * 0.044),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              addfoodSelected = index;
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                addfoodList[index],
                                style: textSemiBold.copyWith(
                                    color: AppColor.black,
                                    fontSize: AppSize.sp14),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(
                                width: AppSize.w6,
                              ),
                              Container(
                                width: AppSize.w28,
                                height: AppSize.h28,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isSelected
                                      ? AppColor.textBlueColor
                                      : Colors.white,
                                  border: Border.all(
                                    color: AppColor.bordercolor,
                                    width: 1, // Set the width of the border
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: AppSize.w40,
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         Text(
                //           'Empty stomach',
                //           style: textSemiBold.copyWith(
                //               color: AppColor.black, fontSize: AppSize.sp14),
                //           maxLines: 1,
                //           overflow: TextOverflow.ellipsis,
                //         ),
                //         SizedBox(
                //           width: AppSize.w10,
                //         ),
                //         SvgPicture.asset(
                //           'assets/images/svgs/doseOne.svg',
                //         ),
                //       ],
                //     ),
                //     Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         Text(
                //           'Bedtime',
                //           style: textSemiBold.copyWith(
                //               color: AppColor.black, fontSize: AppSize.sp14),
                //           maxLines: 1,
                //           overflow: TextOverflow.ellipsis,
                //         ),
                //         SizedBox(
                //           width: AppSize.w10,
                //         ),
                //         SvgPicture.asset(
                //           'assets/images/svgs/doseOne.svg',
                //         ),
                //       ],
                //     ),
                //   ],
                // ),
                SizedBox(
                  height: AppSize.h16,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: AppColor.textBlueColor,
                      borderRadius: BorderRadius.circular(4)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12, top: 8, bottom: 8),
                    child: Text(
                      'Duration',
                      style: textSemiBold.copyWith(
                          color: AppColor.textColor, fontSize: AppSize.sp16),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                SizedBox(
                  height: AppSize.h16,
                ),
                SizedBox(
                  height: AppSize.h50,
                  child: ListView.separated(
                    itemCount: duarationList.length,
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (BuildContext context, int index) {
                      var userduarationData = duarationList[index];

                      return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width *
                                0.022), // 10% padding on both sides

                        child: Container(
                          height: AppSize.h40,
                          width: AppSize.w2,
                          color: AppColor.textBlueColor, // Color of the divider
                        ),
                      );
                    },
                    itemBuilder: (context, index) {
                      var userduarationData = duarationList[index];
                      bool isSelected = selectedDuarationIndex ==
                          index; // Determine if the current item is selected

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                userduarationData["name"]!,
                                style: textSemiBold.copyWith(
                                  color: AppColor.black,
                                  fontSize: AppSize.sp14,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedDuarationIndex =
                                          index; // Update the selected index
                                    });
                                  },
                                  child: Container(
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? AppColor.textBlueColor
                                            : Colors
                                            .white, // Conditional background color
                                        borderRadius: BorderRadius.circular(
                                            8.0), // Add border radius for a rounded look
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.045,
                                            vertical: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.01),
                                        child: Text(
                                          userduarationData["type"]!,
                                          style: textSemiBold.copyWith(
                                              color: isSelected
                                                  ? Colors.white
                                                  : AppColor.black,
                                              fontSize: AppSize.sp14),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ))),
                            ],
                          ),
                        ],
                      );
                    },
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




