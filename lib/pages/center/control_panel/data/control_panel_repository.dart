import 'package:first_step/pages/center/control_panel/models/center_info_model.dart';
import 'package:first_step/pages/center/control_panel/models/child_model.dart';
import 'package:first_step/pages/center/control_panel/models/portfolio_response_model.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';

import '../../../../../base/base_repositroy.dart';
import '../../../booking_details/model/enrollment_details_model.dart';
import '../../../parent/control_panel_parent/models/daily_reports_model.dart';
import '../../edit_member/models/branch_team_member_model.dart';
import '../models/branch_model.dart';
import '../models/branch_team_model.dart';
import '../models/center_enrollment_model.dart';
import '../models/chats_model.dart';
import '../models/parent_model.dart';
import '../models/portfolio_prices_model.dart';
import '../models/show_portfolio_response_model.dart';
import '../models/statistics_model.dart';
import 'control_panel_api_provider.dart';

abstract class IControlPanelRepository {
  Future<Response<List<BranchModel>>> getBranches();
  Future<Response<List<ParentModel>>> getParents();
  Future<Response<List<Contacts>>> getChats();
  Future<Response<List<ChildModel>>> getChildren();
  Future<Response<BranchModel>> getBranchDetails(String branchId);
  Future<Response<StatisticsModel>> getStatistics();
  Future<Response<BranchTeamMemberModel>> deleteMember(String memberId);
  Future<Response<String>> deleteBranch(String branchId);
  Future<Response<BranchTeamModel>> getBranchTeam(String branchId);
  Future<Response<DailyReportsModel>> getDailyReports();
  Future<Response<CenterEnrollmentsModel>> getEnrollments();
  Future<Response<EnrollmentData>> enrollmentRespond({required String enrollmentId, required String respond});
  Future<Response<PortfolioResponseModel>> updatePortfolio({String? centerId, required FormData formData, required bool isUpdate});
  Future<Response<ShowPortfolioResponseModel>> showPortfolio();
  Future<Response<List<PortfolioPrice>>> showPortfolioPrices(String branchId);
  // Future<Response<String>> updatePortfolioPrices(
  //     {required String branchId, required PortfolioPricesModel hourly, required PortfolioPricesModel daily, required PortfolioPricesModel monthly});
  Future<Response<String>> createPortfolioPrices(
      {required String branchId, required List<PortfolioPrice> portfolioPrice});
}

class ControlPanelRepository extends BaseRepository implements IControlPanelRepository {
  ControlPanelRepository({required this.provider});
  final IControlPanelProvider provider;

  @override
  Future<Response<List<BranchModel>>> getBranches() async {
    final apiResponse = await provider.getBranches();
    print(apiResponse.bodyString);
    if (apiResponse.isOk && apiResponse.body != null && (apiResponse.statusCode == 200) || apiResponse.statusCode == 201) {
      return apiResponse;
    } else {
      print(apiResponse.bodyString);
      print(apiResponse.statusCode);
      throw (getErrorMessage(apiResponse.bodyString!));
    }
  }
  //
  // @override
  // Future<Response<String>> updatePortfolioPrices(
  //     {required String branchId,
  //     required PortfolioPricesModel hourly,
  //     required PortfolioPricesModel daily,
  //     required PortfolioPricesModel monthly}) async {
  //   final apiResponse = await provider.updatePortfolioPrices(branchId: branchId, daily: daily, hourly: hourly, monthly: monthly);
  //   print(apiResponse.bodyString);
  //   if (apiResponse.isOk && apiResponse.body != null && (apiResponse.statusCode == 200) || apiResponse.statusCode == 201) {
  //     return apiResponse;
  //   } else {
  //     print(apiResponse.bodyString);
  //     print(apiResponse.statusCode);
  //     throw (getErrorMessage(apiResponse.bodyString!));
  //   }
  // }

  @override
  Future<Response<String>> createPortfolioPrices(
      {required String branchId,
        required List<PortfolioPrice> portfolioPrice}) async {
    final apiResponse = await provider.createPortfolioPrices(branchId: branchId, portfolioPrice: portfolioPrice);
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
  Future<Response<ShowPortfolioResponseModel>> showPortfolio() async {
    final apiResponse = await provider.showPortfolio();
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

  @override
  Future<Response<PortfolioResponseModel>> updatePortfolio(
      {String? centerId, required FormData formData, required bool isUpdate}) async {
    final apiResponse = await provider.updatePortfolio(formData: formData, centerId: centerId, isUpdate: isUpdate);
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
  Future<Response<DailyReportsModel>> getDailyReports() async {
    final apiResponse = await provider.getDailyReports();
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
  Future<Response<List<ParentModel>>> getParents() async {
    final apiResponse = await provider.getParents();
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
  Future<Response<List<Contacts>>> getChats() async {
    final apiResponse = await provider.getChats();
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
  Future<Response<List<ChildModel>>> getChildren() async {
    final apiResponse = await provider.getChildren();
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
  Future<Response<BranchModel>> getBranchDetails(String branchId) async {
    final apiResponse = await provider.getBranchDetails(branchId);

    if (apiResponse.isOk && apiResponse.body != null && (apiResponse.statusCode == 200 || apiResponse.statusCode == 201)) {
      final firstBranch = apiResponse.body!;
      return Response(
        body: firstBranch,
        statusCode: apiResponse.statusCode,
        request: apiResponse.request,
        statusText: apiResponse.statusText,
      );
    } else {
      throw getErrorMessage(apiResponse.bodyString ?? "Unknown error");
    }
  }

  @override
  Future<Response<StatisticsModel>> getStatistics() async {
    final apiResponse = await provider.getStatistics();
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
  Future<Response<BranchTeamMemberModel>> deleteMember(String memberId) async {
    final apiResponse = await provider.deleteMember(memberId);
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
  Future<Response<String>> deleteBranch(String branchId) async {
    final apiResponse = await provider.deleteBranch(branchId);
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
  Future<Response<BranchTeamModel>> getBranchTeam(String branchId) async {
    final apiResponse = await provider.getBranchTeam(branchId);
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
  Future<Response<CenterEnrollmentsModel>> getEnrollments() async {
    final apiResponse = await provider.getEnrollments();
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
  Future<Response<EnrollmentData>> enrollmentRespond({required String enrollmentId, required String respond}) async {
    final apiResponse = await provider.enrollmentRespond(enrollmentId: enrollmentId, respond: respond);
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
