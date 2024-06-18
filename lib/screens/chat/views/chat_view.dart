//
// import 'package:bubble/bubble.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:makaihealth/utility/colors.dart';
// import 'package:makaihealth/utility/socket.io.dart';
// import 'package:makaihealth/utility/text_styles.dart';
// import '../controllers/chat_controller.dart';
//
// class ChatView extends GetView<ChatController> {
//   const ChatView({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async{
//         print('WillPopScope 00');
//         SocketService.socketDisConnect();
//         return true;
//       },
//       child: Scaffold(
//         backgroundColor: AppColor.white,
//         appBar: AppBar(
//           backgroundColor: AppColor.white,
//           elevation: 0,
//           title: const Text(
//             'AppString',
//             style: textSemiBold,
//           ),
//           leading: IconButton(
//             icon: const Icon(
//               CupertinoIcons.back,
//               color: AppColor.darkBlue,
//               size: 25,
//             ),
//             onPressed: () {
//               SocketService.socketDisConnect();
//               Get.back();
//             },
//           ),
//           centerTitle: true,
//         ),
//         body: SafeArea(
//           child: Obx(
//             () => Stack(
//               children: [
//                 Column(
//                   children: [
//                     Obx(
//                       () => Expanded(
//                         child: ListView.builder(
//                           controller: controller.scrollController,
//                           shrinkWrap: true,
//                           itemCount: controller.messageWidgetList.length,
//                           itemBuilder: (_, index) {
//                             // return Container(child: controller.messageWidgetList[index]);
//                             return Bubble(
//                               margin: BubbleEdges.only(
//                                 top: 7,
//                                 bottom: 7,
//                                 right: controller.botOrUser[index] == 1 ? 12 : 100,
//                                 left: controller.botOrUser[index] == 1 ? 100 : 12,
//                               ),
//                               alignment: controller.botOrUser[index] == 1 ? Alignment.topRight : Alignment.topLeft,
//                               nipWidth: 8,
//                               elevation: 2,
//                               radius: const Radius.circular(10),
//                               nipHeight: 24,
//                               nip: controller.botOrUser[index] == 1 ? BubbleNip.rightTop : BubbleNip.leftTop,
//                               color: controller.botOrUser[index] == 1 ? Colors.teal : AppColor.white,
//                               child: controller.messageWidgetList[index],
//                             );
//                           },
//                         ),
//                       ),
//                     ),
//                     ColoredBox(
//                       color: AppColor.white,
//                       child: Container(
//                         margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
//                         height: 45,
//                         child: Row(
//                           children: [
//                             Expanded(
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   color: AppColor.white,
//                                   borderRadius: BorderRadius.circular(8),
//                                   boxShadow: const [
//                                     BoxShadow(
//                                       color: Colors.grey,
//                                       blurRadius: 0.3,
//                                       spreadRadius: 0.3,
//                                     ),
//                                   ],
//                                 ),
//                                 child: Row(
//                                   children: [
//                                     Expanded(
//                                       child: Padding(
//                                         padding: const EdgeInsets.symmetric(horizontal: 15),
//                                         child: TextField(
//                                           controller: controller.messageController,
//                                           textInputAction: TextInputAction.send,
//                                           onTap: () {},
//                                           decoration: InputDecoration(
//                                             hintText: "Type here...",
//                                             border: InputBorder.none,
//                                             hintStyle: textRegular.copyWith(color: AppColor.grey),
//                                           ),
//                                           style:textRegular,
//                                           onSubmitted: (value) {
//                                             final String a = controller.messageController.text.trim();
//                                             if (a.isNotEmpty || a != '' || a.isNotEmpty) {
//                                               controller.sendMessage();
//                                             }
//                                           },
//                                         ),
//                                       ),
//                                     ),
//                                     const SizedBox(
//                                       width: 10,
//                                     ),
//                                     IconButton(
//                                       icon: Icon(
//                                         Icons.photo_camera_outlined,
//                                         // CupertinoIcons.camera,
//                                         size: 24,
//                                         color: AppColor.black.withOpacity(0.6),
//                                       ),
//                                       onPressed: () {
//                                         FocusScope.of(Get.context!).unfocus();
//                                       },
//                                     ),
//                                     const SizedBox(
//                                       width: 6,
//                                     ),
//                                     InkWell(
//                                       child: Icon(
//                                         Icons.ac_unit,
//                                         color: AppColor.black.withOpacity(0.6),
//                                         size: 18,
//                                       ),
//                                       onTap: () => controller.sendMessage(),
//                                     ),
//                                     const SizedBox(
//                                       width: 20,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SocketService.connected.value == false
//                     ? Container(
//                         width: double.infinity,
//                         height: double.infinity,
//                         color: Colors.grey.withOpacity(0.5),
//                         child: const Center(child: CircularProgressIndicator()))
//                     : const SizedBox(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
