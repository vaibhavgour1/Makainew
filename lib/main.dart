import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:makaihealth/extensions/constants.dart';
import 'package:makaihealth/utility/socket.io.dart';
import 'package:makaihealth/utility/theme.dart';

import 'routes/app_router.dart';


void main() {

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
