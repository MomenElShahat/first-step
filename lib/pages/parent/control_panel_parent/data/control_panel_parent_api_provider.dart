// ignore: one_member_abstracts
import 'package:get/get_connect/http/src/response/response.dart';

import '../../../../../base/base_auth_provider.dart';
import '../../../../base/api_end_points.dart';
import '../../../center/control_panel/models/chats_model.dart';
import '../../../center/control_panel/models/child_model.dart';
import '../models/daily_reports_model.dart';
import '../models/nurseries_model.dart';
import '../models/parent_enrollments_model.dart';

abstract class IControlPanelParentProvider {
  Future<Response<List<ChildModel>>> getChildren();
  Future<Response<List<NurseriesModel>>> getNurseries();
  Future<Response<List<Contacts>>> getChats();
  Future<Response<DailyReportsModel>> getDailyReports();
  Future<Response<String>> deleteChild(String childId);
}

class ControlPanelParentProvider extends BaseAuthProvider implements IControlPanelParentProvider {
  @override
  Future<Response<List<ChildModel>>> getChildren() {
    return get<List<ChildModel>>(
      EndPoints.childrenParentList,
      decoder: (data) {
        final jsonList = data as List<dynamic>;
        return jsonList.map((e) => ChildModel.fromJson(e)).toList();
      },
    );
  }

  @override
  Future<Response<List<NurseriesModel>>> getNurseries() {
    return get<List<NurseriesModel>>(
      EndPoints.getCentersParent,
      decoder: (data) {
        final jsonList = data as List<dynamic>;
        return jsonList.map((e) => NurseriesModel.fromJson(e)).toList();
      },
    );
  }

  @override
  Future<Response<List<Contacts>>> getChats() {
    return get<List<Contacts>>(
      EndPoints.chatContacts,
      decoder: (data) {
        final jsonList = data as List<dynamic>;
        return jsonList.map((e) => Contacts.fromJson(e)).toList();
      },
    );
  }


  @override
  Future<Response<DailyReportsModel>> getDailyReports() {
    return get<DailyReportsModel>(
      EndPoints.parentDailyReports,
      decoder: DailyReportsModel.fromJson,
    );
  }



  @override
  Future<Response<String>> deleteChild(String childId) {
    return delete<String>(
      "${EndPoints.childrenParentList}/$childId",
      decoder: (data) {
        var message = data["message"];
        return message;
      },
    );
  }
}
