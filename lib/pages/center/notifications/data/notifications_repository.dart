import '../../../../../base/base_repositroy.dart';
import 'notifications_api_provider.dart';

abstract class INotificationsRepository {}

class NotificationsRepository extends BaseRepository implements INotificationsRepository {
  NotificationsRepository({required this.provider});
  final INotificationsProvider provider;

}
