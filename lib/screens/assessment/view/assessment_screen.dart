import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:makaihealth/main.dart';
import 'package:makaihealth/screens/assessment/response/AssessmentsResponse.dart';
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
  Future<AssessmentsResponse> futureAssessment = apiProvider.getAssesments();
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
                              'assets/images/svgs/drawerAssement.svg',
                              height: AppSize.h28,
                              color: Colors.black,
                            ),
                            SizedBox(width: AppSize.w8),
                            // Adjust the width as needed
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
                FutureBuilder<AssessmentsResponse>(
                  future: futureAssessment,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (snapshot.hasData) {
                      final assessments = snapshot.data!.data;
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: assessments!.length,
                        itemBuilder: (context, index) {
                          final assessment = assessments[index];
                          return ExpansionTile(
                            title: Text(
                              'Assessment ID: ${assessment.id}',
                              style: textBold.copyWith(color: AppColor.black),
                            ),
                            children: [
                              ListTile(
                                title: Text(
                                  'Patient Name: ${assessment.patientId},',
                                  style:
                                      textBold.copyWith(color: AppColor.black),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'BP: ${assessment.bp}',
                                      style: textSemiBold.copyWith(
                                          color: AppColor.black,
                                          fontSize: AppSize.sp14),
                                    ),
                                    Text(
                                      'Ankle Girth: ${assessment.ankleGirth}',
                                      style: textSemiBold.copyWith(
                                          color: AppColor.black,
                                          fontSize: AppSize.sp14),
                                    ),
                                    Text(
                                      'Breathlessness Score: ${assessment.breathlessnessScore}',
                                      style: textSemiBold.copyWith(
                                          color: AppColor.black,
                                          fontSize: AppSize.sp14),
                                    ),
                                    Text(
                                      'Fever: ${assessment.fever}',
                                      style: textSemiBold.copyWith(
                                          color: AppColor.black,
                                          fontSize: AppSize.sp14),
                                    ),
                                    Text(
                                      'Weight Changes: ${assessment.weightChanges}',
                                      style: textSemiBold.copyWith(
                                          color: AppColor.black,
                                          fontSize: AppSize.sp14),
                                    ),
                                    Text(
                                      'Urinary Frequency: ${assessment.urinaryFrequency}',
                                      style: textSemiBold.copyWith(
                                          color: AppColor.black,
                                          fontSize: AppSize.sp14),
                                    ),
                                    Text(
                                      'Pulse Reading: ${assessment.pulseReading}',
                                      style: textSemiBold.copyWith(
                                          color: AppColor.black,
                                          fontSize: AppSize.sp14),
                                    ),
                                    Text(
                                      'Weakness Scale: ${assessment.weaknessScale}',
                                      style: textSemiBold.copyWith(
                                          color: AppColor.black,
                                          fontSize: AppSize.sp14),
                                    ),
                                    // Add other fields as needed
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      return const Center(child: Text('No data available'));
                    }
                  },
                ),
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
      padding: const EdgeInsets.all(8.0),
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
                style: const TextStyle(color: AppColor.textBlueColor),
              ),
            ],
          );
        }),
      ),
    );
  }
}

class MyChart extends StatelessWidget {
  const MyChart({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
