import 'package:first_step/pages/blog_details/data/blog_details_api_provider.dart';
import '../../../base/base_repositroy.dart';

abstract class IBlogDetailsRepository {}

class BlogDetailsRepository extends BaseRepository implements IBlogDetailsRepository {
  BlogDetailsRepository({required this.provider});

  final IBlogDetailsProvider provider;
}
