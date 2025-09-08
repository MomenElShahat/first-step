// ignore: one_member_abstracts
import 'package:first_step/resources/strings_generated.dart';
import 'package:get/get_connect/http/src/response/response.dart';

import '../../../../../base/base_auth_provider.dart';
import '../../../../base/api_end_points.dart';
import '../../../center/auth/signup/models/cities_model.dart';
import '../models/centers_model.dart';
import '../models/services_model.dart';

abstract class IHomeParentProvider {
  Future<Response<ServicesParentResponseModel>> getServices();

  Future<Response<CentersModel>> getCentersWithFilter(
      {required String filter, required List<String> selectedCityIds});

  Future<Response<CitiesModel>> getCities();
}

class HomeParentProvider extends BaseAuthProvider
    implements IHomeParentProvider {
  @override
  Future<Response<ServicesParentResponseModel>> getServices() {
    return get<ServicesParentResponseModel>(EndPoints.servicesParent,
        decoder: ServicesParentResponseModel.fromJson);
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
