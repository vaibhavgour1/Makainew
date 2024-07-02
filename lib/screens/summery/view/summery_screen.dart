import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:makaihealth/gen/assets.gen.dart';
import 'package:makaihealth/main.dart';
import 'package:makaihealth/screens/summery/response/summery-response.dart';
import 'package:makaihealth/utility/colors.dart';
import 'package:makaihealth/utility/dimension.dart';
import 'package:makaihealth/utility/string_constants.dart';
import 'package:makaihealth/utility/text_styles.dart';
import 'package:makaihealth/widget/space_horizontal.dart';
import 'package:dio/dio.dart';
import 'dart:developer';
// Update the import as per your project structure

class SummeryScreen extends StatefulWidget {
  const SummeryScreen({super.key});

  @override
  State<SummeryScreen> createState() => _SummeryScreenState();
}

class _SummeryScreenState extends State<SummeryScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Future<EvaluationsResponse> futureSummary = apiProvider.getSummery();

  @override
  void initState() {
    super.initState();
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
                          child: const Icon(Icons.arrow_back,
                              color: AppColor.appbarBgColor)),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Assets.images.svgs.summary.svg(),
                            SpaceH(AppSize.w10),
                            Text(
                              summery,
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
                FutureBuilder<EvaluationsResponse>(
                  future: futureSummary,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (snapshot.hasData) {
                      final summaries = snapshot.data!.data;
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: summaries!.length,
                        itemBuilder: (context, index) {
                          final summary = summaries[index];
                          return ExpansionTile(
                            title: Text(
                              'Summary ID: ${summary.llmEvaluationId}',
                              style: textBold.copyWith(color: AppColor.black),
                            ),
                            children: [
                              ListTile(
                                title: Text(
                                  'Patient Name: ${summary.patientId}',
                                  style:
                                      textBold.copyWith(color: AppColor.black),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Date: ${summary.date}',
                                      style: textBold.copyWith(
                                          color: AppColor.black),
                                    ),
                                    Text(
                                      'Evaluation: ${summary.evaluation}',
                                      style: textSemiBold.copyWith(
                                          color: AppColor.black,fontSize: AppSize.sp14),
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
                      return Center(
                          child: Text(
                        'No data available',
                        style: textBold.copyWith(color: AppColor.black),
                      ));
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
