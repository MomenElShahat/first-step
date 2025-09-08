
import 'package:first_step/pages/parent/search_parent/data/search_parent_api_provider.dart';
import 'package:get/get_connect/http/src/response/response.dart';

import '../../../../../base/base_repositroy.dart';
import '../../../center/auth/signup/models/cities_model.dart';
import '../../home_parent/models/centers_model.dart';

abstract class ISearchParentRepository {
  Future<Response<NurseryModel>> search({required String keyword});
  Future<Response<List<NurseryModel>>> getLatestCentersResearches();
  Future<Response<CentersModel>> getCentersWithFilter({required String filter,required List<String> selectedCityIds});
  Future<Response<CitiesModel>> getCities();
}

class SearchParentRepository extends BaseRepository implements ISearchParentRepository {
  SearchParentRepository({required this.provider});
  final ISearchParentProvider provider;

  @override
  Future<Response<NurseryModel>> search({required String keyword}) async {
    final apiResponse =
    await provider.search(keyword: keyword);
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
  Future<Response<List<NurseryModel>>> getLatestCentersResearches() async {
    final apiResponse =
    await provider.getLatestCentersResearches();
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
