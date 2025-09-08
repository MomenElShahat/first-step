import 'package:get/get_connect/http/src/response/response.dart';

import '../../../../../base/base_repositroy.dart';
import '../models/blogs_model.dart';
import 'blog_parent_api_provider.dart';

abstract class IBlogParentRepository {
  Future<Response<BlogsParentResponseModel>> getBlogs();
}

class BlogParentRepository extends BaseRepository implements IBlogParentRepository {
  BlogParentRepository({required this.provider});
  final IBlogParentProvider provider;

  @override
  Future<Response<BlogsParentResponseModel>> getBlogs()async {
    final apiResponse =
    await provider.getBlogs();
    print(apiResponse.bodyString);
    if (apiResponse.isOk && apiResponse.body != null&& (apiResponse.statusCode==200) || apiResponse.statusCode==201) {
      return apiResponse;
    } else {
      print(apiResponse.bodyString);
      print(apiResponse.statusCode);
      throw (getErrorMessage(apiResponse.bodyString!));
    }
  }
}
