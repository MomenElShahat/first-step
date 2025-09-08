import '../../../../base/base_repositroy.dart';
import '../../../../services/auth_service.dart';
import 'type_selection_api_provider.dart';

abstract class ITypeSelectionRepository {}

class TypeSelectionRepository extends BaseRepository implements ITypeSelectionRepository {
  TypeSelectionRepository({required this.provider});
  final ITypeSelectionProvider provider;

}
