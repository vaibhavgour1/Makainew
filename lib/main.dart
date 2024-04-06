import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:makaihealth/extensions/constants.dart';
import 'package:makaihealth/utility/theme.dart';

import 'routes/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: 'AIzaSyDrN1vBoB4z6Cb4rdkMghyLsH50utcOVNE',
              appId: '1:1082232456431:android:f98c0636516add2430071a',
              messagingSenderId: '1082232456431',
              projectId: 'makaihealth'))
      : await Firebase.initializeApp();

// Ideal time to initialize
  //await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        minTextAdapt: true,
        designSize: designSize, // Figma page size
        builder: (BuildContext context, Widget? child) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: appTheme,
            routerConfig: router,
          );
        });
  }
}
