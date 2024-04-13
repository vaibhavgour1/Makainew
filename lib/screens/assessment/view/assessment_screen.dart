import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:makaihealth/utility/colors.dart';
import 'package:makaihealth/utility/dimension.dart';
import 'package:makaihealth/utility/string_constants.dart';
import 'package:makaihealth/utility/text_styles.dart';
import 'package:makaihealth/widget/space_horizontal.dart';
import 'package:makaihealth/widget/space_vertical.dart';

class AssessmentScreen extends StatefulWidget {
  const AssessmentScreen({super.key});

  @override
  State<AssessmentScreen> createState() => _AssessmentScreenState();
}

class _AssessmentScreenState extends State<AssessmentScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<double> data = [0, 199, 399, 599, 799, 999]; // Example data values
  List<String> labels = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun'
  ]; // Example labels

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
                            SvgPicture.asset(
                              'assets/images/svgs/drawerAssement.svg',
                              height: AppSize.h28,
                              color: Colors.black,
                            ),
                            SizedBox(
                                width:
                                    AppSize.w8), // Adjust the width as needed
                            Text(
                              assessments,
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
                SpaceV(AppSize.h20),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    thisWeek,
                    style: textSemiBold.copyWith(
                      color: AppColor.black,
                      fontSize: AppSize.sp16,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SpaceV(AppSize.h40),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        thisWeeksStats,
                        style: textBold.copyWith(
                          color: AppColor.black,
                          fontSize: AppSize.sp12,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        showAll,
                        style: textBold.copyWith(
                          color: AppColor.textBlueColor,
                          fontSize: AppSize.sp12,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                BarChartWidget(data: data, labels: labels),
                SpaceV(AppSize.h20),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    lastMonths,
                    style: textSemiBold.copyWith(
                      color: AppColor.black,
                      fontSize: AppSize.sp16,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                 SpaceV(AppSize.h20),
                 
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BarChartWidget extends StatelessWidget {
  final List<double> data;
  final List<String> labels;

  const BarChartWidget({required this.data, required this.labels});

  @override
  Widget build(BuildContext context) {
    // Determine the maximum value in the data list
    double maxValue =
        data.reduce((value, element) => value > element ? value : element);

    return Container(
      height: AppSize.h200,
      padding: EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(data.length, (index) {
          double barHeight =
              (data[index] / maxValue) * AppSize.h140; // Adjust for bar height
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  Container(
                    width: AppSize.w16,
                    height: barHeight,
                    
                    color: AppColor.textBlueColor,
                  ),
                 SpaceH(AppSize.w10),
                  Container(
                    width: AppSize.w16,
                    height: barHeight,
                    color: AppColor.textBlueColor,
                  ),
                ],
              ),
              SpaceV(AppSize.h5),
              Text(
                labels[index],
                style: TextStyle(color: AppColor.textBlueColor),
              ),
            ],
          );
        }),
      ),
    );
  }
}


class mychart extends StatelessWidget {
  const mychart({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}




