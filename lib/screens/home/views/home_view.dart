import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:makaihealth/api/retriveData.dart';
import 'package:makaihealth/gen/assets.gen.dart';
import 'package:makaihealth/utility/dimension.dart';
import 'package:makaihealth/utility/logger.dart';
import 'package:makaihealth/utility/message_helper.dart';
import 'package:makaihealth/utility/sharedpref.dart';
import 'package:makaihealth/utility/socket.io.dart';
import 'package:makaihealth/utility/text_styles.dart';
import 'package:makaihealth/utility/utility.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
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

  // final ChatController chatController = Get.put(ChatController());
  late IO.Socket socket;
  final sessionId = const Uuid().v1();
  bool view = false;
  Map<String, dynamic> patient = {}, medicine = {}, condition = {};

  // time-based
  final userId = const Uuid().v4();
  ScrollController _controller = ScrollController();
  List<String> messages = [];
  List<Widget> chatWidgets = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // connectSocket();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.animateTo(
        0.0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeIn,
      );
    });
  }

  // connectSocket() {
  //   //https://endpoint-trial.cognigy.ai/82983e3827da918787dcdb49d403f4d224c25f69bb348ce7921e3a80a72c07bd
  //   //https://endpoint-trial.cognigy.ai/0515c90aa09e21c46a4b577864b8f68d7a58236c340efb41a40b18a1e9747fb8
  //   //https://endpoint-trial.cognigy.ai/bafebec090f608f17d1a8878cae34bf5d09099df639919002ee75de038c64f57
  //
  //   log('Connected--->S');
  //   socket = IO.io('https://endpoint-trial.cognigy.ai/', <String, dynamic>{
  //     'transports': ['websocket'],
  //     //   'autoConnect': false,
  //     'extraHeaders': {
  //       'URLToken':
  //           'bafebec090f608f17d1a8878cae34bf5d09099df639919002ee75de038c64f57',
  //
  //     }
  //   });
  //   socket.connect();
  //
  //   // Subscribe to events
  //   socket.onConnect((_) {
  //     log('Connected socket==>$userId');
  //     log('Connected socket==>$sessionId');
  //     socket.emit('processInput', {
  //       'URLToken':
  //           'bafebec090f608f17d1a8878cae34bf5d09099df639919002ee75de038c64f57',
  //       'text': "vaibhav",
  //       'userId': userId,
  //       'sessionId': sessionId,
  //       'channel': 'flutter',
  //       'source': 'device',
  //       "data": {
  //         "Patient": patient,
  //         "Medicine": medicine,
  //         "Condition": condition,
  //       },
  //     });
  //     log('Connected socket');
  //   });
  //
  //   log("${socket.id}");
  //   socket.onDisconnect((_) {
  //     try {
  //       socket.connected = false;
  //       socket.io.disconnect();
  //       log("On disconnect: Disconnected");
  //
  //       socket.on("disconnect", (data) {
  //         log("On disconnect: $data");
  //       });
  //       socket.clearListeners();
  //     } catch (e, st) {
  //       log('SocketConnection Error: $e && st: $st');
  //     }
  //
  //   });
  //
  //   socket.on('output', (response) {
  //     log('output response : ${response.toString()}');
  //     setState(() {
  //       // messages.add(response['data']['text'].toString());
  //       handleIncomingMessage(response);
  //     });
  //   });
  //   // SocketService().connect();
  //   // SocketService().sendMessage("text", "data");
  // }

// Define constants for URL token and API endpoint
   String urlToken = 'bafebec090f608f17d1a8878cae34bf5d09099df639919002ee75de038c64f57';
   String apiEndpoint = 'https://endpoint-trial.cognigy.ai/';

  void connectSocket() {
    log('Initializing socket connection...');

    try {
      // Create socket connection with the specified endpoint and options
      socket = IO.io(apiEndpoint, <String, dynamic>{
        'transports': ['websocket'],
        'extraHeaders': {
          'URLToken': urlToken,
        },
      });
      socket.connect();

      // Handle socket connection
      socket.onConnect((_) => handleConnection());

      // Handle socket disconnection
      socket.onDisconnect((_) => handleDisconnection());

      // Handle incoming responses
      socket.on('output', (response) => handleIncomingResponse(response));

      log('Socket connection initialized.');
    } catch (e) {
      log('Error initializing socket connection: $e');
    }
  }

// Handle successful socket connection
  void handleConnection() {
    log('Socket connected with user ID: $userId, session ID: $sessionId');

    emitProcessInput();
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
  void emitProcessInput() {
    log('Sending processInput event...');

    socket.emit('processInput', {
      'URLToken': urlToken,
      'text': 'vaibhav',
      'userId': userId,
      'sessionId': sessionId,
      'channel': 'flutter',
      'source': 'device',
      'data': {
        'Patient': patient,
        'Medicine': medicine,
        'Condition': condition,
      },
    });

    log('processInput event sent.');
  }

// Handle incoming responses
  void handleIncomingResponse(response) {
    log('Received output response: ${response.toString()}');

    // Update the state with the incoming message
    setState(() => handleIncomingMessage(response));
  }
  void handleIncomingMessage(dynamic data) {
    // Parse the incoming data into a ChatMessage object
    'message.type=>}'.logD;
    ChatMessage? cognigyMessage = processCognigyMessage(data);
    (cognigyMessage).logD;

    ("===>${cognigyMessage!.type}").logD;
    // ("===>${cognigyMessage.data}").logD;
    ChatMessage message = ChatMessage(
      type: data['type'] ?? 'vaibhav',
      text: data['text'] ?? 'vaibhav',
      data: data['data'] ?? '',
      sender: data['sender'] ?? 'bot',
    );

    // Handle the different types of messages

    Widget widget;
    if (cognigyMessage.type == 'text') {
      // If the message type is text, create a Text widget

      widget = CustomCardTile(
        text: message.data['text'],
        textStyle: textSemiBold.copyWith(
            color: AppColor.black, fontSize: AppSize.sp16),
      );
    } else if (cognigyMessage.type == 'quick_replies') {
      // If the message type is quick replies, create buttons
      "======?${cognigyMessage.data}".logD;
      "======?${cognigyMessage.data[0]['title']}".logD;
      List<String> choices = [];
      String selectedChoice = "";
      widget = Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 5.0, // Adjust the elevation as needed
          color: Colors.white,
          margin: EdgeInsets.only(right: AppSize.w86,),

          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              spacing: 0.0, // Space between children
              runSpacing: 0.0, // Space between lines
              crossAxisAlignment: WrapCrossAlignment.start,
              //alignment: WrapAlignment.spaceAround,
              children: [
                // Check if cognigyMessage.data is a List and not null
                if (cognigyMessage.data is List) ...[
                  for (var item in cognigyMessage.data)
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: ChoiceChip(
                        label: Text(
                          item['title'],
                          style: textSemiBold.copyWith(
                            color: Colors.white, // Text color for selected chips
                            fontSize: AppSize.sp16,
                          ),
                        ),
                        selectedColor: Colors.black, // Selected chip color
                        backgroundColor: AppColor.chatBlueBgColor, // Unselected chip color
                        selected: selectedChoice == item['title'],
                        onSelected: (selected) {
                          setState(() {
                            selectedChoice = item['title'];
                            // Update textEditingController text when selected
                            textEditingController.text = selectedChoice;
                          });
                        },
                      ),
                    ),
                ],
              ],
            ),
          ),
        ),
      );

      // Row(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //   children: List<Widget>.generate(
      //     (cognigyMessage.data)
      //         .length,
      //     (index) => ElevatedButton(
      //       onPressed: () {
      //         // Handle button press
      //
      //       },
      //       child: Text((cognigyMessage.data[index]['title'].toString()),
      //     ),
      //   ),
      // ),),
      // );
    } else {
      "widget".logD;
      //(message.data['data']['type']).logD;
      // If the message type is unknown, use an empty widget
      widget = Text(
        'Failed to insert',
        style: textSemiBold.copyWith(
            color: AppColor.black, fontSize: AppSize.sp16),
        maxLines: 6,
        overflow: TextOverflow.ellipsis,
      );
    }

    // Add the widget to the chatWidgets list

    setState(() {
      chatWidgets.add(widget);
    });
  }

  void sendMessage() {
    textEditingController.text.logD;
    String message = textEditingController.text.trim();
    if (message.isNotEmpty) {
      socket.emit('processInput', {
        'URLToken':
            'bafebec090f608f17d1a8878cae34bf5d09099df639919002ee75de038c64f57',
        'text': message,
        'userId': userId,
        'sessionId': sessionId,
        'channel': 'flutter',
        'source': 'device',
      });
      setState(() {
        chatWidgets.add(
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 5.0, // Adjust the elevation as needed
              color: Colors.white,

              margin: EdgeInsets.only(left: AppSize.w140,),
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

      textEditingController.clear();
    }
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
      body: SingleChildScrollView(
        controller: _controller,
        child: SizedBox(
          width: context.width,
          height: context.height * 0.90,
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              view
                  ? Expanded(
                      child: ListView.builder(
                        itemCount: chatWidgets.length,
                        itemBuilder: (context, index) {
                          return chatWidgets[index];
                        },
                      ),
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
                                  width: context.height * 0.20),
                              Text(
                                'MAKAI',
                                style: textSemiBold.copyWith(
                                    color: AppColor.black,
                                    fontSize: AppSize.sp32),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ]),
                      ),
                    ),

              // Add some space between logo and button
              // Button for starting assessment
              view
                  ? const SizedBox()
                  : ElevatedButton(
                      onPressed: () async {
                        // Add logic to start assessment
                        String mobileNumber = await SharedPref.getStringPreference(SharedPref.MOBILE);

                        retrieveData(mobileNumber, 'usersProfile').then((value) async {
                          // Check if value is null or empty
                          if (value == null || value.isEmpty) {
                            Utility.showToast(msg: 'Please Fill Profile Information First');
                            return;
                          }

                          patient = value;

                          retrieveData(mobileNumber, 'medicine').then((value) async {
                            // Check if value is empty
                            if (value == null || value.isEmpty) {
                              Utility.showToast(msg: 'Please Fill Medicine Name Dosage From Profile Tab');
                              return;
                            }

                            medicine = value;

                            retrieveData(mobileNumber, 'medicalCondition').then((value) {
                              // Check if value is empty
                              if (value == null || value.isEmpty) {
                                Utility.showToast(msg: 'Please Fill Medication From Profile Tab');
                                return;
                              }

                              condition = value;

                              // If all the data is retrieved successfully, set view to true and connect the socket
                              view = true;
                              setState(() {
                                if (view) {
                                  connectSocket();
                                }
                              });
                            });
                          });
                        });
                        SocketService.createSocketConnection();
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                            // Here, you can define the color based on different states
                            if (states.contains(MaterialState.pressed)) {
                              // Color when button is pressed
                              return AppColor.textBlueColor;
                            }
                            // Default color
                            return AppColor.textBlueColor;
                          },
                        ),
                      ),
                      child: const Text(
                        'Start Assessment',
                        style: TextStyle(color: AppColor.white),
                      ),
                    ),
              view
                  ? const SizedBox(height: 0)
                  : const Expanded(child: SizedBox(height: 20)),
              // Add some space between button and text form
              // Text form at the bottom
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Material(
                  elevation: 4.0, // Set the elevation for shadow
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
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15),
                            child: TextFormField(
                              controller: textEditingController,
                              textInputAction: TextInputAction.send,
                              onTap: () {},
                              decoration: const InputDecoration(
                                hintText: 'Enter your message',
                                hintStyle:
                                TextStyle(color: AppColor.black),
                                border: InputBorder.none,
                              ),
                              style: textRegular.copyWith(
                                  color: AppColor.black),
                              onSaved: (value) {
                                final String a =
                                textEditingController.text.trim();
                                if (a.isNotEmpty ||
                                    a != '' ||
                                    a.isNotEmpty) {
                                  //    sendMessage();
                                }
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        InkWell(
                          child: Icon(
                            Icons.send,
                            color: AppColor.black.withOpacity(0.6),
                            size: 18,
                          ),
                          onTap: () => sendMessage(),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
