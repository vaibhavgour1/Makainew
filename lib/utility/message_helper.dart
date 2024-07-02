import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:makaihealth/api/logger_interceptors.dart';
import 'package:makaihealth/screens/home/response/chat_response.dart';
import 'package:makaihealth/utility/dimension.dart';
import 'package:url_launcher/url_launcher.dart';

/// Gets Cognigy.AI message information.
///
/// This application uses the Webchat tab in the Say node to create template messages such as Gallery items or Images.
/// For plain text messages, use the Default tab in the Say node.
// ignore: missing_return

ChatMessage? processCognigyMessage(CognigyApiResponse cognigyResponse) {
  // '==>${cognigyResponse.data!.cognigy!.first}'.logD;
  '==>${cognigyResponse.text}'.logD;
  '==>${cognigyResponse.data?.text}'.logD;
  '==>${cognigyResponse.data?.text}'.logD;
  if (cognigyResponse.isBlank==false) {
    '-->${cognigyResponse.data?.data?.cognigy?.cognigyDefault?.quickReplies!.type}'.logD;

    if (cognigyResponse.data?.data?.cognigy?.cognigyDefault?.quickReplies != null) {
      String text = cognigyResponse.data?.data?.cognigy?.cognigyDefault?.quickReplies?.text ?? '';
      List quickReplies = cognigyResponse.data?.data?.cognigy?.cognigyDefault?.quickReplies?.quickReplies ?? [];
      return ChatMessage(type: 'quick_replies', text: text, data: quickReplies);
    }
    // Check for simple text
    if (cognigyResponse.text != null && cognigyResponse.text!.isNotEmpty) {
      return ChatMessage(type: 'text', text: cognigyResponse.text, data: null);
    }

    // Check for choice set
    if (cognigyResponse.data?.data?.cognigy?.cognigyDefault?.quickReplies != null) {
      String text = cognigyResponse.data?.data?.cognigy?.cognigyDefault?.quickReplies?.text ?? '';
      List quickReplies = cognigyResponse.data?.data?.cognigy?.cognigyDefault?.quickReplies?.quickReplies ?? [];
      return ChatMessage(type: 'choiceSet', text: text, data: quickReplies);
    }

    // Check for quick replies


    // Check for image
    if (cognigyResponse.data?.data?.cognigy?.cognigyDefault?.quickReplies?.type == 'image') {
      String url = cognigyResponse.data?.data?.cognigy?.cognigyDefault?.quickReplies?.text ?? '';
      return ChatMessage(type: 'image_attachment', text: url, data: null);
    }

    // Check for gallery
    if (cognigyResponse.data?.data?.cognigy?.cognigyDefault?.quickReplies?.type == 'template' &&
        cognigyResponse.data?.data?.cognigy?.cognigyDefault?.quickReplies?.text == 'generic') {
      List galleryItems = cognigyResponse.data?.data?.cognigy?.cognigyDefault?.quickReplies?.quickReplies ?? [];
      return ChatMessage(type: 'gallery', text: '', data: galleryItems);
    }

    // Check for video
    if (cognigyResponse.data?.data?.cognigy?.cognigyDefault?.quickReplies?.type == 'video') {
      String url = cognigyResponse.data?.data?.cognigy?.cognigyDefault?.quickReplies?.text ?? '';
      return ChatMessage(type: 'video', text: url, data: null);
    }

    // Check for buttons
    if (cognigyResponse.data?.data?.cognigy?.cognigyDefault?.quickReplies?.type == 'template' &&
        cognigyResponse.data?.data?.cognigy?.cognigyDefault?.quickReplies?.text == 'button') {
      String buttonText = cognigyResponse.data?.data?.cognigy?.cognigyDefault?.quickReplies?.text ?? '';
      List buttons = cognigyResponse.data?.data?.cognigy?.cognigyDefault?.quickReplies?.quickReplies ?? [];
      return ChatMessage(type: 'buttons', text: buttonText, data: buttons);
    }

    // Check for list
    if (cognigyResponse.data?.data?.cognigy?.cognigyDefault?.quickReplies?.type == 'template' &&
        cognigyResponse.data?.data?.cognigy?.cognigyDefault?.quickReplies?.text == 'list') {
      List listItems = cognigyResponse.data?.data?.cognigy?.cognigyDefault?.quickReplies?.quickReplies ?? [];
      return ChatMessage(type: 'list', text: '', data: listItems);
    }
  }
  return null;
}

// method to open a url
// LaunchUrl(String url) async {
//   if (await canLaunch(url)) {
//     await launch(url);
//   } else {
//     throw 'Could not launch $url';
//   }
// }

class ChatMessage {
  final String? type;
  final String? text;
  final dynamic data;
  String? sender;

  ChatMessage({this.type = '', this.text = '', this.data, this.sender = 'bot'});

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      type: json['type'] ?? 'text',
      text: json['text'] ?? 'text',
      data: json['data']??{},
      sender: json['sender'] ?? 'bot',
    );
  }
}
class CustomCardTile extends StatelessWidget {
  final String text;
  final TextStyle textStyle;

  const CustomCardTile({super.key, required this.text, required this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0, // Adjust the elevation as needed
      color: Colors.white,
      margin: EdgeInsets.only(right: AppSize.w100,left: AppSize.w10,top:  AppSize.w10),
      // Set the background color to white
      child: ListTile(
        title: Text(
          text,
          style: textStyle,
          maxLines: 10,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
