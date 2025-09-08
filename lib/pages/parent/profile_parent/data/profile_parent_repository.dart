import 'package:first_step/pages/parent/profile_parent/data/profile_parent_api_provider.dart';

import '../../../../../base/base_repositroy.dart';

abstract class IProfileParentRepository {}

class ProfileParentRepository extends BaseRepository implements IProfileParentRepository {
  ProfileParentRepository({required this.provider});
  final IProfileParentProvider provider;

}
