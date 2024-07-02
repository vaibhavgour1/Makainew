import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:go_router/go_router.dart';
import 'package:makaihealth/api/retriveData.dart';
import 'package:makaihealth/gen/assets.gen.dart';
import 'package:makaihealth/utility/colors.dart';
import 'package:makaihealth/utility/config.dart';
import 'package:makaihealth/utility/dimension.dart';
import 'package:makaihealth/utility/logger.dart';
import 'package:makaihealth/utility/sharedpref.dart';
import 'package:makaihealth/utility/text_styles.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:uuid/uuid.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late IO.Socket socket;
  final sessionId = const Uuid().v1();

  // time-based
  final userId = const Uuid().v4();

  @override
  void initState() {
    // TODO: implement initState
    //https://endpoint-trial.cognigy.ai/82983e3827da918787dcdb49d403f4d224c25f69bb348ce7921e3a80a72c07bd
    //https://endpoint-trial.cognigy.ai/0515c90aa09e21c46a4b577864b8f68d7a58236c340efb41a40b18a1e9747fb8
    //https://endpoint-trial.cognigy.ai/bafebec090f608f17d1a8878cae34bf5d09099df639919002ee75de038c64f57
    super.initState();
    log('Connected--->S');
    // IO.Socket socket =
    //     IO.io('https://endpoint-trial.cognigy.ai/',
    //         <String, dynamic>{
    //   'transports': ['websocket'],
    //     'autoConnect': false,
    //       'query': {
    //         'sessionId': Uri.encodeComponent(sessionId),
    //         'urlToken': Uri.encodeComponent(urlToken),
    //         'userId': Uri.encodeComponent(userId),
    //         'testMode': 'true',
    //         'emitWithAck': 'true' ,
    //       },
    //
    // });
    // socket.connect();
    //
    // // Subscribe to events
    // socket.onConnect((_) {
    //   log('Connected socket==>$userId');
    //   log('Connected socket==>$sessionId');
    //   socket.emit('processInput', {
    //     'URLToken': urlToken,
    //     'text': 'vaibhav',
    //     'userId': userId,
    //     'sessionId': sessionId,
    //     'channel': 'flutter',
    //     'source': 'device',
    //     'data': {
    //       'Patient': {},
    //       'Medicine': {},
    //       'Condition': {},
    //     },
    //   });
    //
    //   log('Connected socket');
    // });
    //
    // log("${socket.id}");
    // socket.onDisconnect((_) => log('Disconnected'));
    // socket.on('connect', (data) {
    //   log('Message: $data');
    // });
    // socket.on('output', (response) {
    //   log('output response : ${response.toString()}');
    // });
    // SocketService().connect();
    // SocketService().sendMessage("text", "data");
    login();
  }

  login() async {
    if (await SharedPref.getBooleanPreference(SharedPref.LOGIN)) {
      retrieveData(await SharedPref.getStringPreference(SharedPref.MOBILE))
          .then((value) {
        if (value != null) {
          Timer(
            const Duration(milliseconds: 3),
            () => context.go('/HomeView'),
          );
        } else {
          Timer(
            const Duration(seconds: 3),
            () => context.go('/PatientInfoFormScreen'),
          );
        }
      });
    } else {
      Timer(
        const Duration(seconds: 3),
        () => context.go('/OnboardingPage'),
      );
    }
  }

  @override
  void dispose() {
    //socket.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(children: [
        Align(
            alignment: Alignment.topLeft,
            child:
                Assets.images.svgs.capsul.svg(height: context.height * 0.25)),
        Padding(
          padding: EdgeInsets.only(
              bottom: context.height * 0.12, left: context.width * 0.12),
          child: Align(
            alignment: Alignment.center,
            child: Assets.images.svgs.doctor.svg(
              height: context.height * 0.35,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: AppSize.h20),
          child: Align(
              alignment: Alignment.bottomRight,
              child:
                  Assets.images.svgs.vector.svg(height: context.height * 0.25)),
        ),
        Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Assets.images.svgs.makaiLogo.svg(
                    height: context.height * 0.15,
                    width: context.height * 0.15),
                Text(
                  'MAKAI',
                  style: textSemiBold.copyWith(
                      color: AppColor.black, fontSize: AppSize.sp28),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ]),
        ),
      ]),
    ));
  }

  Future<Map<String, dynamic>?> retrieveData(String mobileNumber) async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('usersProfile')
          .doc(mobileNumber)
          .get();
      if (snapshot.exists) {

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
}
