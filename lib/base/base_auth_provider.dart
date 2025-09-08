import 'api_end_points.dart';
import 'base_provider.dart';

class BaseAuthProvider extends BaseProvider {
  @override
  void onInit() {
    super.onInit() ;
    httpClient.baseUrl = EndPoints.baseURl;
    httpClient.timeout = const Duration(minutes: 10);
  }
}
