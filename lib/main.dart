import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:makaihealth/api/api_provider.dart';
import 'package:makaihealth/extensions/constants.dart';
import 'package:makaihealth/utility/dependency_injection.dart';
import 'package:makaihealth/utility/logger.dart';
import 'package:makaihealth/utility/theme.dart';
import 'package:kommunicate_flutter/kommunicate_flutter.dart';

import 'routes/app_router.dart';
import 'utility/app_initializer.dart';
 Injector? injector;
BaseOptions baseOptions = BaseOptions(
  //baseUrl: Endpoint.BASE_URL_DEVLOPMENT,
  receiveTimeout: const Duration(seconds: 40),
  sendTimeout: const Duration(seconds: 40),
  connectTimeout: const Duration(seconds: 40),
  responseType: ResponseType.json,
  maxRedirects: 3,
);
 Dio dio = Dio(baseOptions);
ApiProvider apiProvider = ApiProvider();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  dio.interceptors.add(LogInterceptor(
      responseBody: true,
      responseHeader: false,
      requestBody: true,
      request: true,
      requestHeader: true,
      error: true,
      logPrint: (text) {
        text.toString().logD;
      }));
  try {
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: 'AIzaSyDrN1vBoB4z6Cb4rdkMghyLsH50utcOVNE',
              appId: '1:1082232456431:android:f98c0636516add2430071a',
              messagingSenderId: '1082232456431',
              projectId: 'makaihealth'))
      : await Firebase.initializeApp();
  } catch(e) {

    ("Failed to initialize Firebase: $e").logD;
  }
  //DependencyInjection().initialise(Injector());
  // injector = Injector();
  // await AppInitializer().initialise(injector!);
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
