import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../routes/app_pages.dart';
import '../services/auth_service.dart';
import 'api_error_response.dart';


class DioExceptions implements Exception {
  late String message;

  DioExceptions.fromDioError(DioException dioError) {
    print("DioExceptions ${dioError.response}");
    switch (dioError.type) {
      case DioExceptionType.cancel:
        print("DioErrorType.cancel");

        message = "Request to API server was cancelled";
        break;
      case DioExceptionType.connectionTimeout:
        print("DioErrorType.connectTimeout");

        message = "تأكد من الانترنت";
        break;
      case DioExceptionType.receiveTimeout:
        print("DioErrorType.receiveTimeout");

        message = "Receive timeout in connection with API server";
        break;
      case DioExceptionType.badResponse:
        ApiErrorResponse apiErrorResponse = ApiErrorResponse.fromJson(dioError.response?.data);
        if(dioError.response?.statusCode == 401){
          // Get.rootDelegate.backUntil(Routes.HOME).then((value) => Get.rootDelegate.offNamed(Routes.LOGIN));
          AuthService.to.logout();
        }
        print( "ApiErrorResponse.fromJson( dioError.response?.data,).msg : ${dioError.response?.data}");
        message =apiErrorResponse.messages?.join('\n') ??
            "Something went wrong please try again later";
        break;
      case DioExceptionType.sendTimeout:
        print("DioErrorType.sendTimeout");

        message = "Send timeout in connection with API server";
        break;
      case DioExceptionType.unknown:
        print(" DioErrorType.other");

        message = "Unexpected error occurred";
        break;
      default:
        print("Something went wrong");

        message = "Something went wrong";
        break;
    }
  }

  Future<String> _handleError(int? statusCode, dynamic error) async {
    switch (statusCode) {
      case 400:
        return 'Bad request';
      case 401:
        // Get.rootDelegate.backUntil(Routes.HOME).then((value) => Get.rootDelegate.offNamed(Routes.LOGIN));
        await AuthService.to.logout();
        return 'Unauthorized';
      case 403:
        return 'Forbidden';
      case 404:
        return error['message'];
      case 410:
        return error['error in internet'];
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
}