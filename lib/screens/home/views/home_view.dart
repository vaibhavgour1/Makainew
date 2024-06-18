import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:makaihealth/api/retriveData.dart';
import 'package:makaihealth/gen/assets.gen.dart';
import 'package:makaihealth/utility/config.dart';
import 'package:makaihealth/utility/dimension.dart';
import 'package:makaihealth/utility/logger.dart';
import 'package:makaihealth/utility/message_helper.dart';
import 'package:makaihealth/utility/sharedpref.dart';
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
  ScrollController controller = ScrollController();
  List<String> messages = [];
  List<Widget> chatWidgets = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // connectSocket();



  }




  void connectSocket() {
    log('Initializing socket connection...');

    try {
      // Create socket connection with the specified endpoint and options
      socket = IO.io(socketUrl, <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
        'query': {
          'sessionId': Uri.encodeComponent(sessionId),
          'urlToken': Uri.encodeComponent(urlToken),
          'userId': Uri.encodeComponent(userId),
          'testMode': 'true',
          'emitWithAck': 'true' ,
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

      widget = Padding(
        padding: const EdgeInsets.all(4.0),
        child: CustomCardTile(
          text: message.data['text'],
          textStyle: textSemiBold.copyWith(
              color: AppColor.black, fontSize: AppSize.sp16),
        ),
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
            child: Column(
              children: [
                Text(
                  cognigyMessage.text.toString(),
                  style: textSemiBold.copyWith(
                    color: Colors.black, // Text color for selected chips
                    fontSize: AppSize.sp16,
                  ),
                ),
                Wrap(
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
      _scrollToBottom();
    });
  }

  void sendMessage() {
    textEditingController.text.logD;
    String message = textEditingController.text.trim();
    if (message.isNotEmpty) {
      socket.emit('processInput', {
        'URLToken':
        urlToken,
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

              margin: EdgeInsets.only(left: AppSize.w180,),
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
            padding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: TextFormField(
                          controller: textEditingController,
                          textInputAction: TextInputAction.send,
                          onTap: () {},
                          decoration: const InputDecoration(
                            hintText: 'Enter your message',
                            hintStyle: TextStyle(color: AppColor.black),
                            border: InputBorder.none,
                          ),
                          style: textRegular.copyWith(color: AppColor.black),
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
