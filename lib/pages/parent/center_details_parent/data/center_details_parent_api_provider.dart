// ignore: one_member_abstracts
import 'package:get/get_connect/http/src/response/response.dart';

import '../../../../../base/base_auth_provider.dart';
import '../../../../base/api_end_points.dart';
import '../../../center/control_panel/models/branch_team_model.dart';
import '../../../center/control_panel/models/portfolio_prices_model.dart';
import '../models/center_portfolio_model.dart';

abstract class ICenterDetailsParentProvider {
  Future<Response<CenterPortfolioModel>> getCenterPortfolio(String centerId);
  Future<Response<List<PortfolioPrice>>> showPortfolioPrices(String branchId);
}

class CenterDetailsParentProvider extends BaseAuthProvider implements ICenterDetailsParentProvider {
  @override
  Future<Response<CenterPortfolioModel>> getCenterPortfolio(String centerId) {
    return get<CenterPortfolioModel>(
      "${EndPoints.getPortfiloCenter}/$centerId",
      decoder: CenterPortfolioModel.fromJson,
    );
  }

  @override
  Future<Response<List<PortfolioPrice>>> showPortfolioPrices(String branchId) {
    return get<List<PortfolioPrice>>(
      "${EndPoints.branchesPricies}/$branchId",
      decoder: (data) {
        final jsonList = data["data"] as List<dynamic>;
        return jsonList.map((e) => PortfolioPrice.fromJson(e)).toList();
      },
    );
  }
}
