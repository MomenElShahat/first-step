import '../../../../base/base_repositroy.dart';
import '../../../../services/auth_service.dart';
import 'onboarding_api_provider.dart';

abstract class IOnboardingRepository {}

class OnboardingRepository extends BaseRepository implements IOnboardingRepository {
  OnboardingRepository({required this.provider});
  final IOnboardingProvider provider;

}
