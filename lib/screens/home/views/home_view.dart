
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:makaihealth/gen/assets.gen.dart';
import 'package:makaihealth/screens/chat/views/chat_view.dart';
import 'package:makaihealth/utility/dimension.dart';
import 'package:makaihealth/utility/socket.io.dart';
import 'package:makaihealth/utility/text_styles.dart';import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:uuid/uuid.dart';

import '../../../utility/colors.dart';
import '../controllers/home_controller.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TextEditingController textEditingController = TextEditingController();

  final HomeController _homeController = Get.put(HomeController());
  late IO.Socket socket;
  final sessionId = const Uuid().v1();

  // time-based
  final userId = const Uuid().v4();
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    //https://endpoint-trial.cognigy.ai/82983e3827da918787dcdb49d403f4d224c25f69bb348ce7921e3a80a72c07bd
    //https://endpoint-trial.cognigy.ai/0515c90aa09e21c46a4b577864b8f68d7a58236c340efb41a40b18a1e9747fb8
    //https://endpoint-trial.cognigy.ai/bafebec090f608f17d1a8878cae34bf5d09099df639919002ee75de038c64f57

    log('Connected--->S');
  IO.Socket socket =
      IO.io('https://endpoint-trial.cognigy.ai/', <String, dynamic>{
    'transports': ['websocket'],
    //   'autoConnect': false,
    'extraHeaders': {
      'URLToken':
          'bafebec090f608f17d1a8878cae34bf5d09099df639919002ee75de038c64f57'
    }
  });
  socket.connect();

  // Subscribe to events
  socket.onConnect((_) {
    log('Connected socket==>$userId');
    log('Connected socket==>$sessionId');
    socket.emit('processInput', {
      'URLToken':
          'bafebec090f608f17d1a8878cae34bf5d09099df639919002ee75de038c64f57',
      'text': "vaibhav",
      'userId': userId,
      'sessionId': sessionId,
      'channel': 'flutter',
      'source': 'device',
      "data": {
        'user_profile': 'AppString.userMobile)',
        'email': 'vgour307@gmail.com',
        'name': 'vaibhav',
        'base': 'mp4',
        'url': '',
        'slug': 'slug',
        'patientId': userId,
        'patientConditionId': 'patientConditionId',
      },
    });
    log('Connected socket');
  });

  log("${socket.id}");
  socket.onDisconnect((_) => log('Disconnected'));
  // socket.on('connect', (data) {
  //   log('Message: $data');
  // });
  // socket.on('output', (response) {
  //   log('output response : ${response.toString()}');
  // });
  // SocketService().connect();
  // SocketService().sendMessage("text", "data");
  }
// final ProfileController _controller = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _homeController.drawerKey,
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: const Icon(
              Icons.menu,
              color: AppColor.black,
            ),
            onPressed: () {
              _homeController.drawerKey.currentState?.openDrawer();
            }),
        centerTitle: false,
      ),
     // drawer: AppDrawerView(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Assets.images.svgs.makaiLogo.svg(
                        height: context.height * 0.20,
                        width: context.height * 0.20),
                    Text(
                      'MAK AI',
                      style: textSemiBold.copyWith(
                          color: AppColor.black, fontSize: AppSize.sp32),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ]),
            ),
            const SizedBox(height: 20), // Add some space between logo and button
            // Button for starting assessment
            ElevatedButton(
              onPressed: () {
                // Add logic to start assessment
                SocketService.createSocketConnection();
              },
              style:  ButtonStyle( backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                  // Here, you can define the color based on different states
                  if (states.contains(MaterialState.pressed)) {
                    // Color when button is pressed
                    return AppColor.textBlueColor;
                  }
                  // Default color
                  return AppColor.textBlueColor;
                },
              ),),
              child: const Text('Start Assessment',style: TextStyle(color: AppColor.white),),
            ),
            // Add some space between button and text form
            // Text form at the bottom
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller:textEditingController ,
                      decoration: const InputDecoration(
                        hintText: 'Enter your message',
                        hintStyle: TextStyle(color: AppColor.black),
                        border: OutlineInputBorder(),

                      ),

                    ),
                  ),
                  const SizedBox(width: 10), // Add space between text form and send button
                  // Send button
                  ElevatedButton(
                    child: const Text('Send',style: TextStyle(color: AppColor.white),),
                    onPressed: () {

                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}
