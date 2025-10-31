import 'package:first_step/pages/parent/profile_parent/data/profile_parent_api_provider.dart';
import 'package:get/get_connect/http/src/response/response.dart';

import '../../../../../base/base_repositroy.dart';
import '../model/update_notification_model.dart';

abstract class IProfileParentRepository {
  Future<Response<UpdateNotificationModel>> updateNotifications({required int receiveNotifications});
}

class ProfileParentRepository extends BaseRepository implements IProfileParentRepository {
  ProfileParentRepository({required this.provider});
  final IProfileParentProvider provider;

  @override
  Future<Response<UpdateNotificationModel>> updateNotifications({required int receiveNotifications}) async {
    final apiResponse = await provider.updateNotifications(receiveNotifications: receiveNotifications);
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
