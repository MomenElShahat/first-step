// ignore: one_member_abstracts
import 'package:get/get_connect/http/src/response/response.dart';
import '../../../../../base/base_auth_provider.dart';
import '../../../../base/api_end_points.dart';
import '../../../../resources/strings_generated.dart';
import '../../../center/auth/signup/models/cities_model.dart';
import '../../home_parent/models/centers_model.dart';

abstract class ISearchParentProvider {
  Future<Response<NurseryModel>> search({required String keyword});
  Future<Response<List<NurseryModel>>> getLatestCentersResearches();
  Future<Response<CentersModel>> getCentersWithFilter(
      {required String filter, required List<String> selectedCityIds});
  Future<Response<CitiesModel>> getCities();
}

class SearchParentProvider extends BaseAuthProvider implements ISearchParentProvider {

  @override
  Future<Response<NurseryModel>> search({required String keyword}) {
    print("keyword $keyword");

    return get<NurseryModel>(
        EndPoints.searchCentersParent,
        query: {
          "search" : keyword
        },
        decoder: (data) {
          final json = data["data"] as Map<String,dynamic>;
          return NurseryModel.fromJson(json);
        },
    );
  }
  @override
  Future<Response<List<NurseryModel>>> getLatestCentersResearches() {
    return get<List<NurseryModel>>(
      EndPoints.latestSearchParent,
      decoder: (json) {
        final List<dynamic> data = json['message'];
        return data.map((item) => NurseryModel.fromJson(item)).toList();
      },
    );
  }

  @override
  Future<Response<CentersModel>> getCentersWithFilter({
    required String filter,
    required List<String> selectedCityIds,
  }) {
    String? selectedFilter;
    if (filter == AppStrings.nurseriesFrom0To3Years) {
      selectedFilter = "0-3";
    } else if (filter == AppStrings.nurseriesFrom3To6Years) {
      selectedFilter = "3-6";
    } else if (filter == AppStrings.childrenWithSpecialNeeds) {
      selectedFilter = "disabled";
    } else if (filter == AppStrings.all) {
      selectedFilter = null;
    }

    // Build city_id[] parameter
    String? cityParams;
    if (selectedCityIds.isEmpty) {
      cityParams = null; // Required field sent as empty string
    } else {
      cityParams = selectedCityIds.map((id) => 'city_id[]=$id').join('&');
    }

    // Base query parameters
    String baseQuery = "age=$selectedFilter";

    // Combine full URL
    String finalUrl =
        "${EndPoints.centerFilterParent}?${selectedFilter != null ? baseQuery : null}&${cityParams != null ? cityParams : null}";

    print("Final URL: $finalUrl");

    return get<CentersModel>(
      finalUrl,
      decoder: CentersModel.fromJson,
    );
  }

  @override
  Future<Response<CitiesModel>> getCities() {
    return get<CitiesModel>(
      EndPoints.cities,
      decoder: CitiesModel.fromJson,
    );
  }


}
