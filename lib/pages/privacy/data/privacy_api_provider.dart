import 'package:first_step/base/base_auth_provider.dart';
import 'package:get/get_connect/http/src/response/response.dart';

import '../../../base/api_end_points.dart';
import '../../../services/auth_service.dart';

abstract class IPrivacyProvider {
  Future<Response<String>> getPrivacy();
}

class PrivacyProvider extends BaseAuthProvider implements IPrivacyProvider {
  @override
  Future<Response<String>> getPrivacy() {
    return get<String>(
        EndPoints.privacy,
      query: {
        "lang" : AuthService.to.language
      },
        decoder: (data) {
          return data?["privacy"].toString() ?? "";
        },
    );
  }
}
