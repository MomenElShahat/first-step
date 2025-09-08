
import 'package:get/get_connect/http/src/response/response.dart';

import '../../../../../base/base_repositroy.dart';
import '../models/signup_parent_request_model.dart';
import '../models/signup_parent_response_model.dart';
import 'signup_parent_api_provider.dart';

abstract class ISignupParentRepository {
}

class SignupParentRepository extends BaseRepository implements ISignupParentRepository {
  SignupParentRepository({required this.provider});
  final ISignupParentProvider provider;
}
