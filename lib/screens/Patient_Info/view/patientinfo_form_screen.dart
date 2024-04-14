import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:makaihealth/screens/Patient_Info/controller/patient_info_controller.dart';
import 'package:makaihealth/utility/colors.dart';
import 'package:makaihealth/utility/dimension.dart';
import 'package:makaihealth/utility/logger.dart';
import 'package:makaihealth/utility/sharedpref.dart';
import 'package:makaihealth/utility/string_constants.dart';
import 'package:makaihealth/utility/text_styles.dart';
import 'package:makaihealth/widget/app_button.dart';
import 'package:makaihealth/widget/space_vertical.dart';
import 'package:makaihealth/widget/text_form_filed.dart';

class PatientInfoFormScreen extends StatefulWidget {
  const PatientInfoFormScreen({super.key});

  @override
  State<PatientInfoFormScreen> createState() => _PatientInfoFormScreenState();
}

class _PatientInfoFormScreenState extends State<PatientInfoFormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DateTime? selectedDate;
  String hintText = 'Birth Date';
  Map<String, String> profileData = {};
  final PatientInfoController _patientInfoController =
      Get.put(PatientInfoController());
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkProfile();
  }
  checkProfile() async {
    retrieveData(await SharedPref.getStringPreference(SharedPref.MOBILE)).then((value){

    value.logD;if(value!=null){
      context.go('/HomeView');
    }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          body: Form(
            key: _formKey,
            child: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(AppSize.w36),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_back,color: AppColor.black,)),
                      SpaceV(AppSize.h40),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              context.go('/LoginwithEmailScreen');
                            },
                            child: SvgPicture.asset(
                              "assets/images/svgs/backArrow.svg",

                              colorFilter: const ColorFilter.mode(AppColor.black, BlendMode.srcIn),
                            ),
                          ),
                          SizedBox(
                            width: AppSize.w48,
                          ),
                          Text(
                            patientInfo,
                            style: textSemiBold.copyWith(
                                color: AppColor.black, fontSize: AppSize.sp22),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),

                      SpaceV(AppSize.h40),

                      AppFormTextField(
                        label: 'Name',
                        hint: 'Name',
                        controller: _patientInfoController.nameController.value,
                        validators: (value) {
                          if (_patientInfoController
                              .nameController.value.text.isEmpty) {
                            return 'Enter Name';
                          }
                          return null; // Return null if validation passes
                        },
                        textStyle: textRegular.copyWith(
                            fontSize: AppSize.sp12,
                            color: AppColor.colorHint,
                            fontWeight: FontWeight.w500),
                        keyboardType: TextInputType.emailAddress,
                      ),

                      SpaceV(AppSize.h20),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  right:
                                      8.0), // Adjust spacing between fields as needed
                              child: AppFormTextField(
                                label: 'Gender',
                                hint: 'Gender',
                                controller:
                                    _patientInfoController.genderController.value,
                                validators: (value) {
                                  if (_patientInfoController
                                      .genderController.value.text.isEmpty) {
                                    return 'Enter Your Gender';
                                  }
                                  return null; // Return null if validation passes
                                },
                                textStyle: textRegular.copyWith(
                                  fontSize: AppSize.sp12,
                                  color: AppColor.colorHint,
                                  fontWeight: FontWeight.w500,
                                ),
                                keyboardType: TextInputType.emailAddress,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left:
                                      8.0), // Adjust spacing between fields as needed
                              child: AppFormTextField(
                                label: 'Birth Date',
                                hint: hintText,
                                controller:
                                    _patientInfoController.birthdateController.value,
                                onTap: () async {
                                  selectedDate = await datePicker(context);
                                  if (selectedDate != null) {
                                    String date = DateFormat('dd-MM-yyyy')
                                        .format(selectedDate!);
                                    _patientInfoController.birthdateController.value.text =
                                        date;
                                    setState(() {
                                      hintText =
                                          date; // Update the hint text with selected date
                                    });
                                  }
                                },
                                validators: (value) {
                                  if (_patientInfoController
                                      .birthdateController.value.text.isEmpty) {
                                    return 'Enter your Birthdate';
                                  }
                                  return null; // Return null if validation passes
                                },
                                textStyle: textRegular.copyWith(
                                  fontSize: AppSize.sp12,
                                  color: AppColor.colorHint,
                                  fontWeight: FontWeight.w500,
                                ),
                                keyboardType: TextInputType.none,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SpaceV(AppSize.h20),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  right:
                                      8.0), // Adjust spacing between fields as needed
                              child: AppFormTextField(
                                label: 'Weight',
                                hint: 'Weight',
                                controller:
                                    _patientInfoController.weightController.value,
                                validators: (value) {
                                  if (_patientInfoController
                                      .weightController.value.text.isEmpty) {
                                    return 'Enter weight';
                                  }
                                  return null; // Return null if validation passes
                                },
                                textStyle: textRegular.copyWith(
                                  fontSize: AppSize.sp12,
                                  color: AppColor.colorHint,
                                  fontWeight: FontWeight.w500,
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: AppFormTextField(
                                label: 'Height',
                                hint: 'Height',
                                controller:
                                    _patientInfoController.heightController.value,
                                validators: (value) {
                                  if (_patientInfoController
                                      .heightController.value.text.isEmpty) {
                                    return 'Enter height';
                                  }
                                  return null; // Return null if validation passes
                                },
                                textStyle: textRegular.copyWith(
                                  fontSize: AppSize.sp12,
                                  color: AppColor.colorHint,
                                  fontWeight: FontWeight.w500,
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SpaceV(AppSize.h40),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: MediaQuery.of(context).size.height * 0.02,
          left: MediaQuery.of(context).size.width * 0.07,
          right: MediaQuery.of(context).size.width * 0.07,
          child: AppButton(
            submitButton,
            () {
              if (_formKey.currentState!.validate()) {

                _showMyDialog(context);
              }

              // context.go('');
            },
            isDisabled: false,
          ),
        )
      ],
    );
  }


  Row buildCheckboxRow(
      String label, bool value, ValueChanged<bool?> onChanged) {
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
          activeColor: AppColor.textGreenColor,
        ),
        //Text(label),
      ],
    );
  }

//Privacy Policy
  Future<void> _showMyDialog(BuildContext context) async {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Center(
          child: Container(
            width: screenWidth * 0.9,
            height: screenHeight * 0.65,
            decoration: BoxDecoration(
              color: AppColor.textColor,
              borderRadius: BorderRadius.circular(40),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.3),
                  spreadRadius: 3,
                  blurRadius: 7,
                  offset: const Offset(0, 1), // changes position of shadow
                ),
              ],
            ),
            child: AlertDialog(
              backgroundColor: Colors.transparent,
              contentPadding: EdgeInsets.zero,
              content: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Text(
                        'Privacy policy',
                        style: textBold.copyWith(
                          fontSize: AppSize.sp16,
                          color: AppColor.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: AppSize.h20),
                      const Text(
                        "Your Agreement by using this app, you to besound cy, and to comtpry hith, Terms and Conditions. \n   If you do not to these ferms and conditions Your Agreement by using this app, you to besound cy, and to comtpry hith, Terms and Conditions. If you do not  to these ferms and conditions. \n Your Agreement by using this app, you agree to besound cy, and to comtpry hith, theseTerms and Conditions. If you do not",
                        style: TextStyle(
                          color: AppColor.black,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: AppSize.h30,
                      ),
                      AppButton(
                        iAccept,
                        () async {
                          //Navigator.of(context).pop();
                          // CollectionReference collRef = FirebaseFirestore.instance.collection('userprofile');
                          // collRef.add({
                          //   'name': _patientInfoController.nameController.value.text,
                          //   'gender':_patientInfoController.genderController.value.text,
                          //   'dob':_patientInfoController.birthdateController.value.text,
                          //   'weight':_patientInfoController.weightController.value.text,
                          //   'height':_patientInfoController.heightController.value.text,
                          // });
                          profileData['name']=_patientInfoController.nameController.value.text;
                          profileData['gender']=_patientInfoController.genderController.value.text;
                          profileData['dob']=_patientInfoController.birthdateController.value.text;
                          profileData['weight']=_patientInfoController.weightController.value.text;
                          profileData['height']=_patientInfoController.heightController.value.text;
                          (await SharedPref.getStringPreference(SharedPref.MOBILE)).logD;
                          storeData(await SharedPref.getStringPreference(SharedPref.MOBILE), profileData);                        //  context.go('/PatientProfileScreen');
                        retrieveData(await SharedPref.getStringPreference(SharedPref.MOBILE)).then((value){

                          value.logD;
                          context.go('/HomeView');
                        });
                        },
                        isDisabled: false,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
  Future<Map<String, dynamic>?> retrieveData(String mobileNumber) async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('usersProfile').doc(mobileNumber).get();
      if (snapshot.exists) {
        snapshot.data().logD;
        return snapshot.data() as Map<String, dynamic>;
      } else {
        ('No data found for mobile number: $mobileNumber').logD;
        return null;
      }
    } catch (e) {
      ('Error retrieving data: $e').logD;
      return null;
    }
  }

  void storeData(String mobileNumber, Map<String, dynamic> data) async {
    try {
      await FirebaseFirestore.instance.collection('usersProfile').doc(mobileNumber).set(data);
      ('Data stored successfully for mobile number: $mobileNumber').logD;
    } catch (e) {
      ('Error storing data: $e').logD;
    }
  }
  Future<DateTime?> datePicker(BuildContext context) async {
    return await showDatePicker(
      context: context,
      initialDate: _patientInfoController.birthdateController.value.text.isNotEmpty
          ? DateTime.parse(DateFormat('yyyy-MM-dd').format(
              DateFormat("dd-MM-yyyy")
                  .parse(_patientInfoController.birthdateController.value.text)))
          : DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 100),
      lastDate: DateTime.now(),
    );
  }
}
