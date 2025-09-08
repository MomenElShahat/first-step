import '../../../../base/base_repositroy.dart';
import 'center_free_trail_api_provider.dart';

abstract class ICenterFreeTrailRepository {

}

class CenterFreeTrailRepository extends BaseRepository implements ICenterFreeTrailRepository {
  CenterFreeTrailRepository({required this.provider});

  final ICenterFreeTrailProvider provider;
}
