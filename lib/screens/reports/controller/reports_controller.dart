import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';


class ReportsController extends GetxController {
  var isLoading = false.obs;
  TextEditingController fileController = TextEditingController();
  final List<String> reportsList = [
    "Diabetes",
  ];

  File? selectedFile;
  String? selectedFileName;

  Future<void> fileUpload() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx'],
      );

      if (result != null) {
        PlatformFile file = result.files.single;
        selectedFile = File(file.path!);
        selectedFileName = file.name;
        fileController.text = selectedFileName!;
        reportsList.add(selectedFileName!);

      } else {
        // User canceled file selection
      }
    } catch (e) {
      print("Error picking file: $e");
    }
  }
}