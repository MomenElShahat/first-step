
import '../../../../../base/base_repositroy.dart';
import 'profile_api_provider.dart';

abstract class IProfileRepository {}

class ProfileRepository extends BaseRepository implements IProfileRepository {
  ProfileRepository({required this.provider});
  final IProfileProvider provider;

}
