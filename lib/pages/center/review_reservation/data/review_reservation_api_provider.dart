import 'package:first_step/base/base_auth_provider.dart';
import 'package:get/get_connect/http/src/response/response.dart';

import '../../../../base/api_end_points.dart';
import '../../../booking_details/model/enrollment_details_model.dart';
import '../../control_panel/models/portfolio_prices_model.dart';

abstract class IReviewReservationProvider {
  Future<Response<List<PortfolioPrice>>> showPortfolioPrices(String branchId);
  Future<Response<String>> updateExistingToPaid({
    required String status,
    required String enrollmentId,
    String? dayString,
    String? startingTime,
    String? startingDate,
  });
}

class ReviewReservationProvider extends BaseAuthProvider implements IReviewReservationProvider {
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

  @override
  Future<Response<String>> updateExistingToPaid({
    required String status,
    required String enrollmentId,
    String? dayString,
    String? startingTime,
    String? startingDate,
  }) {
    return put<String>(
      "${EndPoints.parentEnrollmentRequest}/$enrollmentId/${EndPoints.paid}",
      {"status": status,
        if (dayString != null) "day_string": dayString,
        if (startingTime != null) "starting_time": startingTime,
        if (startingDate != null) "starting_date": startingDate,
      },
      decoder: (data) {
        final json = data["message"] as String;
        return json;
      },
    );
  }
}
