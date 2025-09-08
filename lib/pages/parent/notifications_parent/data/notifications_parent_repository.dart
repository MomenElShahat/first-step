import 'package:get/get_connect/http/src/response/response.dart';

import '../../../../../base/base_repositroy.dart';
import '../model/parent_notifications_model.dart';
import 'notifications_parent_api_provider.dart';

abstract class INotificationsParentRepository {
  Future<Response<List<ParentNotificationsModel>>> getParentNotifications();
  Future<Response<String>> readParentNotifications(String notificationId);
  Future<Response<String>> readAllParentNotifications();
}

class NotificationsParentRepository extends BaseRepository implements INotificationsParentRepository {
  NotificationsParentRepository({required this.provider});
  final INotificationsParentProvider provider;

  @override
  Future<Response<List<ParentNotificationsModel>>> getParentNotifications() async {
    final apiResponse = await provider.getParentNotifications();
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
  Future<Response<String>> readParentNotifications(String notificationId) async {
    final apiResponse = await provider.readParentNotifications(notificationId);
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
  Future<Response<String>> readAllParentNotifications() async {
    final apiResponse = await provider.readAllParentNotifications();
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
