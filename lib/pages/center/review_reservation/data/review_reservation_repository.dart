import 'package:first_step/pages/center/review_reservation/data/review_reservation_api_provider.dart';
import 'package:get/get_connect/http/src/response/response.dart';

import '../../../../base/base_repositroy.dart';
import '../../../booking_details/model/enrollment_details_model.dart';
import '../../control_panel/models/portfolio_prices_model.dart';

abstract class IReviewReservationRepository {
  Future<Response<List<PortfolioPrice>>> showPortfolioPrices(String branchId);

  Future<Response<String>> updateExistingToPaid({
    required String status,
    required String enrollmentId,
    String? dayString,
    String? startingTime,
    String? startingDate,
  });
}

class ReviewReservationRepository extends BaseRepository
    implements IReviewReservationRepository {
  ReviewReservationRepository({required this.provider});

  final IReviewReservationProvider provider;

  @override
  Future<Response<List<PortfolioPrice>>> showPortfolioPrices(
      String branchId) async {
    final apiResponse = await provider.showPortfolioPrices(branchId);
    print(apiResponse.bodyString);
    if (apiResponse.isOk &&
            apiResponse.body != null &&
            (apiResponse.statusCode == 200) ||
        apiResponse.statusCode == 201) {
      return apiResponse;
    } else {
      print(apiResponse.bodyString);
      print(apiResponse.statusCode);
      throw (getErrorMessage(apiResponse.bodyString!));
    }
  }

  @override
  Future<Response<String>> updateExistingToPaid({
    required String status,
    required String enrollmentId,
    String? dayString,
    String? startingTime,
    String? startingDate,
  }) async {
    final apiResponse = await provider.updateExistingToPaid(
        status: status,
        enrollmentId: enrollmentId,
        dayString: dayString,
        startingTime: startingTime,
        startingDate: startingDate);
    print(apiResponse.bodyString);
    if (apiResponse.isOk &&
            apiResponse.body != null &&
            (apiResponse.statusCode == 200) ||
        apiResponse.statusCode == 201) {
      return apiResponse;
    } else {
      print(apiResponse.bodyString);
      print(apiResponse.statusCode);
      throw (getErrorMessage(apiResponse.bodyString!));
    }
  }
}
