
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:makaihealth/api/retriveData.dart';
import 'package:makaihealth/screens/user_profile/controller/edit_profile_controller.dart';
import 'package:makaihealth/utility/colors.dart';
import 'package:makaihealth/utility/dimension.dart';
import 'package:makaihealth/utility/sharedpref.dart';
import 'package:makaihealth/utility/string_constants.dart';
import 'package:makaihealth/utility/text_styles.dart';
import 'package:makaihealth/widget/app_button.dart';
import 'package:makaihealth/widget/space_horizontal.dart';
import 'package:makaihealth/widget/space_vertical.dart';
import 'package:makaihealth/widget/text_form_filed.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DateTime? selectedDate;
  String hintText = 'Birth Date';

  final EditProfileController _editProfileController =
      Get.put(EditProfileController());
@override
  void initState() {
    // TODO: implement initState
    super.initState();
getData();
  }
  getData() async {
    String mobileNumber = await SharedPref.getStringPreference(SharedPref.MOBILE);

    retrieveData(mobileNumber, 'usersProfile').then((value){
      _editProfileController.namecontroller.text = value!['name'];
      _editProfileController.genderController.text = value['dob'];
      _editProfileController.birthdateController.text = value['gender'];
      _editProfileController.weightController.text = value['weight'];
      _editProfileController.heightController.text = value['name'];
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
                      // SpaceV(AppSize.h40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              context.go('/PatientProfileScreen');
                            },
                              child: const Icon(Icons.arrow_back,color: AppColor.appbarBgColor)
                          ),
                          SpaceH(AppSize.w60),
                          Text(
                            editProfile,
                            style: textSemiBold.copyWith(
                                color: AppColor.black, fontSize: AppSize.sp22),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      SpaceV(AppSize.h40),
                      AppFormTextField(
                        label: 'Name',
                        hint: 'Name',
                        controller: _editProfileController.namecontroller,
                        readOnly: true,
                        validators: (value) {
                          if (_editProfileController
                              .namecontroller.text.isEmpty) {
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
                                readOnly: true,
                                controller:
                                    _editProfileController.genderController,
                                validators: (value) {
                                  if (_editProfileController
                                      .genderController.text.isEmpty) {
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
                                readOnly: true,
                                controller:
                                    _editProfileController.birthdateController,
                                onTap: () async {
                                  selectedDate = await datePicker(context);
                                  if (selectedDate != null) {
                                    String date = DateFormat('dd-MM-yyyy')
                                        .format(selectedDate!);
                                    _editProfileController
                                        .birthdateController.text = date;
                                    setState(() {
                                      hintText =
                                          date;
                                    });
                                  }
                                },
                                validators: (value) {
                                  if (_editProfileController
                                      .birthdateController.text.isEmpty) {
                                    return 'Enter your Birthdate';
                                  }
                                  return null;
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
                                    _editProfileController.weightController,
                                readOnly: true,
                                validators: (value) {
                                  if (_editProfileController
                                      .weightController.text.isEmpty) {
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
                              padding: const EdgeInsets.only(
                                  left:
                                      8.0), // Adjust spacing between fields as needed
                              child: AppFormTextField(
                                label: 'Height',
                                hint: 'Height',
                                controller:
                                    _editProfileController.heightController,
                                readOnly: true,
                                validators: (value) {
                                  if (_editProfileController
                                      .heightController.text.isEmpty) {
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
                context.go('/PatientProfileScreen');
              }
            },
            isDisabled: false,
          ),
        )
      ],
    );
  }

  Future<DateTime?> datePicker(BuildContext context) async {
    return await showDatePicker(
      context: context,
      initialDate:
          _editProfileController.birthdateController.value.text.isNotEmpty
              ? DateTime.parse(DateFormat('yyyy-MM-dd').format(
                  DateFormat("dd-MM-yyyy").parse(
                      _editProfileController.birthdateController.value.text)))
              : DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 100),
      lastDate: DateTime.now(),
    );
  }
}
