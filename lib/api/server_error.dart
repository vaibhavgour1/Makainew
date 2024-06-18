import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:makaihealth/utility/utility.dart';


class ServerError implements Exception {
  int? _errorCode = 200;
  String _errorMessage = "";

  ServerError.withError({required DioException? error}) {
    _handleError(error!);
  }

  getErrorCode() {
    return _errorCode;
  }

  getErrorMessage() {
    return _errorMessage;
  }

  _handleError(DioException error) async {
    _errorCode = error.response!.statusCode!;
    (error);
    (error.message);
    switch (error.type) {
      case DioExceptionType.cancel:
        _errorMessage = "request  was  cancelled ";
        break;
      case DioExceptionType.connectionTimeout:
        _errorMessage = "connection  timeout ";
        break;
      case DioExceptionType.unknown:
        _errorMessage = "connection  failed  due  to  internet  connection ";
        break;
      case DioExceptionType.receiveTimeout:
        _errorMessage = "Receive timeout in connection";
        break;
      case DioExceptionType.badResponse:
        if (error.response!.statusCode == 401 ||
            error.response!.statusCode == 403) {

          _errorMessage = "Unautorized";

          Utility.showToast(msg: _errorMessage);
        }
        if (error.response!.statusCode == 404) {

          _errorMessage = error.response!.statusMessage!.isEmpty
              ? "Request not found. Please try again after some time."
              : error.response!.statusMessage.toString();
          log("message-$_errorMessage");
          error.response!.data!["user"] == null
              ? ""
              : Utility.showToast(msg: _errorMessage);
        }
        if (error.response!.statusCode == 202) {
          _errorMessage =
              "Network congestion error. Please check your internet connection.";
          Utility.showToast(msg: _errorMessage);
        }

        if (error.response!.statusCode == 429) {
          _errorMessage =
              "Network congestion error.. Please try again after some time.";
          Utility.showToast(msg: _errorMessage);
        }
        if (error.response!.statusCode == 500) {
          _errorMessage =
              "Something went wrong. Please try again after some time.";
          Utility.showToast(msg: _errorMessage);
        }
        if (error.response!.statusCode == 502) {
          _errorMessage =
              "Network congestion error.. Please try again after some time.";
          Utility.showToast(msg: _errorMessage);
        }
        if (error.response!.statusCode == 503) {
          _errorMessage =
              "The server is currently unavailable. Please try again after some time.";
          Utility.showToast(msg: _errorMessage);
        }
        if (error.response!.statusCode == 504) {
          _errorMessage = "Gateway timeout. Please try again after some time.";
          Utility.showToast(msg: _errorMessage);
        }
        if (error.response!.statusCode == 400) {
          _errorMessage = "400 Bad Request response";
          Utility.showToast(msg: _errorMessage);
        } else {

          _errorMessage = "Internal server Error";
          Utility.showToast(msg: _errorMessage);
        }

        break;

      case DioExceptionType.sendTimeout:
        _errorMessage = "Receive timeout in send request";
        break;
      case DioExceptionType.badCertificate:
        _errorMessage = "Certificate is not trusted: ${error.message}";
        break;
      case DioExceptionType.connectionError:
        _errorMessage = "Connection error: ${error.message}";
        break;
    }
    return _errorMessage;
  }


}
