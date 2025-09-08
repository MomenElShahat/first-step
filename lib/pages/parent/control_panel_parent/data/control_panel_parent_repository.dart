import 'package:get/get_connect/http/src/response/response.dart';

import '../../../../../base/base_repositroy.dart';
import '../../../center/control_panel/models/chats_model.dart';
import '../../../center/control_panel/models/child_model.dart';
import '../models/daily_reports_model.dart';
import '../models/nurseries_model.dart';
import '../models/parent_enrollments_model.dart';
import 'control_panel_parent_api_provider.dart';

abstract class IControlPanelParentRepository {
  Future<Response<List<ChildModel>>> getChildren();
  Future<Response<List<NurseriesModel>>> getNurseries();
  Future<Response<String>> deleteChild(String childId);
  Future<Response<List<Contacts>>> getChats();
  Future<Response<DailyReportsModel>> getDailyReports();
}

class ControlPanelParentRepository extends BaseRepository implements IControlPanelParentRepository {
  ControlPanelParentRepository({required this.provider});
  final IControlPanelParentProvider provider;

  @override
  Future<Response<List<ChildModel>>> getChildren() async {
    final apiResponse = await provider.getChildren();
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
  Future<Response<List<Contacts>>> getChats() async {
    final apiResponse = await provider.getChats();
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
  Future<Response<List<NurseriesModel>>> getNurseries() async {
    final apiResponse = await provider.getNurseries();
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
  Future<Response<DailyReportsModel>> getDailyReports() async {
    final apiResponse = await provider.getDailyReports();
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
  Future<Response<String>> deleteChild(String childId) async {
    final apiResponse = await provider.deleteChild(childId);
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
