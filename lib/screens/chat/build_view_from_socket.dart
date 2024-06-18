// import 'dart:convert';
// import 'dart:developer';
// import 'dart:io';
//
// import 'package:http/http.dart' as http;
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:makaihealth/screens/chat/controllers/chat_controller.dart';
// import 'package:makaihealth/utility/message_helper.dart';
// import 'package:makaihealth/utility/socket.io.dart';
//
// class BotMessage {
//   static ChatController controller = Get.find();
//   static Widget textMessage(String sender, String text) {
//     if (text == null) return Container();
//     return GestureDetector(
//       onTap: () => sender == 'user' ? controller.messageController.text = text : null,
//       child: Container(
//         alignment: sender == 'bot' ? Alignment.centerLeft : Alignment.centerRight,
//         child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
//             decoration: BoxDecoration(
//               border: null,
//               borderRadius: BorderRadius.circular(30.0),
//             ),
//             child: Text(
//               text,
//             )),
//       ),
//     );
//   }
//   static bool isVideoMessage = false;
//   static Widget quickRepliesMessage(
//     quickReplies,
//     String text,
//   ) {
//     List<Widget> quickReplyWidgets = <Widget>[];
//     for (var qr in quickReplies) {
//       print('text 00: ${text}');
//       // quickReplyWidgets.add(Padding(
//       //   padding: const EdgeInsets.all(8.0),
//       //   child: ElevatedButton(
//       //     child: Text(qr['title']),
//       //     onPressed: () async {
//       //       if (text.toLowerCase().contains('tap on start to record your physical exam')) {
//       //         isVideoMessage = false;
//       //         String path = await Get.to(() => CameraScreen());
//       //         if (path != '') {
//       //           print('video path 00: $path');
//       //           String? videoNetworkUrl = await AWSHelper.uploadDocuments(File(path));
//       //           SocketService.sendMessage(text: AppString.awsDownloadUrl + (videoNetworkUrl ?? ''), isUrl: true);
//       //           controller.botOrUser.add(1);
//       //           String thumbnail = await AppFunction.generateThumb(path: path);
//       //           controller.addMessageToChat(
//       //               ChatMessage(type: 'VideoRecord', text: qr['title'], data: [thumbnail, path], sender: 'user'));
//       //         }
//       //       } else if (text.toLowerCase().contains('tap on start to take a picture of the surgical site')) {
//       //         isVideoMessage = false;
//       //         String? path = await AppFunction.imagePickerFromCamera();
//       //         if (path != '') {
//       //           print('image path 00: $path');
//       //           String? imageNetworkUrl = await AWSHelper.uploadDocuments(File(path!));
//       //           SocketService.sendMessage(text: AppString.awsDownloadUrl + (imageNetworkUrl ?? ''), isUrl: true);
//       //           controller.botOrUser.add(1);
//       //           controller.addMessageToChat(
//       //             ChatMessage(type: 'ImageView', text: qr['title'], data: path, sender: 'user'),
//       //           );
//       //         }
//       //       } else {
//       //         // if (qr['title'].toString() == "We are going to record an assessment video. Select 'Yes' to enable the camera.") {
//       //         //   isVideoMessage = true;
//       //         // }
//       //         SocketService.sendMessage(text: qr['payload']);
//       //         controller.botOrUser.add(1);
//       //         controller.addMessageToChat(ChatMessage(type: 'text', text: qr['title'], data: null, sender: 'user'));
//       //       }
//       //     },
//       //   ),
//       // ));
//     }
//     return Container(
//       alignment: Alignment.centerLeft,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Container(
//               padding: const EdgeInsets.all(20.0),
//               margin: const EdgeInsets.only(top: 10, bottom: 10.0, left: 20.0, right: 20.0),
//               decoration: BoxDecoration(
//                 // color: Theme.of(Get.context!).primaryColor,
//                 border: null,
//                 borderRadius: BorderRadius.circular(30.0),
//               ),
//               child: Text(
//                 text,
//               )),
//           Padding(
//             padding: const EdgeInsets.only(left: 10.0),
//             child: Wrap(children: quickReplyWidgets),
//           )
//         ],
//       ),
//     );
//   }
//   static Widget choiceSet(
//     quickReplies,
//     String text,
//   ) {
//     RxList<int> isSelected = <int>[].obs;
//     return Container(
//       alignment: Alignment.centerLeft,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Container(
//               padding: const EdgeInsets.all(20.0),
//               margin: const EdgeInsets.only(top: 10, bottom: 10.0, left: 20.0, right: 20.0),
//               decoration: BoxDecoration(
//                 // color: Theme.of(Get.context!).primaryColor,
//                 border: null,
//                 borderRadius: BorderRadius.circular(30.0),
//               ),
//               child: Text(
//                 text,
//               )),
//           Wrap(
//             children: [
//               for (int index = 0; index < quickReplies.length; index++)
//                 GestureDetector(
//                   onTap: () {
//                     if (isSelected.contains(index)) {
//                       isSelected.remove(index);
//                     } else {
//                       isSelected.add(index);
//                     }
//                   },
//                   child: Obx(
//                     () => Container(
//                         color: isSelected.contains(index) ? Colors.blue : Colors.grey.withOpacity(0.5),
//                         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                         margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
//                         child: Text(quickReplies[index]['title'])),
//                   ),
//                 ),
//             ],
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           ElevatedButton(
//             child: const Text('Send'),
//             onPressed: () {
//               SocketService.sendMessage(
//                   text: isSelected.map((element) => quickReplies[element]['title'].toString()).toList().toString());
//               // addMessageToChat(ChatMessage(type: 'text', text: qr['title'], data: null, sender: 'user'));
//             },
//           ),
//         ],
//       ),
//     );
//   }
//   static Widget imageMessage(String url) {
//     return Container(
//       alignment: Alignment.centerLeft,
//       child: Container(
//           margin: const EdgeInsets.only(top: 10, bottom: 10.0, left: 20.0, right: 50.0),
//           child: ClipRRect(
//             child: Image.network(url),
//             borderRadius: BorderRadius.circular(10.0),
//           )),
//     );
//   }
//   static Widget galleryMessage(
//     List elements,
//   ) {
//     return Container(
//         alignment: Alignment.centerLeft,
//         margin: const EdgeInsets.symmetric(vertical: 20.0),
//         height: 330,
//         child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: elements.length,
//             itemBuilder: (BuildContext context, int itemIndex) {
//               return Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                 width: MediaQuery.of(Get.context!).size.width,
//                 child: Card(
//                     // color: MediaQuery.of(Get.context!).platformBrightness == Brightness.dark
//                     //     ? Theme.of(Get.context!).primaryColor
//                     //     : Colors.white,
//                     child: Column(
//                   children: <Widget>[
//                     SizedBox(
//                       height: 250.0,
//                       child: Stack(
//                         children: <Widget>[
//                           Positioned.fill(
//                               child: Container(
//                             color: Colors.black,
//                             child: Opacity(
//                               opacity: 0.5,
//                               child: Image.network(elements[itemIndex]['image_url'], fit: BoxFit.cover),
//                             ),
//                           )),
//                           Positioned(
//                             bottom: 0.0,
//                             left: 16.0,
//                             right: 16.0,
//                             child: FittedBox(
//                                 fit: BoxFit.scaleDown,
//                                 alignment: Alignment.centerLeft,
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: <Widget>[
//                                     Text(
//                                       elements[itemIndex]['title'],
//                                       style: Theme.of(Get.context!).textTheme.headline6,
//                                     ),
//                                     Text(
//                                       elements[itemIndex]['subtitle'],
//                                       style: Theme.of(Get.context!).textTheme.subtitle2,
//                                     )
//                                   ],
//                                 )),
//                           )
//                         ],
//                       ),
//                     ),
//                     ButtonBarTheme(
//                       data: const ButtonBarThemeData(),
//                       child: ButtonBar(
//                         buttonPadding: const EdgeInsets.symmetric(horizontal: 10),
//                         alignment: MainAxisAlignment.end,
//                         children: <Widget>[
//                           if (elements[itemIndex]['buttons'] != null)
//                             for (var b in elements[itemIndex]['buttons'])
//                               ElevatedButton(
//                                 child: Text(
//                                   b['title'].toUpperCase(),
//                                   style: const TextStyle(color: Colors.black),
//                                 ),
//                                 onPressed: () {
//                                   switch (b['type']) {
//                                     case 'postback':
//                                       SocketService.sendMessage(text: b['payload']);
//                                       controller.botOrUser.add(1);
//
//                                       controller.addMessageToChat(
//                                           ChatMessage(type: 'text', text: b['title'], data: null, sender: 'user'));
//
//                                       break;
//                                     case 'web_url':
//                                       LaunchUrl(b['url']);
//                                   }
//                                 },
//                               )
//                         ],
//                       ),
//                     )
//                   ],
//                 )),
//               );
//             }));
//   }
//   static Widget buttonsMessage(
//     String buttonText,
//     List buttons,
//   ) {
//     List<Widget> buttonWidgets = <Widget>[];
//     for (var b in buttons) {
//       buttonWidgets.add(
//         ElevatedButton(
//           child: Text(
//             b['title'],
//             style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.blue),
//           ),
//           onPressed: () {
//             switch (b['type']) {
//               case 'postback':
//                 SocketService.sendMessage(text: b['payload']);
//                 controller.botOrUser.add(1);
//
//                 controller.addMessageToChat(
//                   ChatMessage(type: 'text', text: b['title'], data: null, sender: 'user'),
//                 );
//
//                 break;
//               case 'web_url':
//                 LaunchUrl(b['url']);
//                 break;
//             }
//           },
//         ),
//       );
//     }
//
//     return Container(
//       alignment: Alignment.centerLeft,
//       margin: const EdgeInsets.only(top: 10, bottom: 10.0, left: 20.0, right: 20.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Container(
//             padding: const EdgeInsets.all(20.0),
//             decoration: const BoxDecoration(
//               border: null,
//               borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
//             ),
//             child: Text(
//               buttonText,
//             ),
//           ),
//           Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: buttonWidgets),
//         ],
//       ),
//     );
//   }
//   static Widget listMessage(
//     dynamic data,
//   ) {
//     List items = data['listItems'];
//     List buttons = data['listButtons'];
//
//     List<Widget> listWidgets = <Widget>[];
//
//     for (var item in items) {
//       listWidgets.add(Card(
//           child: Column(
//         children: <Widget>[
//           SizedBox(
//             height: 250.0,
//             child: Stack(
//               children: <Widget>[
//                 Positioned.fill(
//                     child: Container(
//                   color: Colors.black,
//                   child: Opacity(
//                     opacity: item['image_url'].toString().isNotEmpty ? 0.5 : 1,
//                     child: item['image_url'].toString().isNotEmpty
//                         ? Image.network(item['image_url'], fit: BoxFit.cover)
//                         : Container(),
//                   ),
//                 )),
//                 Positioned(
//                   bottom: 16.0,
//                   left: 16.0,
//                   right: 16.0,
//                   child: FittedBox(
//                       fit: BoxFit.scaleDown,
//                       alignment: Alignment.bottomLeft,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           Text(
//                             item['title'],
//                             style: TextStyle(
//                                 color: item['image_url'].toString().isNotEmpty ? Colors.white : Colors.black,
//                                 fontWeight: FontWeight.w700,
//                                 fontSize: 20),
//                           ),
//                           Text(
//                             item['subtitle'],
//                             style: TextStyle(
//                                 color: item['image_url'].toString().isNotEmpty ? Colors.white : Colors.black,
//                                 fontWeight: FontWeight.w600,
//                                 fontSize: 15),
//                           )
//                         ],
//                       )),
//                 )
//               ],
//             ),
//           ),
//           ButtonBarTheme(
//             data: const ButtonBarThemeData(),
//             child: ButtonBar(
//               buttonPadding: const EdgeInsets.symmetric(horizontal: 10),
//               alignment: MainAxisAlignment.end,
//               children: <Widget>[
//                 if (item['buttons'] != null)
//                   for (var b in item['buttons'])
//                     if (b['type'] != 'element_share')
//                       ElevatedButton(
//                         child: Text(
//                           b['title'].toString().toUpperCase(),
//                           style: const TextStyle(color: Colors.black),
//                         ),
//                         onPressed: () {
//                           switch (b['type']) {
//                             case 'postback':
//                               SocketService.sendMessage(text: b['payload']);
//                               controller.botOrUser.add(1);
//                               controller.addMessageToChat(
//                                 ChatMessage(type: 'text', text: b['title'], data: null, sender: 'user'),
//                               );
//
//                               break;
//                             case 'web_url':
//                               LaunchUrl(b['url']);
//                           }
//                         },
//                       )
//               ],
//             ),
//           )
//         ],
//       )));
//     }
//
//     return Container(
//       alignment: Alignment.centerLeft,
//       margin: const EdgeInsets.only(top: 10, bottom: 10.0, left: 20.0, right: 20.0),
//       child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: listWidgets),
//     );
//   }
//   // static Widget videoView(path) {
//   //   print('VideoRecord 01: $path');
//   //   if (path == '') return const Text('No video recorded!');
//   //   return GestureDetector(
//   //     onTap: () {
//   //       Get.to(
//   //         () => ChewiePlayer(
//   //           videoUrl: File(path.last),
//   //         ),
//   //       );
//   //     },
//   //     child: Image.file(
//   //       File(path.first),
//   //       height: 150,
//   //       width: 150,
//   //     ),
//   //   );
//   // }
//   // static Widget imageView(path) {
//   //   print('imageView 01: $path');
//   //   if (path == '') return const Text('No image!');
//   //   return Image.file(
//   //     File(path),
//   //     height: 150,
//   //     width: 150,
//   //   );
//   // }
// }
// apiCall(path) async {
//   // try {
//   //   log('Video apiCall 01:');
//   //   const apiUrl = 'https://api.cognigy.com/v1/events';
//   //   final headers = {'Authorization': 'Bearer 888e456f08be2784080bf9a976b00c9db0b7595e85a96610e0889e0bdba4cad8'};
//   //   final body = {
//   //     'eventName': 'videoUploaded',
//   //     'data': {'file': base64Encode(File(path).readAsBytesSync())},
//   //   };
//   //   log('Video apiCall 03:');
//   //   final response = await http.post(Uri.parse(apiUrl), headers: headers, body: jsonEncode(body));
//   //   log('Video apiCall 04: $response');
//   // } catch (e,st) {
//   //   log('Video apiCall Error: $e && st: $st');
//   // }
//
//   // final apiUrl = 'https://api.cognigy.com/endpoint/upload';
//   try {
//     const apiUrl =
//         'https://endpoint-trial.cognigy.ai/888e456f08be2784080bf9a976b00c9db0b7595e85a96610e0889e0bdba4cad8/upload';
//     log('Video apiCall 01:');
//     // Create a multipart request with a file part
//     var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
//     log('Video apiCall 02:');
//     request.headers['Authorization'] = 'Bearer 888e456f08be2784080bf9a976b00c9db0b7595e85a96610e0889e0bdba4cad8';
//     request.files.add(await http.MultipartFile.fromPath('file', path));
//     log('Video apiCall 03:');
//     // Send the request
//     var response = await request.send();
//     log('Video apiCall 04:');
//     // Read the response as a string
//     var responseString = await response.stream.bytesToString();
//     log('Video apiCall 05: $responseString');
//     // Parse the JSON response to get the video URL
//     var jsonResponse = jsonDecode(responseString);
//     var videoUrl = jsonResponse['url'];
//     log('Video apiCall 06:');
//     log('videoUrl: $videoUrl');
//     log('Video apiCall 07:');
//     return videoUrl;
//   } catch (e, st) {
//     log('Video apiCall Error: $e && st: $st');
//   }
// }
