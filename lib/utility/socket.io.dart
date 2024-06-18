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

import 'package:makaihealth/api/retriveData.dart';
import 'package:makaihealth/utility/logger.dart';
import 'package:makaihealth/utility/sharedpref.dart';
import 'package:makaihealth/utility/utility.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:uuid/uuid.dart';
import 'package:makaihealth/utility/config.dart' as config;

class SocketService {
  // Declaring the socket and connection status
  late IO.Socket socket;
  Map<String, dynamic> patient = {}, medicine = {}, condition = {};

  bool connected = false;

  // Generating unique session and user IDs
  final sessionId = const Uuid().v1();
  final userId = const Uuid().v4();

  // Method to create a socket connection
  void createSocketConnection() {
    // Initializing the socket with the server URL and connection options
    socket = IO.io(config.socketUrl, <String, dynamic>{
      'transports': ['websocket'],
      'query': {
        'urkToken': config.urlToken,
      },
      'autoConnect': false,
      'reconnectionAttempts': 5,
      'reconnectionDelay': 1000,
      'reconnectionDelayMax': 5000,
      'timeout': 20000,
      'forceNew': true,
    });

    // Event listeners for the socket connection
    socket.onConnect((_) {
      ("SocketService: Connected").logD;
      connected = true;
    });

    socket.onConnectError((data) {
      ("SocketService: Connection Error: $data").logD;
      connected = false;
    });

    socket.onConnectTimeout((_) {
      ("SocketService: Connection Timeout").logD;
      connected = false;
    });

    socket.onError((data) {
      ("SocketService: Error: $data").logD;
    });

    socket.onDisconnect((reason) {
      ("SocketService: Disconnected. Reason: $reason").logD;
      connected = false;
    });

    socket.onError((error) {
      ("SocketService: An error occurred: $error").logD;
    });

    // Listening for 'output' events from the server
    socket.on('output', (data) {
      ("SocketService: New message: $data").logD;
    });

    // Connecting the socket
    socket.connect();
  }

  // Method to send a message through the socket
  Future<void> sendMessage(String message) async {
    if (!connected) {
      // If the socket is not connected, attempt to reconnect
      ('SocketService: Socket is not connected. Attempting to reconnect...')
          .logD;
      createSocketConnection();
    }

    // Check again if the socket is connected
    if (connected) {
      String mobileNumber =
          await SharedPref.getStringPreference(SharedPref.MOBILE);
      // If the socket is connected, emit the 'processInput' event with the message data
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
            Utility.showToast(
                msg: 'Please Fill Medicine Name Dosage From Profile Tab');
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
            // view = true;
            // setState(() {
            //   if (view) {
            //     connectSocket();
            //   }
            // });
          });
        });
      });

      socket.emit('processInput', {
        'URLToken': config.urlToken,
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
      ('SocketService: Message sent: $message').logD;
    } else {
      // If the socket is still not connected,  an error message
      ('SocketService: Cannot send message, socket is not connected.').logD;
    }
  }

  // Method to dispose the socket connection
  void dispose() {
    if (socket.connected) {
      // If the socket is connected, disconnect it
      socket.disconnect();
    }
    connected = false;
  }
}

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
// class SocketService {
//   static const String socketUrl = 'http://192.168.1.130:5000/';
//   static const String urlToken =
//       'bafebec090f608f17d1a8878cae34bf5d09099df639919002ee75de038c64f57';
//   static const String endPoint = 'https://endpoint-trial.cognigy.ai/$urlToken';
//   static IO.Socket? socket;
//   static RxBool connected = false.obs;
//   static final sessionId = const Uuid().v1();
//   static final userId = const Uuid().v4();
//
//   static void sendMessage({String? text, bool isUrl = false}) {
//     log('connecting: $connected');
//
//     if (connected.value) {
//       log('Connected socket==>$userId');
//       log('Connected socket==>$sessionId');
//       socket!.emit('processInput', {
//         'URLToken':
//         'bafebec090f608f17d1a8878cae34bf5d09099df639919002ee75de038c64f57',
//         'text': "vaibhav",
//         'userId': userId,
//         'sessionId': sessionId,
//         'channel': 'flutter',
//         'source': 'device',
//         "data": {
//           'user_profile': 'AppString.userMobile)',
//           'email': 'vgour307@gmail.com',
//           'name': 'vaibhav',
//           'base': 'mp4',
//           'url': '',
//           'slug': 'slug',
//           'patientId': userId,
//           'patientConditionId': 'patientConditionId',
//         },
//       });
//       log("${socket!.id}");
//       socket!.onDisconnect((_) => log('Disconnected'));
//       socket!.on('connect', (data) {
//         log('Message: $data');
//       });
//       socket!.on('output', (response) {
//         log('output response : ${response.toString()}');
//       });
//     } else {
//       log(
//           '[SocketClient] Unable to directly send your message since we are not connected.');
//     }
//   }
//
//   static  createSocketConnection() {
//     try {
//       log("createSocketConnection 00:");
//       socket = IO.io(socketUrl, <String, dynamic>{
//         'transports': ['websocket'],
//         'extraHeaders': {
//           'URLToken': urlToken,
//
//         }
//       });
//       socket?.io
//         ?..disconnect()
//         ..connect();
//       //sendMessage();
//       socket?.on("connect", (data) {
//        log("On Connect: $data");
//         connected.value = true;
//         ScaffoldMessenger.of(Get.context!).showSnackBar(
//           const SnackBar(
//             content: Text('Socket Connected Successfully!'),
//           ),
//         );
//         return true;
//       });
//       return false;
//     } catch (e, st) {
//       log('SocketConnection Error: $e && st: $st');
//       return false;
//     }
//   }
//
//   static socketDisConnect() {
//     try {
//       connected.value = false;
//       socket?.io.disconnect();
//       socket?.on("disconnect", (data) {
//         log("On disconnect: $data");
//       });
//       socket?.clearListeners();
//     } catch (e, st) {
//       log('SocketConnection Error: $e && st: $st');
//     }
//   }
// }
