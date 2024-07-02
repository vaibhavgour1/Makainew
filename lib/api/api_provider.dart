import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:makaihealth/main.dart';
import 'package:makaihealth/screens/assessment/response/AssessmentsResponse.dart';
import 'package:makaihealth/screens/home/response/chat_response.dart';
import 'package:makaihealth/screens/summery/response/summery-response.dart';
import 'package:makaihealth/utility/sharedpref.dart';
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
    const String baseUrl =
        "https://endpoint-trial.cognigy.ai/8800152e0ae59b64e3875a60d8ba4f76fb7814a203d4233fad745804369f171e"
        "?api_key=374383191a71d8a75a24e4eda6c9d81a9802961e0fff8d66be6fd00658bc8c81c80183fbbd9e3a0c22862e40b8d35c4ecea60f08c06921e34184762b71dbbeb2";

    try {
      Response res = await dio.post(baseUrl,
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

  Future<AssessmentsResponse> getAssesments() async {
    String mobileNumber =
        await SharedPref.getStringPreference(SharedPref.MOBILE);
    String baseUrl =
        "https://app.makaicare.com/patients/patient/assessments/patient/$mobileNumber?take=10&firstQueryResult=true&skipTake=true";

    try {
      Response res = await dio.get(baseUrl,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization':
                  'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJtb2JpbGVObyI6Ijc0MTg1Mjk2MzAiLCJyb2xlIjoiRE9DVE9SIiwiaWQiOiJjbHhxZmhkYXQwMDAwcGJ6cnJjeWhmbmQ2IiwiaWF0IjoxNzE5MDc5NTE2fQ.Oq_XtxKxLIS_W5ta8_aaLaeF3Ya_Wm5OxxIM9icXVZk'
                      ''
            },
          ));
      log("===>${res.data}");
      return AssessmentsResponse.fromRawJson(res.toString());
    } catch (error) {
      String message = "";

      if (error is DioException) {
        ServerError e = ServerError.withError(error: error);
        message = e.getErrorMessage();
      } else {
        message = "Please try again later!";
      }
      return AssessmentsResponse(
          text: "Exception occurred: $message stackTrace: $error");
    }
  }

  Future<EvaluationsResponse> getSummery() async {
    String mobileNumber =
        await SharedPref.getStringPreference(SharedPref.MOBILE);
    String baseUrl =
        "https://app.makaicare.com/evaluations/patient/$mobileNumber?take=10&firstQueryResult=true&skipTake=true";

    try {
      Response res = await dio.get(baseUrl,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization':
                  'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJtb2JpbGVObyI6Ijc0MTg1Mjk2MzAiLCJyb2xlIjoiRE9DVE9SIiwiaWQiOiJjbHhxZmhkYXQwMDAwcGJ6cnJjeWhmbmQ2IiwiaWF0IjoxNzE5MDc5NTE2fQ.Oq_XtxKxLIS_W5ta8_aaLaeF3Ya_Wm5OxxIM9icXVZk'
                      ''
            },
          ));
      log("===>${res.data}");
      return EvaluationsResponse.fromRawJson(res.toString());
    } catch (error) {
      String message = "";

      if (error is DioException) {
        ServerError e = ServerError.withError(error: error);
        message = e.getErrorMessage();
      } else {
        message = "Please try again later!";
      }
      return EvaluationsResponse(
          text: "Exception occurred: $message stackTrace: $error");
    }
  }
}
