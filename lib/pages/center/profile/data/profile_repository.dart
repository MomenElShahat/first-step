import 'package:get/get_connect/http/src/response/response.dart';

import '../../../../../base/base_repositroy.dart';
import '../../../parent/profile_parent/model/update_notification_model.dart';
import 'profile_api_provider.dart';

abstract class IProfileRepository {
  Future<Response<UpdateNotificationModel>> updateNotifications({required int receiveNotifications});
}

class ProfileRepository extends BaseRepository implements IProfileRepository {
  ProfileRepository({required this.provider});
  final IProfileProvider provider;

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
