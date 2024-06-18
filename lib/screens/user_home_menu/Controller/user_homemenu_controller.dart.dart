import 'dart:io';
import 'dart:typed_data';

import 'package:get/get.dart';

class UserHomeMenuController extends GetxController {
  var isLoading = false.obs;
  //XFile? image;
  Rx<int> selectedPositionIndex = 0.obs;
  Uint8List? imageFile;
  String? imagePath = '';
  double containerHeight = 0.20;

  List<Map<String, String>> data = [
    {'name': 'Bank Details'},
    {'name': 'Nominee Details'},
    {'name': 'Change MPIN'},
    {'name': 'Logout'},
  ];

  void toggleContainerSize(double x) {
    containerHeight = containerHeight == 0.20 ? x : 0.20;
    update(); // Notify listeners of the change
  }

  // Future<void> pickImage() async {
  //   try {
  //     // final image = await ImagePicker().pickImage(
  //     //   source: ImageSource.gallery, // or ImageSource.camera for the camera
  //     // );
  //
  //     if (image != null) {
  //       File? img = File(image.path);
  //       img = await cropimage(imageFile: img);
  //       imagePath = img!.path;
  //       imageFile = await img.readAsBytes();
  //
  //       print(imagePath);
  //       update();
  //     }
  //   } catch (e) {
  //     imageFile = null;
  //     update();
  //   }
  // }

  // Future<File?> cropimage({required File imageFile}) async {
  //   CroppedFile? croppedImage =
  //   await ImageCropper().cropImage(sourcePath: imageFile.path);
  //   if (croppedImage == null) return null;
  //   return File(croppedImage.path);
  // }
}
