import '../../../../base/base_repositroy.dart';
import 'choose_parents_api_provider.dart';

abstract class IChooseParentsRepository {

}

class ChooseParentsRepository extends BaseRepository implements IChooseParentsRepository {
  ChooseParentsRepository({required this.provider});

  final IChooseParentsProvider provider;
}
