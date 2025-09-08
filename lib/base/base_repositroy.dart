import 'dart:convert';
import 'package:first_step/pages/center/home/presentation/controllers/home_controller.dart';
import 'package:get/get.dart';

import '../pages/bottom_navigation/controller/main_controller.dart';
import '../resources/strings_generated.dart';
import '../routes/app_pages.dart';
import '../services/internet_service.dart';
import 'api_error_response.dart';

class BaseRepository {
  String getErrorMessage(String apiResponse, {bool isStrip = false}) {
    if (apiResponse.isNotEmpty && !isStrip) {
      final responseJson = const JsonDecoder().convert(apiResponse);
      ApiErrorResponse errorResponse = ApiErrorResponse.fromJson(responseJson);

      final errorMessage = errorResponse.messages?.join('\n') ??
          errorResponse.message ?? // Prefer single message if available
          errorResponse.error?.toString();

      // 🔎 Check for subscription-related errors here as well
      if (errorMessage != null &&
          (errorMessage.contains("Your subscription has expired") ||
              errorMessage.contains("Your subscription is not active"))) {
        final currentRoute = Get.currentRoute;
        if (currentRoute != Routes.BOTTOM_NAVIGATION) {
          Future.microtask(() async {
            Get.offAllNamed(Routes.BOTTOM_NAVIGATION, arguments: 0);
          });
        } else {
          Future.microtask(() async {
            final controller = Get.find<MainController>();
            controller.isExpired.value = true;
            // controller.bottomController.index = 2;
            // controller.bottomController.jumpToTab(2);
            // final homeController = Get.find<HomeController>();
            // await homeController.getPlans();
          });
        }
      }

      return errorMessage ?? AppStrings.somethingWentWrongPleaseTryAgainLater;
    } else {
      if (InternetService.to.checkConnection()) {
        return isStrip ? apiResponse : AppStrings.internalServerError;
      } else {
        return AppStrings.checkInternet;
      }
    }
  }
}
