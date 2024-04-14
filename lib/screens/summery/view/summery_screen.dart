import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:makaihealth/gen/assets.gen.dart';
import 'package:makaihealth/utility/colors.dart';
import 'package:makaihealth/utility/dimension.dart';
import 'package:makaihealth/utility/string_constants.dart';
import 'package:makaihealth/utility/text_styles.dart';
import 'package:makaihealth/widget/space_horizontal.dart';
import 'package:makaihealth/widget/space_vertical.dart';
import 'package:pie_chart/pie_chart.dart';

class SummeryScreen extends StatefulWidget {
  const SummeryScreen({super.key});

  @override
  State<SummeryScreen> createState() => _SummeryScreenState();
}

class _SummeryScreenState extends State<SummeryScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Map<String, double> dataMap = {
    "Flutter": 5,
    "React": 3,
    "Xamarin": 2,
    "Ionic": 2,
  };


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
                          child: const Icon(Icons.arrow_back,color: AppColor.appbarBgColor)
                      ),
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
                SpaceV(AppSize.h20),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    medicationsEffects,
                    style: textMedium.copyWith(
                      color: AppColor.black,
                      fontSize: AppSize.sp16,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SpaceV(AppSize.h40),
                Container(
                  height: AppSize.h200,

                  child: PieChart(dataMap: dataMap,
                    legendOptions: LegendOptions(
                      showLegendsInRow: false,
                      showLegends: false,
                    ),
                    chartValuesOptions: ChartValuesOptions(
                      showChartValues: false,
                    ),
                  ),
                ),

                SpaceV(AppSize.h40),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    progressAfterMedications,
                    style: textMedium.copyWith(
                      color: AppColor.black,
                      fontSize: AppSize.sp16,
                    ),
                    overflow: TextOverflow.ellipsis,
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

