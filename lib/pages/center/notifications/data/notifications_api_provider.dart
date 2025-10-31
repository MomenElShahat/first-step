// ignore: one_member_abstracts
import 'package:get/get_connect/http/src/response/response.dart';

import '../../../../../base/base_auth_provider.dart';
import '../../../../base/api_end_points.dart';
import '../../../booking_details/model/enrollment_details_model.dart';
import '../../../parent/notifications_parent/model/parent_notifications_model.dart';

abstract class INotificationsProvider {
  Future<Response<List<ParentNotificationsModel>>> getParentNotifications();

  Future<Response<String>> readParentNotifications(String notificationId);

  Future<Response<String>> readAllParentNotifications();

  Future<Response<EnrollmentData>> enrollmentRespond(
      {required String enrollmentId, required String respond});

  Future<Response<EnrollmentData>> updateExistingToPaid({
    required String status,
    required String enrollmentId,
  });
}

class NotificationsProvider extends BaseAuthProvider
    implements INotificationsProvider {
  @override
  Future<Response<List<ParentNotificationsModel>>> getParentNotifications() {
    return get<List<ParentNotificationsModel>>(
      EndPoints.notifications,
      decoder: (data) {
        final jsonList = data as List<dynamic>;
        return jsonList
            .map((e) => ParentNotificationsModel.fromJson(e))
            .toList();
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
  Future<Response<EnrollmentData>> enrollmentRespond(
      {required String enrollmentId, required String respond}) {
    return patch<EnrollmentData>(
        "${EndPoints.parentEnrollmentRequest}/$enrollmentId",
        {"status": respond},
        decoder: EnrollmentData.fromJson);
  }

  @override
  Future<Response<EnrollmentData>> updateExistingToPaid({
    required String status,
    required String enrollmentId,
  }) {
    return put<EnrollmentData>(
      "${EndPoints.parentEnrollmentRequest}/$enrollmentId/${EndPoints.paid}",
      {"status": status},
      decoder: EnrollmentData.fromJson,
    );
  }
}
