// ignore: one_member_abstracts
import 'package:get/get_connect/http/src/response/response.dart';

import '../../../../../base/base_auth_provider.dart';



abstract class IProfileProvider {}

class ProfileProvider extends BaseAuthProvider implements IProfileProvider {}
