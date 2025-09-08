import 'dart:io';

import 'package:get/get_connect/http/src/response/response.dart';

import '../../../../../base/base_repositroy.dart';
import '../models/branch_team_member_model.dart';
import 'edit_member_api_provider.dart';

abstract class IEditMemberRepository {
  Future<Response<BranchTeamMemberModel>> getBranchTeamDetails(String memberId);
  Future<Response<BranchTeamMemberModel>> editBranchTeamDetails({
    required String memberId,
    required String name,
    required String profession,
    File? image,
  });
}

class EditMemberRepository extends BaseRepository implements IEditMemberRepository {
  EditMemberRepository({required this.provider});
  final IEditMemberProvider provider;

  @override
  Future<Response<BranchTeamMemberModel>> getBranchTeamDetails(String memberId) async {
    final apiResponse = await provider.getBranchTeamDetails(memberId);
    print(apiResponse.bodyString);
    if (apiResponse.isOk && apiResponse.body != null && (apiResponse.statusCode == 200) || apiResponse.statusCode == 201) {
      return apiResponse;
    } else {
      print(apiResponse.bodyString);
      print(apiResponse.statusCode);
      throw (getErrorMessage(apiResponse.bodyString!));
    }
  }

  @override
  Future<Response<BranchTeamMemberModel>> editBranchTeamDetails({
    required String memberId,
    required String name,
    required String profession,
    File? image,
  }) async {
    final apiResponse = await provider.editBranchTeamDetails(name: name, memberId: memberId, profession: profession, image: image);
    print(apiResponse.bodyString);
    if (apiResponse.isOk && apiResponse.body != null && (apiResponse.statusCode == 200) || apiResponse.statusCode == 201) {
      return apiResponse;
    } else {
      print(apiResponse.bodyString);
      print(apiResponse.statusCode);
      throw (getErrorMessage(apiResponse.bodyString!));
    }
  }
}
