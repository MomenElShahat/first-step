// ignore: one_member_abstracts
import 'package:get/get_connect/http/src/response/response.dart';

import '../../../../../base/base_auth_provider.dart';
import '../../../../base/api_end_points.dart';
import '../../../parent/blog_parent/models/blogs_model.dart';



abstract class IBlogProvider {
  Future<Response<BlogsParentResponseModel>> getBlogs();
}

class BlogProvider extends BaseAuthProvider implements IBlogProvider {
  @override
  Future<Response<BlogsParentResponseModel>> getBlogs() {
    return get<BlogsParentResponseModel>(
        EndPoints.blogsParent,
        decoder: BlogsParentResponseModel.fromJson
    );
  }
}
