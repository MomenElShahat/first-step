import 'package:get/get_connect/http/src/response/response.dart';

import '../../../../../base/base_repositroy.dart';
import '../../../center/control_panel/models/branch_team_model.dart';
import '../../../center/control_panel/models/portfolio_prices_model.dart';
import '../models/center_portfolio_model.dart';
import 'center_details_parent_api_provider.dart';

abstract class ICenterDetailsParentRepository {
  Future<Response<CenterPortfolioModel>> getCenterPortfolio(String centerId);
  Future<Response<List<PortfolioPrice>>> showPortfolioPrices(String branchId);
}

class CenterDetailsParentRepository extends BaseRepository implements ICenterDetailsParentRepository {
  CenterDetailsParentRepository({required this.provider});
  final ICenterDetailsParentProvider provider;
  @override
  Future<Response<CenterPortfolioModel>> getCenterPortfolio(String centerId) async {
    final apiResponse = await provider.getCenterPortfolio(centerId);
    print(apiResponse.bodyString);
    if (apiResponse.isOk && apiResponse.body != null && (apiResponse.statusCode == 200) || apiResponse.statusCode == 201) {
      return apiResponse;
    } else {
      print(apiResponse.bodyString);
      print(apiResponse.statusCode);
      throw (getErrorMessage(apiResponse.bodyString!));
    }
  }

  @override
  Future<Response<List<PortfolioPrice>>> showPortfolioPrices(String branchId) async {
    final apiResponse = await provider.showPortfolioPrices(branchId);
    print(apiResponse.bodyString);
    if (apiResponse.isOk && apiResponse.body != null && (apiResponse.statusCode == 200) || apiResponse.statusCode == 201) {
      return apiResponse;
    } else {
      print(apiResponse.bodyString);
      print(apiResponse.statusCode);
      throw (getErrorMessage(apiResponse.bodyString!));
    }
  }
}
