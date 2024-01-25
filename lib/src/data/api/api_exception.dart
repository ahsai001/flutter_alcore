import 'package:dio/dio.dart';
import 'package:get/get_connect/http/src/response/response.dart'
    as get_response;
import 'package:get/get_connect/http/src/status/http_status.dart';

class ApiExceptions implements Exception {
  late String message;

  ApiExceptions.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.cancel:
        message = "Request to API server was cancelled";
        break;
      case DioExceptionType.connectionTimeout:
        message = "Connection timeout with API server";
        break;
      case DioExceptionType.receiveTimeout:
        message = "Receive timeout in connection with API server";
        break;
      case DioExceptionType.sendTimeout:
        message = "Send timeout in connection with API server";
        break;
      case DioExceptionType.badResponse:
        message = _handleError(
          dioError.response?.statusCode,
          dioError.response?.data,
        );
        break;
      case DioExceptionType.connectionError:
      case DioExceptionType.unknown:
        if (dioError.message?.contains("SocketException") ?? false) {
          message = 'No Internet';
          break;
        }
        message = _handleError(
          dioError.response?.statusCode,
          dioError.response?.data,
        );
        //message = "Unexpected error occurred";
        break;
      default:
        message = _handleError(
          dioError.response?.statusCode,
          dioError.response?.data,
        );
        break;
    }
  }

  String _handleError(int? statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return 'Bad request';
      case 401:
        return 'Unauthorized';
      case 403:
        return 'Forbidden';
      case 404:
        return error['message'];
      case 500:
        return 'Internal server error';
      case 502:
        return 'Bad gateway';
      default:
        return 'Oops something went wrong';
    }
  }

  @override
  String toString() => message;

  int? statusCode;

  late HttpStatus status;

  ApiExceptions.fromGetXError(get_response.Response response) {
    if (response.status.hasError) {
      message = response.statusText!;
      status = response.status;
      statusCode = response.statusCode;

      switch (response.status.code) {
        case null:
          if (response.statusText!.contains("SocketException")) {
            message = 'No Internet';
            break;
          }
          message = "Unexpected error occurred";
          break;
        case HttpStatus.clientClosedRequest:
          message = "Request to API server was cancelled";
          break;
        case HttpStatus.networkConnectTimeoutError:
          message = "Connection timeout with API server";
          break;
        case HttpStatus.connectionClosedWithoutResponse:
          message = "Receive timeout in connection with API server";
          break;
        case HttpStatus.requestTimeout:
          message = "Send timeout in connection with API server";
          break;
        default:
          message = _handleError(
            statusCode,
            "",
          );
          break;
      }
    }
  }
}
