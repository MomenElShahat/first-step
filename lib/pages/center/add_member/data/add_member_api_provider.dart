// ignore: one_member_abstracts
import 'dart:io';

import 'package:get/get_connect/http/src/multipart/form_data.dart';
import 'package:get/get_connect/http/src/multipart/multipart_file.dart';
import 'package:get/get_connect/http/src/response/response.dart';

import '../../../../../base/base_auth_provider.dart';
import '../../../../base/api_end_points.dart';
import '../../edit_member/models/branch_team_member_model.dart';

abstract class IAddMemberProvider {
  Future<Response<BranchTeamMemberModel>> addMember({required String name, required String profession, required String branchId, File? image});
}

class AddMemberProvider extends BaseAuthProvider implements IAddMemberProvider {
  @override
  Future<Response<BranchTeamMemberModel>> addMember({required String branchId, required String name, required String profession, File? image}) {
    final formData = FormData({});

    // Helper function to add non-null fields
    void addField(String key, dynamic value) {
      if (value != null) {
        formData.fields.add(MapEntry(key, value.toString()));
      }
    }

    // Basic fields
    addField('name', name);
    addField('profession', profession);
    addField('branch_id', branchId);
    if (image != null) {
      formData.files.add(MapEntry(
        'image',
        MultipartFile(image, filename: image.path.split('/').last),
      ));
    }
    formData.fields.forEach((field) => print('FIELD => ${field.key}: ${field.value}'));

    return post<BranchTeamMemberModel>(
      EndPoints.branchTeamMembers,
      formData,
      decoder: BranchTeamMemberModel.fromJson,
    );
  }
}
