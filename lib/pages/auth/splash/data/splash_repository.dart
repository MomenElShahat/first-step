import '../../../../base/base_repositroy.dart';
import '../../../../services/auth_service.dart';
import 'splash_api_provider.dart';

abstract class ISplashRepository {}

class SplashRepository extends BaseRepository implements ISplashRepository {
  SplashRepository({required this.provider});
  final ISplashProvider provider;

}
