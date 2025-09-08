import 'dart:io';

import 'package:get/get_connect/http/src/response/response.dart';

import '../../../../../base/base_repositroy.dart';
import '../../edit_member/models/branch_team_member_model.dart';
import 'add_member_api_provider.dart';

abstract class IAddMemberRepository {
  Future<Response<BranchTeamMemberModel>> addMember({required String name, required String profession, required String branchId, File? image});
}

class AddMemberRepository extends BaseRepository implements IAddMemberRepository {
  AddMemberRepository({required this.provider});

  final IAddMemberProvider provider;

  @override
  Future<Response<BranchTeamMemberModel>> addMember({required String name, required String profession, required String branchId, File? image}) async {
    final apiResponse = await provider.addMember(name: name, branchId: branchId, profession: profession, image: image);
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
