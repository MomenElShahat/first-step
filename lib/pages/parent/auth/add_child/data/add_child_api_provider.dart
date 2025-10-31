import 'dart:io';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import '../../../../../base/api_end_points.dart';
import '../../../../../base/base_auth_provider.dart';
import '../../../../../resources/strings_generated.dart';
import '../../../../center/control_panel/models/child_model.dart' as child;
import '../../../home_parent/models/centers_model.dart';
import '../../signup_parent/models/signup_parent_response_model.dart';
import '../model/child_request_model.dart';
import '../model/child_response_model.dart';
import '../model/existing_enrollment_request_model.dart';
import '../model/existing_enrollment_response_model.dart';

abstract class IAddChildProvider {
  Future<Response<ChildResponseModel>> addChildren(
      List<ChildRequestModel> children,
      // List<File?> images,
      );
  Future<Response<CentersModel>> getCentersWithFilter(
      {required String filter, required List<String> selectedCityIds});
  Future<Response<List<child.ChildModel>>> getChildren();
  Future<Response<ExistingEnrollmentResponseModel>> sendRequest(ExistingEnrollmentRequestModel model);
}

class AddChildProvider extends BaseAuthProvider implements IAddChildProvider {
  @override
  Future<Response<ChildResponseModel>> addChildren(
      List<ChildRequestModel> children) {
    final formData = FormData({});

    for (var i = 0; i < children.length; i++) {
      final child = children[i];

      // Add text fields
      formData.fields.addAll(child.toFieldMap(i).entries);

      // Add image if available
      final fileEntry = child.toFileMap(i);
      if (fileEntry != null) {
        formData.files.add(fileEntry);
      }
    }

    // Debug prints
    formData.fields.forEach((f) => print('FIELD => ${f.key}: ${f.value}'));
    formData.files.forEach((f) => print('FILE => ${f.key}: ${f.value.filename}'));

    return post<ChildResponseModel>(
      EndPoints.addChildV2,
      formData,
      decoder: ChildResponseModel.fromJson,
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
  Future<Response<List<child.ChildModel>>> getChildren() {
    return get<List<child.ChildModel>>(
      EndPoints.childrenParentList,
      decoder: (data) {
        if (data is List) {
          // normal case: API returned a list of children
          return data.map((e) => child.ChildModel.fromJson(e)).toList();
        } else if (data is Map<String, dynamic>) {
          // case when API wraps result or returns empty object
          if (data["data"] is List) {
            return (data["data"] as List)
                .map((e) => child.ChildModel.fromJson(e))
                .toList();
          }
          return []; // fallback if it's {} or doesn't contain children
        }
        return [];
      },
    );
  }

  @override
  Future<Response<ExistingEnrollmentResponseModel>> sendRequest(ExistingEnrollmentRequestModel model) {
    return post<ExistingEnrollmentResponseModel>(
      EndPoints.enrollmentExisting,
      model.toJson(),
      decoder: ExistingEnrollmentResponseModel.fromJson,
    );
  }

}
