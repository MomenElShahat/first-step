import 'package:first_step/pages/privacy/data/privacy_api_provider.dart';
import 'package:get/get_connect/http/src/response/response.dart';

import '../../../base/base_repositroy.dart';

abstract class IPrivacyRepository {
  Future<Response<String>> getPrivacy();
}

class PrivacyRepository extends BaseRepository implements IPrivacyRepository {
  PrivacyRepository({required this.provider});

  final IPrivacyProvider provider;

  @override
  Future<Response<String>> getPrivacy()async {
    final apiResponse =
    await provider.getPrivacy();
    print(apiResponse.bodyString);
    if (apiResponse.isOk && apiResponse.body != null&& (apiResponse.statusCode==200) || apiResponse.statusCode==201) {
      return apiResponse;
    } else {
      print(apiResponse.bodyString);
      print(apiResponse.statusCode);
      throw (getErrorMessage(apiResponse.bodyString!));
    }
  }
}
