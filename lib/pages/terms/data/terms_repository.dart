import 'package:first_step/pages/terms/data/terms_api_provider.dart';
import 'package:get/get_connect/http/src/response/response.dart';

import '../../../base/base_repositroy.dart';

abstract class ITermsRepository {
  Future<Response<String>> getTerms();
}

class TermsRepository extends BaseRepository implements ITermsRepository {
  TermsRepository({required this.provider});

  final ITermsProvider provider;

  @override
  Future<Response<String>> getTerms()async {
    final apiResponse =
    await provider.getTerms();
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
