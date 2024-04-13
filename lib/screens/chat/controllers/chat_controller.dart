/*import 'dart:developer';

import 'package:MAKAI/app/Utils/AppColor/app_color.dart';
import 'package:MAKAI/app/Utils/Socket/socket.dart';
import 'package:MAKAI/app/Utils/message_helper.dart';
import 'package:MAKAI/app/data/chat_model.dart';
import 'package:MAKAI/app/modules/sign_up/service/api_res_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  late ScrollController scrollController;
  TextEditingController messageController = TextEditingController();
  RxBool isConnectMessage = true.obs;
  RxBool isDialog = false.obs;
  RxString isRejected = ''.obs;
  RxList<ChatMessage> messageList = <ChatMessage>[].obs;

  RxList<Widget> messageWidgetList = <Widget>[].obs;
  RxList<int> botOrUser = <int>[].obs;

  Future<void> sendMessage() async {
    if (messageController.text.isNotEmpty) {
      SocketService.sendMessage(text: messageController.text);
      // messageList.add(ChatMessage(sender: 'user', text: messageController.text, type: 'text'));
      botOrUser.add(1);
      addMessageToChat(ChatMessage(type: 'text', text: messageController.text, data: null, sender: 'user'));
      // messageWidgetList.add(ChatMessage(sender: 'user', text: messageController.text, type: 'text'));
      messageController.clear();
    }
  }

  Future<void> userProfile() async {
    try {
      var data = await AuthsService.userProfile();
      log("userProfile response 00: ${data}");
    } catch (e, st) {
      log("userProfile Error Message: $e : $st");
    }
  }

  @override
  void onInit() {
    super.onInit();

    scrollController = ScrollController()
      ..addListener(() {
        if (scrollController.position.maxScrollExtent == scrollController.position.pixels) {
          // load more
        }
      });

    SocketService.socket?.on('output', (response) {
      log('output response : ${response.toString()}');
      ChatMessage? cognigyMessage = processCognigyMessage(response);

      // String message = response['data']['text'];
      // messageList
      //     .add(ChatModel(isReceived: true, message: message, time: DateTime
      //     .now()
      //     .millisecondsSinceEpoch
      //     .toString()));

      if (cognigyMessage != null) {
        cognigyMessage.sender = 'bot';
        if (cognigyMessage.text != '=>') {
          botOrUser.add(0);
          addMessageToChat(cognigyMessage);
        }
      }
    });
  }

  @override
  void onClose() {
    super.onClose();
    scrollController.removeListener(() {
      // load more
    });
  }

  Widget textMessage(String sender, String text) {
    if (text == null) return Container();

    return GestureDetector(
      onTap: () => sender == 'user' ? messageController.text = text : null,
      child: Container(
        alignment: sender == 'bot' ? Alignment.centerLeft : Alignment.centerRight,
        child: Container(
            padding: const EdgeInsets.all(10.0),
            margin: const EdgeInsets.only(top: 5, bottom: 5.0, left: 10.0, right: 10.0),
            decoration: BoxDecoration(
              // color: sender == 'bot' ? Theme.of(Get.context!).primaryColor : Theme.of(Get.context!).accentColor,
              border: null,
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Html(
              data: text,
              // defaultTextStyle: TextStyle(
              //     color: sender == 'bot' ? Theme.of(Get.context!).textTheme.bodyText2?.color : Colors.grey[900],
              //     fontSize: Theme.of(Get.context!).textTheme.bodyText2?.fontSize),
              // shrinkToFit: true,
              // linkStyle: TextStyle(
              //     color: Theme.of(Get.context!).textTheme.bodyText2?.color,
              //     decorationColor: Theme.of(Get.context!).textTheme.bodyText2?.color,
              //     decoration: TextDecoration.underline,
              //     fontWeight: FontWeight.w600),
              // onLinkTap: (url?) {
              //   launch(url);
              // },
            )),
      ),
    );
  }

  Widget quickRepliesMessage(
    quickReplies,
    String text,
  ) {
    List<Widget> quickReplyWidgets = <Widget>[];
    // build quick replies
    for (var qr in quickReplies) {
      quickReplyWidgets.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          // shape: new RoundedRectangleBorder(
          //     borderRadius: new BorderRadius.circular(30.0)),
          // padding: EdgeInsets.all(10.0),
          child: Text(qr['title']),
          onPressed: () {
            SocketService.sendMessage(text: qr['payload']);
            botOrUser.add(1);
            addMessageToChat(ChatMessage(type: 'text', text: qr['title'], data: null, sender: 'user'));
          },
        ),
      ));
    }
    return Container(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              padding: const EdgeInsets.all(20.0),
              margin: const EdgeInsets.only(top: 10, bottom: 10.0, left: 20.0, right: 20.0),
              decoration: BoxDecoration(
                // color: Theme.of(Get.context!).primaryColor,
                border: null,
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Html(
                data: text,
                // defaultTextStyle: Theme.of(Get.context!).textTheme.bodyText2,
                // shrinkToFit: true,
                // linkStyle: TextStyle(
                //     color: Theme.of(Get.context!).textTheme.bodyText2?.color,
                //     decorationColor: Theme.of(Get.context!).textTheme.bodyText2?.color,
                //     decoration: TextDecoration.underline,
                //     fontWeight: FontWeight.w600),
                // onLinkTap: (url) {
                //   launch(url);
                // },
              )),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Wrap(children: quickReplyWidgets),
          )
        ],
      ),
    );
  }

  Widget choiceSet(
    quickReplies,
    String text,
  ) {
    List<Widget> quickReplyWidgets = <Widget>[];
    // build quick replies
    // for (var qr in quickReplies) {
    //   quickReplyWidgets.add(Padding(
    //     padding: const EdgeInsets.all(8.0),
    //     child: ElevatedButton(
    //       // shape: new RoundedRectangleBorder(
    //       //     borderRadius: new BorderRadius.circular(30.0)),
    //       // padding: EdgeInsets.all(10.0),
    //       child: Text(qr['title']),
    //       onPressed: () {
    //         SocketService.sendMessage(text: qr['value']);
    //         addMessageToChat(ChatMessage(type: 'text', text: qr['title'], data: null, sender: 'user'));
    //       },
    //     ),
    //   ));
    // }
    RxList<int> isSelected = <int>[].obs;
    return Container(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              padding: const EdgeInsets.all(20.0),
              margin: const EdgeInsets.only(top: 10, bottom: 10.0, left: 20.0, right: 20.0),
              decoration: BoxDecoration(
                // color: Theme.of(Get.context!).primaryColor,
                border: null,
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Html(
                data: text,
                // defaultTextStyle: Theme.of(Get.context!).textTheme.bodyText2,
                // shrinkToFit: true,
                // linkStyle: TextStyle(
                //     color: Theme.of(Get.context!).textTheme.bodyText2?.color,
                //     decorationColor: Theme.of(Get.context!).textTheme.bodyText2?.color,
                //     decoration: TextDecoration.underline,
                //     fontWeight: FontWeight.w600),
                // onLinkTap: (url) {
                //   launch(url);
                // },
              )),
          Wrap(
            children: [
              for (int index = 0; index < quickReplies.length; index++)
                GestureDetector(
                  onTap: () {
                    if (isSelected.contains(index)) {
                      isSelected.remove(index);
                    } else {
                      isSelected.add(index);
                    }
                  },
                  child: Obx(
                    () => Container(
                        color: isSelected.contains(index) ? Colors.blue : Colors.grey.withOpacity(0.5),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        child: Text(quickReplies[index]['title'])),
                  ),
                ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            // shape: new RoundedRectangleBorder(
            //     borderRadius: new BorderRadius.circular(30.0)),
            // padding: EdgeInsets.all(10.0),
            child: const Text('Send'),
            onPressed: () {
              SocketService.sendMessage(
                  text: isSelected.map((element) => quickReplies[element]['title'].toString()).toList().toString());
              // addMessageToChat(ChatMessage(type: 'text', text: qr['title'], data: null, sender: 'user'));
            },
          ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 10.0),
          //   child: Wrap(children: quickReplyWidgets),
          // )
        ],
      ),
    );
  }

  Widget imageMessage(String url) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Container(
          margin: const EdgeInsets.only(top: 10, bottom: 10.0, left: 20.0, right: 50.0),
          child: ClipRRect(
            child: Image.network(url),
            borderRadius: BorderRadius.circular(10.0),
          )),
    );
  }

  Widget galleryMessage(
    List elements,
  ) {
    return Container(
        alignment: Alignment.centerLeft,
        margin: const EdgeInsets.symmetric(vertical: 20.0),
        height: 330,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: elements.length,
            itemBuilder: (BuildContext context, int itemIndex) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                width: MediaQuery.of(Get.context!).size.width,
                child: Card(
                    // color: MediaQuery.of(Get.context!).platformBrightness == Brightness.dark
                    //     ? Theme.of(Get.context!).primaryColor
                    //     : Colors.white,
                    child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 250.0,
                      child: Stack(
                        children: <Widget>[
                          Positioned.fill(
                              child: Container(
                            color: Colors.black,
                            child: Opacity(
                              opacity: 0.5,
                              child: Image.network(elements[itemIndex]['image_url'], fit: BoxFit.cover),
                            ),
                          )),
                          Positioned(
                            bottom: 0.0,
                            left: 16.0,
                            right: 16.0,
                            child: FittedBox(
                                fit: BoxFit.scaleDown,
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      elements[itemIndex]['title'],
                                      style: Theme.of(Get.context!).textTheme.headline6,
                                    ),
                                    Text(
                                      elements[itemIndex]['subtitle'],
                                      style: Theme.of(Get.context!).textTheme.subtitle2,
                                    )
                                  ],
                                )),
                          )
                        ],
                      ),
                    ),
                    ButtonBarTheme(
                      data: const ButtonBarThemeData(),
                      child: ButtonBar(
                        buttonPadding: const EdgeInsets.symmetric(horizontal: 10),
                        alignment: MainAxisAlignment.end,
                        children: <Widget>[
                          if (elements[itemIndex]['buttons'] != null)
                            for (var b in elements[itemIndex]['buttons'])
                              ElevatedButton(
                                child: Text(
                                  b['title'].toUpperCase(),
                                  style: const TextStyle(color: Colors.black),
                                ),
                                onPressed: () {
                                  switch (b['type']) {
                                    case 'postback':
                                      SocketService.sendMessage(text: b['payload']);
                                      botOrUser.add(1);

                                      addMessageToChat(
                                          ChatMessage(type: 'text', text: b['title'], data: null, sender: 'user'));

                                      break;
                                    case 'web_url':
                                      LaunchUrl(b['url']);
                                  }

                                  //Scrolldown the list to show the latest message
                                  // scrollController.animateTo(
                                  //   scrollController.position.maxScrollExtent,
                                  //   duration: Duration(milliseconds: 600),
                                  //   curve: Curves.ease,
                                  // );
                                },
                              )
                        ],
                      ),
                    )
                  ],
                )),
              );
            }));
  }

  Widget buttonsMessage(
    String buttonText,
    List buttons,
  ) {
    List<Widget> buttonWidgets = <Widget>[];
    // build buttons
    for (var b in buttons) {
      buttonWidgets.add(
        ElevatedButton(
          // padding: EdgeInsets.all(10.0),
          child: Text(
            b['title'],
            style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.blue),
          ),
          onPressed: () {
            switch (b['type']) {
              case 'postback':
                SocketService.sendMessage(text: b['payload']);
                botOrUser.add(1);

                addMessageToChat(
                  ChatMessage(type: 'text', text: b['title'], data: null, sender: 'user'),
                );

                break;
              case 'web_url':
                LaunchUrl(b['url']);
                break;
            }
          },
        ),
      );
    }

    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(top: 10, bottom: 10.0, left: 20.0, right: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              // color: Theme.of(Get.context!).primaryColor,
              border: null,
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            ),
            child: Html(
              data: buttonText,
              // defaultTextStyle: Theme.of(Get.context!).textTheme.bodyText2,
              // shrinkToFit: true,
              // linkStyle: TextStyle(
              //     color: Theme.of(Get.context!).textTheme.bodyText2?.color,
              //     decorationColor: Theme.of(Get.context!).textTheme.bodyText2?.color,
              //     decoration: TextDecoration.underline,
              //     fontWeight: FontWeight.w600)
            ),
          ),
          Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: buttonWidgets),
        ],
      ),
    );
  }

  Widget listMessage(
    dynamic data,
  ) {
    List items = data['listItems'];
    List buttons = data['listButtons'];

    List<Widget> listWidgets = <Widget>[];

    for (var item in items) {
      listWidgets.add(Card(
          // color: MediaQuery.of(Get.context!).platformBrightness == Brightness.dark
          //     ? Theme.of(Get.context!).primaryColor
          //     : Colors.white,
          child: Column(
        children: <Widget>[
          SizedBox(
            height: 250.0,
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                    child: Container(
                  color: Colors.black,
                  child: Opacity(
                    opacity: item['image_url'].toString().isNotEmpty ? 0.5 : 1,
                    child: item['image_url'].toString().isNotEmpty
                        ? Image.network(item['image_url'], fit: BoxFit.cover)
                        : Container(
                            // color: MediaQuery.of(Get.context!).platformBrightness == Brightness.dark
                            //     ? Theme.of(Get.context!).primaryColor
                            //     : Colors.white,
                            ),
                  ),
                )),
                Positioned(
                  bottom: 16.0,
                  left: 16.0,
                  right: 16.0,
                  child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.bottomLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            item['title'],
                            style: TextStyle(
                                color: item['image_url'].toString().isNotEmpty ? Colors.white : Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 20),
                          ),
                          Text(
                            item['subtitle'],
                            style: TextStyle(
                                color: item['image_url'].toString().isNotEmpty ? Colors.white : Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 15),
                          )
                        ],
                      )),
                )
              ],
            ),
          ),
          ButtonBarTheme(
            data: const ButtonBarThemeData(),
            child: ButtonBar(
              buttonPadding: const EdgeInsets.symmetric(horizontal: 10),
              alignment: MainAxisAlignment.end,
              children: <Widget>[
                if (item['buttons'] != null)
                  for (var b in item['buttons'])
                    if (b['type'] != 'element_share')
                      ElevatedButton(
                        child: Text(
                          b['title'].toString().toUpperCase(),
                          style: const TextStyle(color: Colors.black),
                        ),
                        onPressed: () {
                          switch (b['type']) {
                            case 'postback':
                              SocketService.sendMessage(text: b['payload']);
                              botOrUser.add(1);

                              addMessageToChat(
                                ChatMessage(type: 'text', text: b['title'], data: null, sender: 'user'),
                              );

                              break;
                            case 'web_url':
                              LaunchUrl(b['url']);
                          }
                        },
                      )
              ],
            ),
          )
        ],
      )));
    }

    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(top: 10, bottom: 10.0, left: 20.0, right: 20.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: listWidgets),
    );
  }

  void callEmoji(BuildContext context) {
    FocusScope.of(Get.context!).unfocus();
    print('Emoji Icon Pressed...');
  }

  addMessageToChat(ChatMessage message) {
    /// Get index to insert message
    // var messageIndex = messages.length;

    /// Add message to list of messages
    messageList.add(message);
    Widget data = buildMessage(message);

    messageWidgetList.add(data);

    /// Add message to animated list in UI
    // _listKey.currentState?.insertItem(messageIndex, duration: Duration(milliseconds: 300));
    // _listKey0.add(messageIndex);
    /// Scrolldown the list to show the latest message
    // scrollController.animateTo(
    //   scrollController.position.maxScrollExtent,
    //   duration: Duration(milliseconds: 600),
    //   curve: Curves.ease,
    // );
  }

  Widget buildMessage(ChatMessage message) {
    print('buildMessage type: ${message.type}');
    Widget messageWidget;

    String sender = message.sender ?? '';

    switch (message.type) {
      case 'text':
        messageWidget = textMessage(sender, message.text);
        break;
      case 'quick_replies':
        messageWidget = quickRepliesMessage(
          message.data,
          message.text,
        );
        break;
      case 'choiceSet':
        messageWidget = choiceSet(
          message.data,
          message.text,
        );
        break;
      case 'image_attachment':
        messageWidget = imageMessage(message.text);
        break;
      case 'gallery':
        messageWidget = galleryMessage(
          message.data,
        );
        break;
      case 'buttons':
        messageWidget = buttonsMessage(message.text, message.data);
        break;
      case 'list':
        messageWidget = listMessage(message.data);
        break;
      default:
        messageWidget = const SizedBox();
    }
    return messageWidget;
  }

  void callAttachFile() {
    sendMessage();
  }

  void callCamera() {
    print('Camera Icon Pressed...');
  }

  Widget moodIcon(BuildContext context) {
    return IconButton(
        icon: Icon(
          Icons.photo_camera_outlined,
          // CupertinoIcons.camera,
          size: 24,
          color: AppColor.black.withOpacity(0.6),
        ),
        onPressed: () => callEmoji(Get.context!));
  }

  Widget camera() {
    return IconButton(
      icon: const Icon(
        Icons.photo_camera,
        color: AppColor.black,
      ),
      onPressed: () => callCamera(),
    );
  }

  Widget attachFile() {
    return FaIcon(
      FontAwesomeIcons.paperPlane,
      color: AppColor.black.withOpacity(0.6),
      size: 18,
    );
  }
}*/

/// ********************* ///

import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:makaihealth/screens/chat/build_view_from_socket.dart';
import 'package:makaihealth/screens/home/controllers/home_controller.dart';
import 'package:makaihealth/utility/message_helper.dart';
import 'package:makaihealth/utility/socket.io.dart';

class ChatController extends GetxController {
  late ScrollController scrollController;

  TextEditingController messageController = TextEditingController();
  RxBool isConnectMessage = true.obs;
  RxBool isDialog = false.obs;
  RxString isRejected = ''.obs;
  final HomeController _homeController = Get.find();
  RxList<Widget> messageWidgetList = <Widget>[].obs;
  RxList<int> botOrUser = <int>[].obs; //bot=0 && user=1

  Future<void> sendMessage() async {
    if (messageController.text.isNotEmpty) {
      SocketService.sendMessage(text: messageController.text);
      botOrUser.add(1);
      addMessageToChat(ChatMessage(type: 'text', text: messageController.text, data: null, sender: 'user'));
      // messageWidgetList.add(ChatMessage(sender: 'user', text: messageController.text, type: 'text'));
      messageController.clear();
    }
  }

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController()
      ..addListener(() {
        if (scrollController.position.maxScrollExtent == scrollController.position.pixels) {}
      });
    socketConnection();
  }

  late Timer _timer;
  int _start = 20;

  @override
  void onClose() {
    super.onClose();
    scrollController.removeListener(() {
      // load more
    });
    SocketService.socketDisConnect();
  }

  Future<void> socketConnection() async {
    print('socketConnection 00');
    // if (_homeController.userProfileModel.value.data?.profile?.id?.isNotEmpty ?? false) {
    if (_homeController.userProfileModel.value.data?.id?.isNotEmpty ?? false) {
      print('socketConnection 02');
      SocketService.createSocketConnection();
    }
    print('socketConnection 03');
    _timer = Timer.periodic(
      const Duration(seconds: 3),
      (Timer timer) {
        if (_start == 0 || SocketService.connected.value) {
          timer.cancel();
          SocketService.socket?.on('output', (response) {
            log('output response : ${response.toString()}');
            ChatMessage? cognigyMessage = processCognigyMessage(response);
            if (cognigyMessage != null) {
              cognigyMessage.sender = 'bot';
              if (cognigyMessage.text != '=>') {
                botOrUser.add(0);
                addMessageToChat(cognigyMessage);
              }
            }
          });
        } else {
          _start--;
        }
      },
    );
  }

  void addMessageToChat(ChatMessage message) async {
    Widget data = buildMessage(message);
    messageWidgetList.add(data);
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (scrollController.position.pixels < scrollController.position.maxScrollExtent) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 300),
        );
      }
    });
  }

  Widget buildMessage(ChatMessage message) {
    print('buildMessage type: ${message.type}');
    Widget messageWidget;
    String sender = message.sender ?? '';
    switch (message.type) {
      case 'text':
        messageWidget = BotMessage.textMessage(sender, message.text);
        break;
      case 'quick_replies':
        messageWidget = BotMessage.quickRepliesMessage(
          message.data,
          message.text,
        );
        break;
      case 'choiceSet':
        messageWidget = BotMessage.choiceSet(
          message.data,
          message.text,
        );
        break;
      case 'image_attachment':
        messageWidget = BotMessage.imageMessage(message.text);
        break;
      case 'gallery':
        messageWidget = BotMessage.galleryMessage(
          message.data,
        );
        break;
      case 'buttons':
        messageWidget = BotMessage.buttonsMessage(message.text, message.data);
        break;
      case 'list':
        messageWidget = BotMessage.listMessage(message.data);
        break;
      // case 'VideoRecord':
      //   print('VideoRecord 00');
      //   messageWidget = BotMessage.videoView(message.data);
      //   break;
      // case 'ImageView':
      //   print('VideoRecord 00');
      //   messageWidget = BotMessage.imageView(message.data);
      //   break;
      default:
        messageWidget = const SizedBox();
    }
    return messageWidget;
  }
}
