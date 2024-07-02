import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:makaihealth/utility/colors.dart';
import 'package:makaihealth/utility/dimension.dart';
import 'package:makaihealth/utility/text_styles.dart';
import 'package:makaihealth/widget/space_vertical.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<String> notificationList = [
    "Hi....Akshay your next dose in 3 hr",
    "Hi....Akshay your next dose in 4 hr",
    "Hi....Akshay your next dose in 5 hr",
  ];

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
              // mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.start,
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
                              'Notifications',
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
                SpaceV(AppSize.h10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Text(
                        'See all',
                        style: textSemiBold.copyWith(
                          color: AppColor.textBlueColor,
                          fontSize: AppSize.sp16,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SpaceV(AppSize.h20),
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: Align(
                    alignment: Alignment.center,
                    child: ListView.builder(
                      itemCount: notificationList.length,
                      itemBuilder: (BuildContext context, int index) {
                        var bankData = notificationList[index];
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 5.0),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16.0), // Adjusted content padding
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                "assets/images/png/profileImagee.png",
                                fit: BoxFit.contain,
                                width: MediaQuery.of(context).size.width * 0.12,
                              ),
                            ),
                            title: Center(
                              // Centering the title text
                              child: Text(
                                notificationList[index] ?? "",
                                style: textRegular.copyWith(
                                  fontSize: AppSize.sp16,
                                  color: AppColor.black,
                                ),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Text(
                        'See all',
                        style: textSemiBold.copyWith(
                          color: AppColor.textBlueColor,
                          fontSize: AppSize.sp16,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SpaceV(AppSize.h20),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        "assets/images/svgs/makaiLogo.svg",
                        width: MediaQuery.of(context).size.width * 0.12,
                      ),
                      SizedBox(
                        width: AppSize.w32,
                      ),
                      Text(
                        "NEW APP UPDATE IS HERE !",
                        style: textRegular.copyWith(
                          fontSize: AppSize.sp16,
                          color: AppColor.black,
                        ),
                      ),
                    ],
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
