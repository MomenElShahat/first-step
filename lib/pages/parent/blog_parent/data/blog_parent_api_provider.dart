// ignore: one_member_abstracts
import 'package:get/get_connect/http/src/response/response.dart';

import '../../../../../base/base_auth_provider.dart';
import '../../../../base/api_end_points.dart';
import '../models/blogs_model.dart';



abstract class IBlogParentProvider {
  Future<Response<BlogsParentResponseModel>> getBlogs();
}

class BlogParentProvider extends BaseAuthProvider implements IBlogParentProvider {
  @override
  Future<Response<BlogsParentResponseModel>> getBlogs() {
    return get<BlogsParentResponseModel>(
        EndPoints.blogsParent,
        decoder: BlogsParentResponseModel.fromJson
    );
  }
}
