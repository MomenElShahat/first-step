import 'package:get/get_connect/http/src/response/response.dart';

import '../../../../../base/base_repositroy.dart';
import '../../../center/auth/signup/models/cities_model.dart';
import '../models/centers_model.dart';
import '../models/services_model.dart';
import 'home_parent_api_provider.dart';

abstract class IHomeParentRepository {
  Future<Response<ServicesParentResponseModel>> getServices();
  Future<Response<CentersModel>> getCentersWithFilter({required String filter,required List<String> selectedCityIds});
  Future<Response<CitiesModel>> getCities();
}

class HomeParentRepository extends BaseRepository implements IHomeParentRepository {
  HomeParentRepository({required this.provider});
  final IHomeParentProvider provider;

  @override
  Future<Response<ServicesParentResponseModel>> getServices()async {
    final apiResponse =
    await provider.getServices();
    print(apiResponse.bodyString);
    if (apiResponse.isOk && apiResponse.body != null&& (apiResponse.statusCode==200) || apiResponse.statusCode==201) {
      return apiResponse;
    } else {
      print(apiResponse.bodyString);
      print(apiResponse.statusCode);
      throw (getErrorMessage(apiResponse.bodyString!));
    }
  }

  @override
  Future<Response<CentersModel>> getCentersWithFilter({required String filter,required List<String> selectedCityIds}) async {
    final apiResponse =
    await provider.getCentersWithFilter(filter: filter,selectedCityIds: selectedCityIds);
    print(apiResponse.bodyString);
    if (apiResponse.isOk && apiResponse.body != null&& (apiResponse.statusCode==200) || apiResponse.statusCode==201) {
      return apiResponse;
    } else {
      print(apiResponse.bodyString);
      print(apiResponse.statusCode);
      throw (getErrorMessage(apiResponse.bodyString!));
    }
  }

  @override
  Future<Response<CitiesModel>> getCities()async {
    final apiResponse =
    await provider.getCities();
    if (apiResponse.isOk && apiResponse.body != null&& (apiResponse.statusCode==200 || apiResponse.statusCode==201)) {
      print("Raw response: ${apiResponse.bodyString}");
      return apiResponse;
    } else {
      print(apiResponse.bodyString);
      print(apiResponse.statusCode);
      throw (getErrorMessage(apiResponse.bodyString!));
    }
  }
}
