import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:go_router/go_router.dart';
import 'package:makaihealth/gen/assets.gen.dart';
import 'package:makaihealth/utility/colors.dart';
import 'package:makaihealth/utility/dimension.dart';
import 'package:makaihealth/utility/string_constants.dart';
import 'package:makaihealth/utility/text_styles.dart';
import 'package:makaihealth/widget/app_button.dart';
import 'package:makaihealth/widget/space_vertical.dart';

class MedicalConditionScreen extends StatefulWidget {
  const MedicalConditionScreen({super.key});

  @override
  State<MedicalConditionScreen> createState() => _MedicalConditionScreenState();
}

class _MedicalConditionScreenState extends State<MedicalConditionScreen> {
  bool showMyCondition = false;
  bool _buttonClicked = false;

  TextEditingController _searchController = TextEditingController();
  String search = '';
  String putData = '';

  @override
  final List<Map<String, String>> addmedicalCondition = [
    {"name": "autism"},
    {
      "name": "epilepsy",
    },
    {"name": "blood disorders."},
    {"name": "hepatitis B.."},
    {
      "name": "Parkinson's disease..",
    },
  ];

  List<Map<String, String>> addmymedicalCondition = [];

  @override
  Widget build(BuildContext context) {
    //bool showSuffix = _searchController.text.isNotEmpty;
    String filterText = '';

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
                    SpaceV(AppSize.h40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            context.go('/EditProfileScreen');
                          },
                          child: SvgPicture.asset(
                            "assets/images/svgs/backArrow.svg",
                           color: AppColor.black,
                          ),
                        ),
                        SizedBox(
                          width: AppSize.w40,
                        ),
                        Text(
                          medicalCondition,
                          style: textSemiBold.copyWith(
                              color: AppColor.black, fontSize: AppSize.sp22),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    SpaceV(AppSize.h40),
                    // Conditionally display mycondition and addmymedicalCondition
                    if (showMyCondition)
                      Column(
                        children: [
                          Text(
                            myCondition,
                            style: textSemiBold.copyWith(
                                color: AppColor.black, fontSize: AppSize.sp22),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                          ),
                          SpaceV(AppSize.h10),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.13,
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: addmymedicalCondition.length,
                              itemBuilder: (BuildContext context, int index) {
                                var medicalCon = addmymedicalCondition[index];

                                // Check if the filterText is empty or if the name contains the filterText
                                if (filterText.isEmpty ||
                                    medicalCon["name"]!
                                        .toLowerCase()
                                        .contains(filterText)) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ListTile(
                                        leading: SvgPicture.asset(
                                            "assets/images/svgs/medicalconditionMyconImg.svg"),
                                        iconColor: AppColor.black,
                                        title: Text(
                                          medicalCon["name"]!,
                                          style: textBold.copyWith(
                                              fontSize: AppSize.sp14,
                                              color: AppColor.black),
                                        ),
                                        onTap: () {},
                                      ),
                                    ],
                                  );
                                } else {
                                  // Return an empty container if the condition doesn't match the filter
                                  return Container();
                                }
                              },
                            ),
                          ),
                          SpaceV(AppSize.h12),
                          if (_buttonClicked == false)
                            AppButton(
                              addCondition,
                              () {
                                setState(() {
                                  addmymedicalCondition.add({
                                    "name": putData,
                                  });
                                  _buttonClicked = true;
                                  _searchController.clear();
                                  //  showMyCondition = false;
                                });
                              },
                              isDisabled: _buttonClicked,
                            ),
                        ],
                      ),

                    SpaceV(AppSize.h10),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.5,
                        ),
                      ),
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextFormField(
                              controller: _searchController,
                              onChanged: (String? Value) {
                                setState(() {
                                  search = Value.toString();
                                });
                              },
                              decoration: const InputDecoration(
                                hintText: "Search your condition",
                                hintStyle: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.0,
                                  color: Colors.black,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SpaceV(AppSize.h20),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.27,
                      child: ListView.builder(
                        itemCount: addmedicalCondition.length,
                        itemBuilder: (BuildContext context, int index) {
                          var medicalCon = addmedicalCondition[index];
                          late String postion =
                              addmedicalCondition[index].toString();
                          if (_searchController.text.isEmpty) {
                            return Column(
                              children: [
                                ListTile(
                                  leading: Assets.images.svgs.medicalCon.svg(),
                                  iconColor: AppColor.black,
                                  title: Text(
                                    medicalCon["name"]!,
                                    style: textBold.copyWith(
                                      fontSize: AppSize.sp14,
                                      color: AppColor.black,
                                    ),
                                  ),
                                  onTap: () {},
                                ),
                              ],
                            );
                          } else if (postion
                              .toLowerCase()
                              .contains(_searchController.text.toLowerCase())) {
                            return Column(
                              children: [
                                ListTile(
                                  leading: Assets.images.svgs.medicalCon.svg(),
                                  iconColor: AppColor.black,
                                  title: Text(
                                    medicalCon["name"]!,
                                    style: textBold.copyWith(
                                      fontSize: AppSize.sp14,
                                      color: AppColor.black,
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      putData = medicalCon["name"]!;
                                      showMyCondition = true;
                                      // addmymedicalCondition.add({
                                      //   "name": medicalCon["name"]!,
                                      // });

                                      _searchController.clear();
                                    });
                                  },
                                ),
                              ],
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ),
                    SpaceV(AppSize.h40),
                  ],
                ),
              ),
            ),
          ),
        ),
        if (showMyCondition == false)
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.02,
            left: MediaQuery.of(context).size.width * 0.07,
            right: MediaQuery.of(context).size.width * 0.07,
            child: AppButton(
              selectCondition,
              () {
                setState(() {
                  showMyCondition = false;
                });
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
              () {
                setState(() {
                  showMyCondition = false;
                });
                context.go('/DoctorInfoScreen');
              },
              isDisabled: false,
            ),
          )
      ],
    );
  }
}
