// ignore: one_member_abstracts
import 'package:get/get_connect/http/src/response/response.dart';

import '../../../../../base/base_auth_provider.dart';
import '../../../../base/api_end_points.dart';
import '../../child_reservations/model/cancel_response_model.dart';
import '../model/parent_notifications_model.dart';

abstract class INotificationsParentProvider {
  Future<Response<List<ParentNotificationsModel>>> getParentNotifications();
  Future<Response<String>> readParentNotifications(String notificationId);
  Future<Response<String>> readAllParentNotifications();
  Future<Response<CancelResponseModel>> enrollmentRespond(String enrollmentId);
}

class NotificationsParentProvider extends BaseAuthProvider implements INotificationsParentProvider {
  @override
  Future<Response<List<ParentNotificationsModel>>> getParentNotifications() {
    return get<List<ParentNotificationsModel>>(
      EndPoints.notifications,
      decoder: (data) {
        final jsonList = data as List<dynamic>;
        return jsonList.map((e) => ParentNotificationsModel.fromJson(e)).toList();
      },
    );
  }

  @override
  Future<Response<String>> readParentNotifications(String notificationId) {
    return patch<String>(
      "${EndPoints.notifications}/$notificationId/${EndPoints.read}",
      {},
      decoder: (data) {
        final jsonList = data["message"] as String;
        return jsonList;
      },
    );
  }

  @override
  Future<Response<String>> readAllParentNotifications() {
    return patch<String>(
      "${EndPoints.notifications}/${EndPoints.readAll}",
      {},
      decoder: (data) {
        final jsonList = data["message"] as String;
        return jsonList;
      },
    );
  }

  @override
  Future<Response<CancelResponseModel>> enrollmentRespond(String enrollmentId) {
    return post<CancelResponseModel>("${EndPoints.parentEnrollments}$enrollmentId${EndPoints.cancelEnrollmentParent}", {},
        decoder: CancelResponseModel.fromJson);
  }
}
