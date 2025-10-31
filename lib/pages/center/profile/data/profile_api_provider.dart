// ignore: one_member_abstracts
import 'package:get/get_connect/http/src/response/response.dart';

import '../../../../../base/base_auth_provider.dart';
import '../../../../base/api_end_points.dart';
import '../../../parent/profile_parent/model/update_notification_model.dart';

abstract class IProfileProvider {
  Future<Response<UpdateNotificationModel>> updateNotifications({required int receiveNotifications});
}

class ProfileProvider extends BaseAuthProvider implements IProfileProvider {
  @override
  Future<Response<UpdateNotificationModel>> updateNotifications({required int receiveNotifications}) {
    return post<UpdateNotificationModel>(EndPoints.updateReceiveNotification, {"receive_notifications": receiveNotifications},
        decoder: UpdateNotificationModel.fromJson);
  }
}
