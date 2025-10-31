// ignore: one_member_abstracts
import 'package:first_step/pages/center/control_panel/models/child_model.dart';
import 'package:first_step/services/auth_service.dart';
import 'package:get/get_connect/http/src/multipart/form_data.dart';
import 'package:get/get_connect/http/src/response/response.dart';

import '../../../../../base/base_auth_provider.dart';
import '../../../../base/api_end_points.dart';
import '../../add_child_parent/model/add_child_request_model.dart';
import '../models/edit_child_request_model.dart';
import '../models/edit_child_response_model.dart';

abstract class IEditChildDetailsProvider {
  Future<Response<ChildModel>> getChildDetails(String childId);

  Future<Response<EditChildResponseModel>> editChild(
      {required AddChildRequestModel addChildRequestModel,
      required String childId});
}

class EditChildDetailsProvider extends BaseAuthProvider
    implements IEditChildDetailsProvider {
  @override
  Future<Response<ChildModel>> getChildDetails(String childId) {
    return get<ChildModel>(
      "${AuthService.to.userInfo?.user?.role == "parent" ? EndPoints.childrenOne : EndPoints.childrenList}/$childId",
      decoder: (data) {
        final json = data["data"] as Map<String,dynamic>;
        return ChildModel.fromJson(json);
      },
    );
  }

  @override
  Future<Response<EditChildResponseModel>> editChild({
    required AddChildRequestModel addChildRequestModel,
    required String childId,
  }) {
    final formData = FormData({});

    // Add _method override for Laravel compatibility
    formData.fields.add(MapEntry('_method', 'PUT'));

    // Helper function to add non-null fields
    void addField(String key, dynamic value) {
      if (value != null) {
        formData.fields.add(MapEntry(key, value.toString()));
      }
    }

    // Basic fields
    addField('child_name', addChildRequestModel.childName);
    addField('birthday_date', addChildRequestModel.birthdayDate);
    addField('gender', addChildRequestModel.gender);
    addField('parent_name', addChildRequestModel.parentName);
    addField('mother_name', addChildRequestModel.motherName);
    addField('recommendations', addChildRequestModel.recommendations);
    addField('things_child_likes', addChildRequestModel.thingsChildLikes);
    addField('description_3_words', addChildRequestModel.description3Words);
    addField('notes', addChildRequestModel.notes);
    addField('allergy', addChildRequestModel.allergy == true ? '1' : '0');
    addField('disease', addChildRequestModel.disease == true ? '1' : '0');

    for (int i = 0;
        i < (addChildRequestModel.authorizedPeople.length ?? 0);
        i++) {
      final authorizedPerson = addChildRequestModel.authorizedPeople[i];
      addField('authorized_people[$i][id]', authorizedPerson.id);
      addField('authorized_people[$i][name]', authorizedPerson.name);
      addField('authorized_people[$i][cin]', authorizedPerson.cin);
    }

    for (int i = 0;
        i < (addChildRequestModel.diseaseDetails.length ?? 0);
        i++) {
      final diseaseDetails = addChildRequestModel.diseaseDetails[i];
      addField('disease_details[$i][disease_name]', diseaseDetails.diseaseName);
      addField('disease_details[$i][medicament]', diseaseDetails.medicament);
      addField('disease_details[$i][emergency]', diseaseDetails.emergency);
    }

    for (int i = 0; i < (addChildRequestModel.allergies.length ?? 0); i++) {
      final allergy = addChildRequestModel.allergies[i];
      addField('allergies[$i][id]', allergy.id);
      addField('allergies[$i][name]', allergy.name);
      addField('allergies[$i][allergy_causes]', allergy.allergyCauses);
      addField('allergies[$i][allergy_emergency]', allergy.allergyEmergency);
    }

    // Debug print
    formData.fields
        .forEach((field) => print('FIELD => ${field.key}: ${field.value}'));

    // Use POST instead of PUT
    return post<EditChildResponseModel>(
      "${EndPoints.childrenParentEdit}/$childId",
      formData,
      decoder: EditChildResponseModel.fromJson,
    );
  }
}
