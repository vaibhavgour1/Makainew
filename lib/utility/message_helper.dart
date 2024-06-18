import 'package:flutter/material.dart';
import 'package:makaihealth/api/logger_interceptors.dart';
import 'package:makaihealth/screens/home/response/chat_response.dart';
import 'package:makaihealth/utility/dimension.dart';
import 'package:url_launcher/url_launcher.dart';

/// Gets Cognigy.AI message information.
///
/// This application uses the Webchat tab in the Say node to create template messages such as Gallery items or Images.
/// For plain text messages, use the Default tab in the Say node.
// ignore: missing_return
ChatMessage? processCognigyMessage(dynamic cognigyResponse) {
  if (cognigyResponse['type'] == 'output') {
    // check for simple text
    if (cognigyResponse['data']['text'] != null && cognigyResponse['data']['text'] != '') {
      return ChatMessage(type: 'text', text: cognigyResponse['data']['text'], data: null);
    }
    // check for choice set
    if (cognigyResponse['data']['data']['_plugin'] != null && cognigyResponse['data']['data']['_plugin']['payload']['body'] != null) {
      String text = cognigyResponse['data']['data']['_plugin']['payload']['body'][1]['label'];
      List quickReplies = cognigyResponse['data']['data']['_plugin']['payload']['body'].last['choices'];
      return ChatMessage(type: 'choiceSet', text: text, data: quickReplies);
    }
    // check for quick replies
    if (cognigyResponse['data']['data']['_cognigy']['_default']['_quickReplies']['quickReplies'] != null) {
      String text = cognigyResponse['data']['data']['_cognigy']['_default']['_quickReplies']['text'];
      List quickReplies = cognigyResponse['data']['data']['_cognigy']['_default']['_quickReplies']['quickReplies'];
      return ChatMessage(type: 'quick_replies', text: text, data: quickReplies);
    }
    // check for image
    if (cognigyResponse['data']['data']['_cognigy']['_webchat']['message']['attachment']['type'] == 'image') {
      String url = cognigyResponse['data']['data']['_cognigy']['_webchat']['message']['attachment']['payload']['url'];
      return ChatMessage(type: 'image_attachment', text: url, data: null);
    }
    // check for gallery
    if (cognigyResponse['data']['data']['_cognigy']['_webchat']['message']['attachment']['type'] == 'template' &&
        cognigyResponse['data']['data']['_cognigy']['_webchat']['message']['attachment']['payload']['template_type'] ==
            'generic') {
      List galleryItems =
      cognigyResponse['data']['data']['_cognigy']['_webchat']['message']['attachment']['payload']['elements'];

      return ChatMessage(type: 'gallery', text: '', data: galleryItems);
    }

    if (cognigyResponse['data']['data']['_cognigy']['_webchat']['message']['attachment']['type'] == 'video') {
      String url = cognigyResponse['data']['data']['_cognigy']['_webchat']['message']['attachment']['payload']['url'];

      return ChatMessage(type: 'video', text: url, data: null);
    }

    if (cognigyResponse['data']['data']['_cognigy']['_webchat']['message']['attachment']['type'] == 'video') {}

    // check for buttons
    if (cognigyResponse['data']['data']['_cognigy']['_webchat']['message']['attachment']['type'] == 'template' &&
        cognigyResponse['data']['data']['_cognigy']['_webchat']['message']['attachment']['payload']['template_type'] ==
            'button') {
      String buttonText =
      cognigyResponse['data']['data']['_cognigy']['_webchat']['message']['attachment']['payload']['text'];
      List buttons =
      cognigyResponse['data']['data']['_cognigy']['_webchat']['message']['attachment']['payload']['buttons'];

      return ChatMessage(type: 'buttons', text: buttonText, data: buttons);
    }

    // check for list
    if (cognigyResponse['data']['data']['_cognigy']['_webchat']['message']['attachment']['type'] == 'template' &&
        cognigyResponse['data']['data']['_cognigy']['_webchat']['message']['attachment']['payload']['template_type'] ==
            'list') {
      List listItems =
      cognigyResponse['data']['data']['_cognigy']['_webchat']['message']['attachment']['payload']['elements'];
      List listButtons =
      cognigyResponse['data']['data']['_cognigy']['_webchat']['message']['attachment']['payload']['buttons'];

      return ChatMessage(type: 'list', text: '', data: {'listItems': listItems, 'listButtons': listButtons});
    }
  }
  return null;
  // return ChatMessage(type: 'text', text: 'Error',data:  null);
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
          maxLines: 6,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
