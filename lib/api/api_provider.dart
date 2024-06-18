import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:makaihealth/main.dart';
import 'package:makaihealth/screens/home/response/chat_response.dart';
import 'package:uuid/uuid.dart';

import 'server_error.dart';

class ApiProvider {
  static ApiProvider apiProvider = ApiProvider.internal();
  String baseUrl = "https://newkyc.bigul.app/";

  ApiProvider.internal();

  factory ApiProvider() {
    return apiProvider;
  }

  //
  Future<CognigyApiResponse> login(Map<String, dynamic> input) async {
    log('input=>$input');
    String userId = const Uuid().v4();
    String sessionId = const Uuid().v4();
    const String baseUrl =
        'https://endpoint-trial.cognigy.ai/8800152e0ae59b64e3875a60d8ba4f76fb7814a203d4233fad745804369f171e';


    try {
      Response res = await dio.put(baseUrl,
          data: input,
          options: Options(
            headers: {'Content-Type': 'application/json'},
          ));
      log("===>${res.data}");
      return CognigyApiResponse.fromRawJson(res.toString());
    } catch (error) {
      String message = "";

      if (error is DioException) {
        ServerError e = ServerError.withError(error: error);
        message = e.getErrorMessage();
      } else {
        message = "Please try again later!";
      }
      return CognigyApiResponse(
          text: "Exception occurred: $message stackTrace: $error");
    }
  }
}
