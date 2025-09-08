import 'package:first_step/pages/faq/data/faq_api_provider.dart';
import '../../../base/base_repositroy.dart';

abstract class IFaqRepository {

}

class FaqRepository extends BaseRepository implements IFaqRepository {
  FaqRepository({required this.provider});

  final IFaqProvider provider;
}
