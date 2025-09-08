
import '../../../../../base/base_repositroy.dart';
import 'search_api_provider.dart';

abstract class ISearchRepository {}

class SearchRepository extends BaseRepository implements ISearchRepository {
  SearchRepository({required this.provider});
  final ISearchProvider provider;

}
