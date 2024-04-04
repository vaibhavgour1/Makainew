import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:makaihealth/gen/assets.gen.dart';
import 'package:makaihealth/utility/colors.dart';
import 'package:makaihealth/utility/dimension.dart';
import 'package:makaihealth/utility/string_constants.dart';
import 'package:makaihealth/utility/text_styles.dart';
import 'package:makaihealth/widget/app_button.dart';
import 'package:makaihealth/widget/space_vertical.dart';
import 'package:makaihealth/widget/text_form_filed.dart';

class DoctorInfoScreen extends StatefulWidget {
  const DoctorInfoScreen({super.key});

  @override
  State<DoctorInfoScreen> createState() => _DoctorInfoScreenState();
}

class _DoctorInfoScreenState extends State<DoctorInfoScreen> {
  TextEditingController _searchdoctornameController = TextEditingController();
  TextEditingController _searchmediciesController = TextEditingController();

  String search = '';
  String putData = '';
  String doctorNamee = '';

  bool showMyMediacience = false;
  bool _buttonClicked = false;

  final List<Map<String, String>> DoctorInfoScreen = [
    {"name": "Metformin"},
    {"name": "Victoza"},
    {"name": "Glipizide"},
    {"name": "Janumet"},
    {"name": "Lantus"},
    {"name": "Glimepiride"},
    {"name": "Insulin"},
    {"name": "Meglitinides"},
    {"name": "Sulfonylureas"},
  ];

  final List<Map<String, String>> addmymedicalCondition = [];
  final List<Map<String, String>> doctorname = [];

  @override
  Widget build(BuildContext context) {
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
                            context.go('/MedicalConditionScreen');
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
                    //SpaceV(AppSize.h20),

                    SpaceV(AppSize.h20),
                    if (!showMyMediacience)
                      Column(
                        children: [
                          SpaceV(AppSize.h20),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(0),
                              border: Border.all(
                                color: Colors.grey,
                                width: 1.5,
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                    "assets/images/svgs/docInfo.svg"),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: TextField(
                                    controller: _searchdoctornameController,
                                    onChanged: (value) {
                                      setState(() {
                                        doctorNamee =
                                            _searchdoctornameController.text
                                                .toString();
                                      });
                                    },
                                    decoration: InputDecoration(
                                      hintText: "Doctor name",
                                      hintStyle: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: AppSize.sp14,
                                        color: AppColor.black,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: AppSize.h40,
                          )
                        ],
                      ),
                    if (showMyMediacience)
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ///////////////////////////////////////////

                          Text(
                            doctorNamee,
                            style: textSemiBold.copyWith(
                                color: AppColor.black, fontSize: AppSize.sp16),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SpaceV(AppSize.h10),
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
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ListTile(
                                      leading: SvgPicture.asset(
                                          "assets/images/svgs/medicalconditionMyconImg.svg"),
                                      iconColor: AppColor.black,
                                      //trailing:  Assets.images.svgs.amico.svg(),
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
                              },
                            ),
                          ),
                          SpaceV(AppSize.h12),
                          if (_buttonClicked == false)
                            AppButton(
                              addMedication,
                              () {
                                setState(() {
                                  addmymedicalCondition.add({
                                    "name": putData,
                                  });
                                  _searchmediciesController.clear();
                                  _buttonClicked =
                                      true; // Set buttonClicked to true after clicking
                                });
                              },
                              isDisabled:
                                  _buttonClicked, // Disable button if buttonClicked is true
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
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.search,
                            color: AppColor.black,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              controller: _searchmediciesController,
                              onChanged: (String? value) {
                                setState(() {
                                  search = value.toString();
                                });
                              },
                              decoration: InputDecoration(
                                hintText: "Search your medicies",
                                hintStyle: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: AppSize.sp14,
                                  color: AppColor.black,
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
                      height: MediaQuery.of(context).size.height * 0.24,
                      child: ListView.builder(
                        itemCount: DoctorInfoScreen.length,
                        itemBuilder: (BuildContext context, int index) {
                          var medicalCon = DoctorInfoScreen[index];
                          late String postion =
                              DoctorInfoScreen[index].toString();
                          if (_searchmediciesController.text.isEmpty) {
                            return Column(
                              children: [
                                ListTile(
                                  leading: Assets.images.svgs.medicalCon.svg(),
                                  iconColor: AppColor.black,
                                  //trailing:  Assets.images.svgs.amico.svg(),
                                  title: Text(
                                    medicalCon["name"]!,
                                    style: textBold.copyWith(
                                        fontSize: AppSize.sp14,
                                        color: AppColor.black),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      showMyMediacience = true;
                                    });
                                  },
                                ),
                              ],
                            );
                          } else if (postion.toLowerCase().contains(
                              _searchmediciesController.text.toLowerCase())) {
                            return Column(
                              children: [
                                ListTile(
                                  leading: Assets.images.svgs.medicalCon.svg(),
                                  iconColor: AppColor.black,
                                  //trailing:  Assets.images.svgs.amico.svg(),
                                  title: Text(
                                    medicalCon["name"]!,
                                    style: textBold.copyWith(
                                        fontSize: AppSize.sp14,
                                        color: AppColor.black),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      showMyMediacience = true;
                                      putData = medicalCon["name"]!;
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
                    // AppButton(
                    //   submitButton,
                    //   () {
                    //     setState(() {
                    //       showMyMediacience = false;
                    //     });
                    //     context.go('/DoctorInfoScreen');
                    //   },
                    //   isDisabled: false,
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
        if (showMyMediacience == false)
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.02,
            left: MediaQuery.of(context).size.width * 0.07,
            right: MediaQuery.of(context).size.width * 0.07,
            child: AppButton(
              selectCondition,
              () {
                setState(() {
                  showMyMediacience = false;
                });
                // context.go('/DoctorInfoScreen');
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
                  showMyMediacience = false;
                });
                context.go('/PatientProfileScreen');
              },
              isDisabled: false,
            ),
          )
      ],
    );
  }
}
