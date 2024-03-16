// import 'dart:developer';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;
//
// class SocketService {
//   late IO.Socket _socket;
//
//   static RxBool connected = false.obs;
//  SocketService() {
//     try {
//       debugPrint("reciedved data--->S");
//       _socket = IO.io('https://endpoint-trial.cognigy.ai', <String, dynamic>{
//         'transports': ['websocket'],
//         'autoConnect': false,
//         'extraHeaders': {
//           'URLToken': 'bafebec090f608f17d1a8878cae34bf5d09099df639919002ee75de038c64f57',
//           'user_profile': '8318080811',
//         }
//       });
//       // _socket.io
//       //   ..disconnect()
//       //   ..connect();
//       // _socket.on("connect", (data) {
//       //   log("On Connect: $data");
//       //   connected.value = true;
//       //   ScaffoldMessenger.of(Get.context!).showSnackBar(
//       //     const SnackBar(
//       //       content: Text('Socket Connected Successfully!'),
//       //     ),
//       //   );
//       //   return true;
//       // });
//
//     }catch (e, st) {
//       log('SocketConnection Error: $e && st: $st');
//
//     }
//   }
//
//   void connect() {
//
//     debugPrint("reciedved data${_socket.connect().connected}");
//     debugPrint("reciedved data${_socket.connect().disconnected}");
//     _socket.connect();
//     _socket.onConnect((_) {
//       _socket.emit('processInput',{
//         'PatientID': 'clf1acyye0059alpb0d6r9qza',
//         'Email': 'examplepatient1@example.com',
//         'Name': 'xyz',
//       });
//       _socket.emit("processInput", "order Id testing");
//       _socket.on('orderStatusUpdate', (data) {
//         debugPrint(data);
//         debugPrint("reciedved data");
//       });
//     });
//     debugPrint("reciedved data${_socket.connect().json}");
//     debugPrint("reciedved data${_socket.connect().close()}");
//     debugPrint("reciedved data${_socket.connect().open()}");
//   }
//
//   void emit(String event, dynamic data) {
//     // socket.on("updateOrderStatus", async (orderId, newStatus) => {
//     // // Fetch the customer identifier or order details from your database
//     //
//     // const order = await Order.findOne({
//     // where: {
//     // order_id: orderId,
//     // },
//     // });
//     _socket.emit("updateOrderStatus", "order Id testing");
//   }
//
//   void disconnect() {
//     _socket.disconnect();
//   }
//
//   bool isConnected(){
//     return _socket.connected;
//   }
// }
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:get/get.dart';
import 'package:makaihealth/utility/utility.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:uuid/uuid.dart';

// class SocketService {
//   static IO.Socket? socket;
//   bool connected = false;
//   static const String socketUrl = 'https://endpoint-trial.cognigy.ai/';
//   static const String urlToken = '888e456f08be2784080bf9a976b00c9db0b7595e85a96610e0889e0bdba4cad8';
//   static const String endPoint = 'https://endpoint-trial.cognigy.ai/$urlToken';
//   final sessionId = const Uuid().v1();
//
//   // time-based
//   final userId = const Uuid().v4();
//
//   sendMessage(String text, dynamic data) {
//     // if (connected) {
//     log("[SocketClient] try to connect to Cognigy.AI");
//       socket!.emit('processInput', 'data');
//     // } else {
//     //   log('[SocketClient] Unable to directly send your message since we are not connected.');
//     // }
//   }
//
//   createSocketConnection() {
//     log("[SocketClient] try to connect to Cognigy.AI");
//
//     socket = IO.io('socketUrl', <String, dynamic>{
//       'transports': ['websocket'],
//       'extraHeaders': {
//         'URLToken': urlToken
//       }
//     });
//     socket!.connect();
//     log("[SocketClient] next");
//     log("${socket!.connected}");
//     log("${socket!.active}");
//     log("${socket!.id}");
//     socket!.on("connect", (_) {
//       log("[SocketClient] connection established");
//
//       connected = true;
//
//     });
//
//     socket!.on("disconnect", (_) => log("[SocketClient] disconnected"));
//   }
// }
class SocketService {
  static const String socketUrl = 'http://192.168.1.130:5000/';
  static const String urlToken =
      'bafebec090f608f17d1a8878cae34bf5d09099df639919002ee75de038c64f57';
  static const String endPoint = 'https://endpoint-trial.cognigy.ai/$urlToken';
  static IO.Socket? socket;
  static RxBool connected = false.obs;
  static final sessionId = const Uuid().v1();
  static final userId = const Uuid().v4();

  static void sendMessage({String? text, bool isUrl = false}) {
    log('connecting: $connected');

    if (connected.value) {
      socket?.emit('processInput', {
        'URLToken': urlToken,
        'text': text ?? "",
        'userId': userId,
        'sessionId': sessionId,
        'channel': 'flutter',
        'source': 'device',

      });
    } else {
      log(
          '[SocketClient] Unable to directly send your message since we are not connected.');
    }
  }

  static  createSocketConnection() {
    try {
      log("createSocketConnection 00:");
      socket = IO.io(socketUrl, <String, dynamic>{
        'transports': ['websocket'],
        'extraHeaders': {
          'URLToken': urlToken,

        }
      });
      socket?.io
        ?..disconnect()
        ..connect();
      //sendMessage();
      socket?.on("connect", (data) {
       // log("On Connect: $data");
        connected.value = true;
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          const SnackBar(
            content: Text('Socket Connected Successfully!'),
          ),
        );
        return true;
      });
      return false;
    } catch (e, st) {
      log('SocketConnection Error: $e && st: $st');
      return false;
    }
  }

  static socketDisConnect() {
    try {
      connected.value = false;
      socket?.io.disconnect();
      socket?.on("disconnect", (data) {
        log("On disconnect: $data");
      });
      socket?.clearListeners();
    } catch (e, st) {
      log('SocketConnection Error: $e && st: $st');
    }
  }
}
