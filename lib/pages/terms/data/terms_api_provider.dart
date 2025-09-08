import 'package:first_step/base/base_auth_provider.dart';
import 'package:first_step/services/auth_service.dart';
import 'package:get/get_connect/http/src/response/response.dart';

import '../../../base/api_end_points.dart';

abstract class ITermsProvider {
  Future<Response<String>> getTerms();
}

class TermsProvider extends BaseAuthProvider implements ITermsProvider {
  @override
  Future<Response<String>> getTerms() {
    return get<String>(
        EndPoints.termsAndCondition,
        query: {
          "lang" : AuthService.to.language
        },
        decoder: (data) {
          return data?["terms"].toString() ?? "";
        },
    );
  }
}
