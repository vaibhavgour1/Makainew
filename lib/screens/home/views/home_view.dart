import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:kommunicate_flutter/kommunicate_flutter.dart';
import 'package:makaihealth/api/retriveData.dart';
import 'package:makaihealth/gen/assets.gen.dart';
import 'package:makaihealth/main.dart';
import 'package:makaihealth/screens/home/response/chat_response.dart';
import 'package:makaihealth/utility/AppConfig.dart';
import 'package:makaihealth/utility/config.dart';
import 'package:makaihealth/utility/dimension.dart';
import 'package:makaihealth/utility/logger.dart';
import 'package:makaihealth/utility/message_helper.dart';
import 'package:makaihealth/utility/sharedpref.dart';
import 'package:makaihealth/utility/text_styles.dart';
import 'package:makaihealth/utility/utility.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:uuid/uuid.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../utility/colors.dart';
import '../controllers/home_controller.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TextEditingController textEditingController = TextEditingController();
  Timer? _debounce;
  final HomeController _homeController = Get.put(HomeController());

  // final ChatController chatController = Get.put(ChatController());
  late IO.Socket socket;
  final sessionId = const Uuid().v1();
  bool view = false;
  Map<String, dynamic> patient = {}, medicine = {}, condition = {};

  // time-based
  final userId = const Uuid().v4();
  ScrollController controller = ScrollController();
  List<String> messages = [];
  List<Widget> chatWidgets = [];
  String temp = '';
  WebViewController webViewController = WebViewController()
    ..loadRequest(Uri.parse(
        'https://endpoint-trial.cognigy.ai/68f015e6957578aa8c91f9cddd16c24a80403d1116fc43744b4abd83907026ae'))
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..clearCache();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userId.logD;
    // connectSocket();
  }

  Future<void> connectSocket() async {
    log('Initializing socket connection...');

    final Map<String, dynamic> input = {
      // Add your input data here
      'userId': userId,
      'sessionId': sessionId,
      "projectName": "VIVIENTH 2.0",
      'text': 'hello',
      "data": {
        'Patient': patient,
        'Medicine': medicine,
        'Condition': condition,
      }
      // ...
    };
    //  try {
    // Create socket connection with the specified endpoint and options
    // socket = IO.io(socketUrl, <String, dynamic>{
    //   'transports': ['websocket'],
    //   'autoConnect': false,
    //   'query': {
    //    'sessionId': Uri.encodeComponent(sessionId),
    //     'urlToken': Uri.encodeComponent(urlToken),
    //     'userId': Uri.encodeComponent(userId),
    //     'testMode': 'true',
    //     'emitWithAck': 'true' ,
    //   },
    //   'options':{
    //     'reconnectionLimit': 5,
    //   }
    // });
    // socket.connect();
    //
    // // Handle socket connection
    // socket.onConnect((_) => handleConnection());
    //
    // // Handle socket disconnection
    // socket.onDisconnect((_) => handleDisconnection());
    //
    // // Handle incoming responses
    // socket.on('output', (response) => handleIncomingResponse(response));
    CognigyApiResponse response = await apiProvider.login(input);
    log('Login Response: ${response.text}');
    // Handle the response here
    if (response.text != null) {
      // Process the response text
      handleConnection(response);
    } else {
      // Handle empty response
    }
    log('Socket connection initialized.');
    // } catch (e) {
    //   log('Error initializing socket connection: $e');
    // }
  }

// Handle successful socket connection
  void handleConnection(CognigyApiResponse response) {
    log('Socket connected with user ID: $userId, session ID: $sessionId');

    handleIncomingResponse(response);
  }

// Handle socket disconnection
  void handleDisconnection() {
    log('Socket disconnected.');

    try {
      socket.io.disconnect();
      socket.clearListeners();
    } catch (e) {
      log('Error during disconnection: $e');
    }
  }

// Emit 'processInput' event
//   void emitProcessInput() async {
//     log('Preparing to send processInput event...');
//
//   //  await Future.delayed(const Duration(seconds: 2));
//
//     // final eventData = {
//     //   'URLToken': urlToken,
//     //   'text': 'vaibhavgour',
//     //   'userId': userId,
//     //   'sessionId': sessionId,
//     //   'channel': 'flutter',
//     //   'source': 'device',
//     //   "passthroughIP": "127.0.0.1",
//     //   "resetFlow": "true",
//     //   'data': {
//     //     'Patient': patient,
//     //     'Medicine': medicine,
//     //     'Condition': condition,
//     //   },
//     // };
//
//     try {
//       if (socket.connected) {
//         log('Sending processInput event...');
//         socket.emit('processInput', eventData);
//         log('processInput event sent.');
//       } else {
//         log('Socket is not connected. Buffering event...');
//         // Add to a buffer or handle reconnection logic
//       }
//     } catch (error, stackTrace) {
//       log('Error sending processInput event: $error');
//       log(stackTrace.toString());
//     }
//   }

// Handle incoming responses
  void handleIncomingResponse(CognigyApiResponse response) {
    log('Received output response: ${response.toString()}');
    log('Received output response: ${response.data.toString()}');
    // log('Received output response: ${response.data!.cognigy!.cognigyDefault!.quickReplies!.text.toString()}');

    setState(() => handleIncomingMessage(response));
    // Update the state with the incoming message
  }

  void handleIncomingMessage(CognigyApiResponse cognigyApiResponse) {
    // Process the initial message (text)
    '--->${cognigyApiResponse.data!.type}'.logD;
    '--->${chatWidgets.length}'.logD;

    ChatMessage? initialMessage = ChatMessage(
      type: cognigyApiResponse.data!.type??'text',
      text: cognigyApiResponse.text,
      data: null,
      sender: 'bot',
    );
if(chatWidgets.isEmpty) {
 Widget  initialWidget = Padding(
    padding: const EdgeInsets.all(4.0),
    child: CustomCardTile(
      text: initialMessage.text ?? 'vaibhav',
      textStyle: textSemiBold.copyWith(
        color: AppColor.black,
        fontSize: AppSize.sp16,
      ),
    ),
  );


  setState(() {
    chatWidgets.add(initialWidget);
    _scrollToBottom();
  });
}
    // Process the quick reply message
    ChatMessage? cognigyMessage = processCognigyMessage(cognigyApiResponse);

    if (cognigyMessage != null) {
      Widget widget;
      cognigyMessage.type.logD;
      if (cognigyMessage.type == 'text') {
        widget = Padding(
          padding: const EdgeInsets.all(4.0),
          child: CustomCardTile(
            text: cognigyMessage.text ?? 'vaibhav',
            textStyle: textSemiBold.copyWith(
              color: AppColor.black,
              fontSize: AppSize.sp16,
            ),
          ),
        );
      } else if (cognigyMessage.type == 'quick_replies') {
        String selectedChoice = "";
        widget = Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 5.0,
            color: Colors.white,
            margin: EdgeInsets.only(
              right: AppSize.w86,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    cognigyMessage.text.toString(),
                    style: textSemiBold.copyWith(
                      color: Colors.black,
                      fontSize: AppSize.sp16,
                    ),
                  ),
                  Wrap(
                    spacing: 0.0,
                    runSpacing: 0.0,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    children: [
                      if (cognigyMessage.data is List) ...[

                        for (var item in cognigyMessage.data)

                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: ChoiceChip(
                              label: Text(
                                item.title,
                                style: textSemiBold.copyWith(
                                  color: Colors.white,
                                  fontSize: AppSize.sp16,
                                ),
                              ),
                              selectedColor: Colors.black,
                              backgroundColor: AppColor.chatBlueBgColor,
                              selected: selectedChoice == item.title,
                              onSelected: (selected) {
                                setState(() {
                                  selectedChoice = item.title;
                                  textEditingController.text = selectedChoice;
                                  sendMessage();
                                });
                              },
                            ),
                          ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      } else {
        widget = Text(
          'Failed to insert',
          style: textSemiBold.copyWith(
            color: AppColor.black,
            fontSize: AppSize.sp16,
          ),
          maxLines: 6,
          overflow: TextOverflow.ellipsis,
        );
      }

      setState(() {
        chatWidgets.add(widget);
        _scrollToBottom();
      });
    }
  }

  Future<void> sendMessage() async {
    textEditingController.text.logD;
    String message = textEditingController.text.trim();
    "Send message".logD;
    final Map<String, dynamic> input = {
      // Add your input data here
      'userId': userId,
      'sessionId': sessionId,
      "projectName": "VIVIENTH 2.0",
      'text': textEditingController.text,
      "data": {
      }
      // ...
    };
    //  try {
    // Create socket connection with the specified endpoint and options
    // socket = IO.io(socketUrl, <String, dynamic>{
    //   'transports': ['websocket'],
    //   'autoConnect': false,
    //   'query': {
    //    'sessionId': Uri.encodeComponent(sessionId),
    //     'urlToken': Uri.encodeComponent(urlToken),
    //     'userId': Uri.encodeComponent(userId),
    //     'testMode': 'true',
    //     'emitWithAck': 'true' ,
    //   },
    //   'options':{
    //     'reconnectionLimit': 5,
    //   }
    // });
    // socket.connect();
    //
    // // Handle socket connection
    // socket.onConnect((_) => handleConnection());
    //
    // // Handle socket disconnection
    // socket.onDisconnect((_) => handleDisconnection());
    //
    // // Handle incoming responses
    // socket.on('output', (response) => handleIncomingResponse(response));
    CognigyApiResponse response = await apiProvider.login(input);
    log('Login Response: ${response.text}');

    // Handle the response here
    if (response.text != null) {
      // Process the response text
      setState(() {
        chatWidgets.add(
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 5.0, // Adjust the elevation as needed
              color: Colors.white,

              margin: EdgeInsets.only(
                left: AppSize.w180,
              ),
              child: Container(
                padding: const EdgeInsets.all(8.0),
                constraints: BoxConstraints(
                  minHeight: AppSize.h40,
                ),
                alignment: Alignment.centerRight,
                child: Text(
                  message,
                  style: textSemiBold.copyWith(
                      color: AppColor.black, fontSize: AppSize.sp16),
                  maxLines: 6,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        );
      });
     // connectSocket();
      handleIncomingResponse(response);
      textEditingController.clear();
    } else {
      // Handle empty response
    }
    log('Socket connection initialized.');
    // if (message.isNotEmpty) {
    //   socket.emit('processInput', {
    //     'URLToken': urlToken,
    //     'text': message,
    //     'userId': userId,
    //     'sessionId': sessionId,
    //     'channel': 'flutter',
    //     'source': 'device',
    //   });
    //   setState(() {
    //     chatWidgets.add(
    //       Padding(
    //         padding: const EdgeInsets.all(8.0),
    //         child: Card(
    //           elevation: 5.0, // Adjust the elevation as needed
    //           color: Colors.white,
    //
    //           margin: EdgeInsets.only(
    //             left: AppSize.w180,
    //           ),
    //           child: Container(
    //             padding: const EdgeInsets.all(8.0),
    //             constraints: BoxConstraints(
    //               minHeight: AppSize.h40,
    //             ),
    //             alignment: Alignment.centerRight,
    //             child: Text(
    //               message,
    //               style: textSemiBold.copyWith(
    //                   color: AppColor.black, fontSize: AppSize.sp16),
    //               maxLines: 6,
    //               overflow: TextOverflow.ellipsis,
    //             ),
    //           ),
    //         ),
    //       ),
    //     );
    //   });
    //
    //   textEditingController.clear();
    // }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (controller.hasClients) {
        controller.animateTo(
          controller.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

// final ProfileController _controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      key: _homeController.drawerKey,
      backgroundColor: const Color(0XFFF5F5F5),
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
              context.go('/UserProfileHomeScreen');
            }),
        centerTitle: false,
        actions: [
          IconButton(
              onPressed: () {
                context.go('/PatientProfileScreen');
              },
              icon: const Icon(
                Icons.person,
                color: AppColor.black,
              ))
        ],
      ),
      // drawer: AppDrawerView(),
      body: view
          ? Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: controller,
                    itemCount: chatWidgets.length,
                    itemBuilder: (context, index) {
                      return chatWidgets[index];
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Material(
                    elevation: 4.0,
                    borderRadius: BorderRadius.circular(25.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColor.white,
                        borderRadius: BorderRadius.circular(25.0),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 0.3,
                            spreadRadius: 0.3,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: TextFormField(
                                controller: textEditingController,
                                textInputAction: TextInputAction.send,
                                onTap: () {},
                                decoration: const InputDecoration(
                                  hintText: 'Enter your message',
                                  hintStyle: TextStyle(color: AppColor.black),
                                  border: InputBorder.none,
                                ),
                                style:
                                    textRegular.copyWith(color: AppColor.black),
                                onSaved: (value) {
                                  final String a =
                                      textEditingController.text.trim();
                                  if (a.isNotEmpty) {
                                    //    sendMessage();
                                  }
                                },
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          InkWell(
                            child: Icon(
                              Icons.send,
                              color: AppColor.black.withOpacity(0.6),
                              size: 18,
                            ),
                             onTap: () => sendMessage(),
                          ),
                          const SizedBox(width: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          : Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Assets.images.svgs.makaiLogo.svg(
                      height: context.height * 0.20,
                      width: context.height * 0.20,
                    ),
                    Text(
                      'MAKAI',
                      style: textSemiBold.copyWith(
                          color: AppColor.black, fontSize: AppSize.sp32),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        String mobileNumber =
                            await SharedPref.getStringPreference(
                                SharedPref.MOBILE);
                        retrieveData(mobileNumber, 'usersProfile')
                            .then((value) async {
                          if (value == null || value.isEmpty) {
                            Utility.showToast(
                                msg: 'Please Fill Profile Information First');
                            return;
                          }
                          value['PatientId']=mobileNumber;
                          patient = value;
                          retrieveData(mobileNumber, 'medicine')
                              .then((value) async {
                            if (value == null || value.isEmpty) {
                              Utility.showToast(
                                  msg:
                                      'Please Fill Medicine Name Dosage From Profile Tab');
                              return;
                            }
                            medicine = value;
                            retrieveData(mobileNumber, 'medicalCondition')
                                .then((value) {
                              if (value == null || value.isEmpty) {
                                Utility.showToast(
                                    msg:
                                        'Please Fill Medication From Profile Tab');
                                return;
                              }
                              condition = value;
                              setState(() {
                                view = true;
                                if (view) connectSocket();
                                // if (view) loginAsVisitor(context);
                              });
                            });
                          });
                        });
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed)) {
                              return AppColor.textBlueColor;
                            }
                            return AppColor.textBlueColor;
                          },
                        ),
                      ),
                      child: const Text(
                        'Start Assessment',
                        style: TextStyle(color: AppColor.white),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
    );
  }
}
