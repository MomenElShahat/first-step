import 'package:get/get.dart';
import '../pages/bottom_navigation/controller/main_controller.dart';
import '../pages/center/home/presentation/controllers/home_controller.dart';
import '../routes/app_pages.dart';
import '../services/auth_service.dart';
import 'api_end_points.dart';
import 'api_error_response.dart';

class BaseProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.addRequestModifier<dynamic>((request) {
      final token = AuthService.to.userInfo?.token ?? "";

      request.headers['Accept'] = 'application/json';
      request.headers['Accept-Language'] = AuthService.to.language ?? "en";
      request.headers['Authorization'] = 'Bearer $token';
      request.headers['X-Authorization'] =
          "bJPJemOddVQ2nmRP9EdKeoumMXgpq9Zlzd3cbCH6obeGKI1m7vxE2q0vAYQvtH8J";
      request.headers['X-Authorization-Secret'] =
          "zTEr5qWx4QeeHrH1DSN8WoAkIlCdFzhULX7Eqm4VCXX9KgObn1oHgPPvDTTpkMMd";

      // print("🔐 Bearer Token: $token");
      print("🔐 Bearer Token: ${request.headers['Authorization']}");
      printInfo(info: "[Request] ${request.method} ${request.url}");
      printInfo(info: "[Headers] ${request.headers}");

      return request;
    });

    httpClient.timeout = const Duration(minutes: 10);

    httpClient.addResponseModifier((request, response) async {
      printInfo(info: "[Response] ${request.url}");
      printInfo(info: "[Body] ${response.bodyString ?? ''}");

      // Handle unauthorized globally
      if ((response.unauthorized || response.statusCode == 401) &&
          request.url.path != "/api/${EndPoints.loginV2}") {
        await AuthService.to.logout();
        final currentRoute = Get.currentRoute;
        if (currentRoute != Routes.BOTTOM_NAVIGATION) {
          Future.microtask(() => Get.offAllNamed(Routes.BOTTOM_NAVIGATION));
        }
      }

      // 🔎 Check for subscription-related errors
      try {
        if (response.body is Map<String, dynamic>) {
          final bodyMap = response.body as Map<String, dynamic>;
          final msg = bodyMap["message"]?.toString();

          if (msg != null &&
              (msg.contains("Your subscription has expired") ||
                  msg.contains("Your subscription is not active"))) {
            final currentRoute = Get.currentRoute;
            if (currentRoute != Routes.BOTTOM_NAVIGATION) {
              Future.microtask(() =>
                  Get.offAllNamed(Routes.BOTTOM_NAVIGATION, arguments: 0));
            } else {
              // Mark UI state for subscription expired when already on bottom navigation
              Future.microtask(() async {
                final controller = Get.find<MainController>();
                controller.isExpired.value = true;
              });
            }
          }
        }
      } catch (e) {
        printError(info: "Error parsing response for subscription check: $e");
      }

      return response;
    });
  }
}
